require_relative 'client'
require 'parallel'
require 'optparse'
params = ARGV.getopts('p:d:u:')

num_parallels = Integer(params['p'] || 2)
duration = Integer(params['d'] || 1)
triglav_url = params['u'] || 'http://localhost:7800'
puts "-p num_parallels: #{num_parallels} -d duration: #{duration} -u triglav_url: #{triglav_url}"

client = Client.new(url: triglav_url)
event = {
  resource_uri: "hdfs://host:port/%d/path/to/resource",
  resource_unit: 'daily',
  resource_time: Time.now.to_i,
  resource_timezone: "+09:00",
  payload: {free: "text"}.to_json,
}

started = Time.now
counts = Parallel.map(1..num_parallels, in_processes: num_parallels) do |i|
  count = 0
  loop do
    10.times do
      count += 1
      _event = event.merge(resource_uri: "hdfs://host:port/#{count}/path/to/resource")
      client.send_messages([_event])
    end
    elapsed = Time.now - started
    break if elapsed > duration
  end
  count
end
elapsed = Time.now - started
puts "#{counts.inject(:+) / elapsed.to_f} request / sec"
puts "#{counts.inject(:+) / num_parallels.to_f / elapsed.to_f} request / sec / process"
