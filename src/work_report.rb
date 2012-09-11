require 'work_entry'

class WorkReport
  
  def list
    project_names = {}
    WorkEntry.find(:all).each { |work_entry|
      project_names[work_entry.project_name] = ""
    }
    
    puts
    project_names.each { |project_name,empty_value|
      puts project_name
    }
    puts
  end
  
  def report(project_name)
    if (project_name == nil or project_name == "")
      project_name = last_activated_project
    end
      
    
    WorkEntry.find(:all, :conditions => ["project_name == \"#{project_name}\""]).each { |work_entry|
      puts work_entry.project_name
      
      if (not work_entry.end_time.nil?)
        time_spent_working = ((work_entry.end_time - work_entry.start_time)/60).round
        puts "spent #{time_spent_working} minutes on..."
      end
      
      puts work_entry.comment
      pretty_print_calendar(work_entry.start_time)
      puts
    }
    
  end
  
  def pretty_print_calendar(start_time)
    week_start = start_time.at_beginning_of_week.day
    month_days = start_time.at_end_of_month.day
    puts "  M   T   W   T   F   S   S "
    puts " --- --- --- --- --- --- ---"
    print "|"
    7.times { |x|
      if (week_start + x == start_time.day or week_start + x == start_time.day + month_days)
        print " X |"
      else
        print "   |"
      end
    }
    puts
    puts " --- --- --- --- --- --- ---"
  end

  def last_activated_project
    return WorkEntry.find(:last).project_name
  end
end