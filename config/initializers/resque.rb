if Rails.env.staging? || Rails.env.production?
  uri = URI.parse ENV['REDISTOGO_URL']
  Resque.redis = Redis.new :host => uri.host, :port => uri.port, :password => uri.password
end

#Dir["/app/app/workers/*.rb"].each { |file| require file }

require 'resque/scheduler'
Resque.schedule = YAML.load_file(Rails.root.join('config/rescue_schedule.yml'))

require 'resque-scheduler'
require 'resque/scheduler/server'