#!/usr/bin/env ruby
require_relative 'methods.rb'
require "httparty"

$api_key = "5f0ddd7f-7c30-4eec-bf0b-a1d02fdf9551"
$sleep = 0.05

$words = []

Methods.new.LoadingPrompt("Program Starting",12)

credits = [
  "\n\nUnscrabblah!",
  "Version: 2.0",
  "Written by: Aaron Pena",
  "Tested by: Yvette Berlanga",
  "Website: https://webdataiot.com",
  "Email: aaron@webdataiot.com",
  "\n"
]

credits.each do |credit|
  puts credit
  sleep $sleep
end

Methods.new.StartProgram()