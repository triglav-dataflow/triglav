require_relative 'client'
require 'parallel'
require 'optparse'
params = ARGV.getopts('p:n:o:')

num_parallels = Integer(params['p'] || 2)
num_times = Integer(params['n'] || 10)
offset = Integer(params['o'] || 0)
puts "num_parallels: #{num_parallels}, num_times: #{num_times}, offset: #{offset}"

client = Client.new
resource_uri = "hdfs://host:port/path/to/resource"

started = Time.now
Parallel.each(1..num_parallels, in_processes: num_parallels) do |i|
  num_times.times do
    client.fetch_messages(offset, limit: 100, resource_uris: [resource_uri])
  end
end
elapsed = Time.now - started
puts "elapsed: #{elapsed.to_f}sec"
