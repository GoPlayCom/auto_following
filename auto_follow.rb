require 'watir'
require_relative 'account'

if File.file?("ignor.txt")
  puts "ignor file exist."
else
  puts "ignor file not found."
  sleep(1)
  puts "Creating..."
  sleep(1)
  file = File.new("ignor.txt", "w+")
  puts "Successful."
  sleep(1)
end

username = $username
password = $password
ignor_users = []
users = []
users_count = 0
ignor_count = 0
time = Time.now
puts "Follow delay sec."
sl = gets.to_i

browser = Watir::Browser.new :chrome
browser.goto "instagram.com/accounts/login"

#browser.window.maximize

puts "Logging in..."
browser.text_field(:name => 'username').set "#{username}"
browser.text_field(:name => 'password').set "#{password}"

browser.button(:class => '_0mzm- sqdOP  L3NKy       ').click
sleep(3)

File.readlines("ignor.txt").each { |line|
  ignor_users << line
}
File.readlines("users.txt").each { |line|
  users << line
}

ign = users & ignor_users
ignor_count = ign.size

users -= ignor_users

if browser.button(:class => '_5f5mN       jIbKX KUBKM      yZn4P   ').exist?
  browser.button(:class => '_5f5mN       jIbKX KUBKM      yZn4P   ').click
  print "Security code: "
  security_code = gets.chomp
  browser.text_field(:name => 'security_code').set security_code
  browser.button(:class => '_5f5mN       jIbKX KUBKM      yZn4P   ').click
  sleep(5)
end

users.each { |user|

  File.open("ignor.txt", "a") {
    |file| file.puts(user)
  }

  browser.goto "instagram.com/#{user}/"

  if browser.button(:class => '_5f5mN       jIbKX  _6VtSN     yZn4P   ').exists?
    puts "Following #{user}"
    browser.button(:class => '_5f5mN       jIbKX  _6VtSN     yZn4P   ').click
    users_count += 1
  elsif browser.button(:class => 'BY3EC  _0mzm- sqdOP  L3NKy       ').exists?
    puts "Following #{user}"
    browser.button(:class => 'BY3EC  _0mzm- sqdOP  L3NKy       ').click
    users_count += 1
  end
  sleep(sl)
}
puts "--------INFO--------"
puts "----- #{time.strftime("%H:%M:%S")} -----"
puts "Follow: +#{users_count}."
puts "Ignored: #{ignor_count}."
puts "----- #{(Time.now).strftime("%H:%M:%S")} -----"

#Unfollowing
#elsif browser.button(:class => '_5f5mN    -fzfL     _6VtSN     yZn4P   ').exists?
#puts "Unfollowing #{user}"
#browser.button(:class => '_5f5mN    -fzfL     _6VtSN     yZn4P   ').click
#browser.button(:class => 'aOOlW -Cab_   ').click*/

#'BY3EC  _0mzm- sqdOP  L3NKy       ' private following
#' ffKix _0mzm- sqdOP  L3NKy   _8A5w5    ' private unfollowing 1
