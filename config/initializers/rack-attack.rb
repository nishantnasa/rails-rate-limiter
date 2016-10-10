class Rack::Attack
  
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new 

  ### Throttle Spammy Clients ###

  # If any single client IP is making tons of requests, then they're
  # probably malicious or a poorly-configured scraper. Either way, they
  # don't deserve to hog all of the app server's CPU. Cut them off!
  throttle('req/ip', :limit => 100, :period => 60.minutes) do |req|
    req.ip
  end
  
  def self.throttled_response
    lambda do |env|
      [ 429, { 'Retry-After' => env['rack.attack.match_data'][:period] }, ["Too many requests. Please try again later after #{env['rack.attack.match_data'][:period] / 60} minutes."]]
    end
  end
end