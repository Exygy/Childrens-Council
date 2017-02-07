if Rails.env.production?
  Rack::Timeout.service_timeout = 5
  Rack::Timeout.wait_timeout = 5
  Rack::Timeout.wait_overtime = 5
end
