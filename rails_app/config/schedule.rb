# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

ENV.each { |k, v| env(k, v) }
set :environment, ENV["RAILS_ENV"]

job_type :runner,  "cd :path && bin/rails runner -e :environment ':task' :output"

every 6.hour do
  path = "/var/log/cron/update_currencies"
  runner "UpdateCurrenciesJob.perform_now", output: {:standard => "#{path}.log", :error => "#{path}_error.log"}
end
