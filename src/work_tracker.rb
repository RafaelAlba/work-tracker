#!/usr/bin/ruby

if (ARGV.nil? or (ARGV.size != 2 and ARGV.size != 1))
  puts "usage: track start 'project name'"
  puts "or"
  puts "usage: track end 'comment' "
  puts "or"
  puts "usage: track report"
  exit
end

require 'rubygems'
require 'sqlite3'
require 'active_record'
require 'work_entry'
require 'work_report'

if (ARGV[0] == "start")
  WorkEntry.create(:comment => '', :project_name => ARGV[1], :start_time => DateTime.now)
elsif (ARGV[0] == "end")
  last_entry = WorkEntry.find(:last)
  last_entry.end_time = DateTime.now
  last_entry.comment = ARGV[1]
  last_entry.save
elsif (ARGV[0] == "report")
  work_report = WorkReport.new
  work_report.report(ARGV[1])
elsif (ARGV[0] == "list")
  work_report = WorkReport.new
  work_report.list
else
  puts "invalid action: #{ARGV[0]}"
end
