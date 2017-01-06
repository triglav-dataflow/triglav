require_relative 'client'
require 'parallel'
require 'optparse'
params = ARGV.getopts('p:d:o:')

num_parallels = Integer(params['p'] || 2)
duration = Integer(params['d'] || 1)
offset = Integer(params['o'] || 0)
triglav_url = params['u'] || 'http://localhost:7800'
puts "-p (num_parallels) #{num_parallels} -d (duration) #{duration} -u (triglav_url) #{triglav_url} -o (offset) #{offset}"

client = Client.new(url: triglav_url)

started = Time.now
counts = Parallel.map(1..num_parallels, in_processes: num_parallels) do |i|
  count = 0
  loop do
    10.times do
      count += 1
      resource_uri = "hdfs://host:port/#{count}/path/to/resource"
      client.fetch_messages(offset, limit: 100, resource_uris: [resource_uri])
    end
    elapsed = Time.now - started
    break if elapsed > duration
  end
  count
end
elapsed = Time.now - started
puts "#{counts.inject(:+) / elapsed.to_f} request / sec"
puts "#{counts.inject(:+) / num_parallels.to_f / elapsed.to_f} request / sec / process"
