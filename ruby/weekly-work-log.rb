#!/usr/bin/env ruby

# This is a utility I use for tracking work I did over the past few weeks
# You'll want to chmod +x ./weekly-work-log.rb or prefix the commands with ruby

# Usage: ./weekly-work-log.rb
# Configure: ./weekly-work-log.rb Sep-08-2017 Tyler

require "date"

configured_date = ARGV[0] ? Date.parse(ARGV[0]) : Date.today.prev_month
configured_author = ARGV[1] || "Tyler"

group_dates = (configured_date .. Date.today).uniq { |date| date.cweek }
group_dates.each_with_index do |date, index|
  next if index == 0  # needs to be between two dates

  puts "Commits between: #{group_dates[index - 1].strftime('%^b %-d %Y')} .. #{date.strftime('%^b %-d %Y')}"
  puts `git log --since "#{group_dates[index - 1].strftime('%^b %-d %Y')}" --until "#{date.strftime('%^b %-d %Y')}" --format="%Cgreen%h%Creset %C(yellow)%aN%Creset: %s" --author="#{configured_author}"`
  puts '-------------'
end
