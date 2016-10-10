require 'rails_helper'
require 'rack/test'
APP = Rack::Builder.parse_file('config.ru').first

describe 'Throttling URLs' do
  include Rack::Test::Methods

  def app
    APP
  end

  let(:limit) { 100 }
  let(:period) { 3600 }

  context 'when the number of requests are higher than the limit' do
    before do
      (limit * 2).times do
        get '/home/index', {}, 'REMOTE_ADDR' => '1.2.3.4'
      end
    end

    it 'returns the custom body message' do
      expect(last_response.body).to eq('Too many requests. '\
        "Please try again later after #{period / 60} minutes.")
    end

    it 'includes the Reply-After header' do
      expect(last_response.header['Retry-After']).to eq(period)
    end

    it 'returns a 429 status code' do
      expect(last_response.status).to eq(429)
    end
  end

  context 'when the number of requests are lower than the limit' do
    before do
      get '/home/index', {}, 'REMOTE_ADDR' => '1.2.3.5'
    end

    it "doesn't return the custom body message" do
      expect(last_response.body).not_to eq('Too many requests. '\
        "Please try again later after #{period / 60} minutes.")
    end

    it "doesn't include the Reply-After header" do
      expect(last_response.header['Retry-After']).to be_nil
    end

    it 'returns a 200 status code' do
      expect(last_response.status).to eq(200)
    end
  end
end
