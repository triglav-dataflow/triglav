require_relative 'client'
require 'parallel'
require 'optparse'
params = ARGV.getopts('p:n:')

num_parallels = Integer(params['p'] || 2)
num_times = Integer(params['n'] || 10)
puts "num_parallels: #{num_parallels}, num_times: #{num_times}"

client = Client.new
sample_event = {
  resource_uri: "hdfs://host:port/path/to/resource",
  resource_unit: 'daily',
  resource_time: Time.now.to_i,
  resource_timezone: "+09:00",
  payload: {free: "text"}.to_json,
}
events = [sample_event]

started = Time.now
Parallel.each(1..num_parallels, in_processes: num_parallels) do |i|
  num_times.times do
    client.send_messages(events)
  end
end
elapsed = Time.now - started
puts "elapsed: #{elapsed.to_f}sec"
