APP_ROOT = File.dirname(File.dirname(__FILE__))
require 'server/starter/puma_listener'

listener = ::Server::Starter::PumaListener
status_file = File.join(APP_ROOT, 'tmp/pids/start_server.stat')

pidfile File.join(APP_ROOT, 'tmp/pids/puma.pid')
state_path File.join(APP_ROOT, 'tmp/pids/puma.state')

# Run puma via start_puma.rb to configure PUMA_INHERIT_\d ENV from SERVER_STARTER_PORT ENV as
# $ bundle exec --keep-file-descriptors start_puma.rb puma -C config/puma.conf.rb config.ru
puts ENV['SERVER_STARTER_PORT']

if ENV['SERVER_STARTER_PORT']
  puma_inherits = listener.listen
  puma_inherits.each do |puma_inherit|
    bind puma_inherit[:url]
  end
else
  puts '[WARN] Fallback to 0.0.0.0:7800 since not running under Server::Starter'
  bind 'tcp://0.0.0.0:7800'
end

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum, this matches the default thread size of Active Record.
#
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory. If you use this option
# you need to make sure to reconnect any threads in the `on_worker_boot`
# block.
#
# MEMO: Hmm, I get WARNING: Detected 18 Thread(s) started in app boot:
# preload_app!

# Allow puma to be restarted by `rails restart` command.
# plugin :tmp_restart

# Code to run before doing a restart. This code should
# close log files, database connections, etc.
# This can be called multiple times to add code each time.
on_restart do
  puts 'On restart...'
end

# Code to run when a worker boots to setup the process before booting
# the app. This can be called multiple times to add hooks.
on_worker_boot do
  puts 'On worker boot...'
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

# Code to run when a worker boots to setup the process after booting
# the app. This can be called multiple times to add hooks.
after_worker_boot do
  puts 'After worker boot...'
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end

# Code to run when a worker shutdown.
on_worker_shutdown do
  puts 'On worker shutdown...'
end
