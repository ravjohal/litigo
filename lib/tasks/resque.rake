require 'resque/tasks'
# require 'resque_scheduler/tasks'
require 'resque/scheduler/tasks'


task 'resque:setup' => :environment do
  Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
  #ENV['QUEUE'] = '*'
end

task 'resque:scheduler_setup' => :environment
task 'resque:scheduler_setup' => :setup do
  require 'resque/scheduler'
  Resque.schedule = YAML.load_file(Rails.root.join('config/rescue_schedule.yml'))
end
task 'resque:scheduler' => 'resque:scheduler_setup'

desc 'Alias for resque:work (To run workers on Heroku)'
task 'jobs:work' => 'resque:work'