mode = ENV['WORK_TRACKER_MODE'] 

if (mode == "prod")
ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database  => "/Users/ralba/workspace/work-tracker/src/data/freelance-tracker.sqlite"
)
else
ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.colorize_logging = false

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database  => "/Users/ralba/workspace/work-tracker/src/data/freelance-tracker-test.sqlite"
)
end


class WorkEntry < ActiveRecord::Base
  
end
