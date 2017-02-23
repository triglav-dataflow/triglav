#!/usr/bin/env ruby
# Purge messages table
#
# $ script/purge.rb --purge-date 32 --exec

require_relative '../lib/rails_runner'
require 'optparse'

class Purge
  class CLI
    DEFAULT_PURGE_DATE = 32

    attr_reader :opts, :args

    def initialize
      @opts, @args = parse_options
    end

    def parse_options(argv = ARGV)
      op = OptionParser.new

      self.class.module_eval do
        define_method(:usage) do |msg = nil|
          puts op.to_s
          puts "error: #{msg}" if msg
          exit 1
        end
      end

      opts = {
        exec: false,
        purge_date: DEFAULT_PURGE_DATE.days.ago.strftime('%Y-%m-%d'),
      }

      op.on('--exec', "Run (default: dry-run)") {|v|
        opts[:exec] = v
      }
      op.on('--purge-date VALUE', "Purge data before specified days (default: #{DEFAULT_PURGE_DATE} days ago)") {|v|
        opts[:purge_date] = Integer(v).days.ago.strftime('%Y-%m-%d')
      }

      op.banner += ''
      begin
        args = op.parse(argv)
      rescue OptionParser::InvalidOption => e
        usage e.message
      end

      [opts, args]
    end

    def dry_run?
      !@opts[:exec]
    end

    # %Y-%m-%d
    def purge_date
      @opts[:purge_date]
    end

    def run
      $stdout.puts "Purge before: #{purge_date}"
      purge(Message)
      purge(JobInternalMessage)
      purge(JobMessage)
      $stderr.puts "DRY-RUN finished. Use --exec" if dry_run?
    end

    def purge(klass)
      objs = klass.select(:id, :updated_at).where("updated_at < ?", purge_date)
      objs.each do |obj|
        $stdout.puts "Delete #{klass.to_s} id: #{obj.id}, updated_at: #{obj.updated_at.iso8601}"
      end
      objs.destroy_all unless dry_run?
    end
  end
end

Purge::CLI.new.run
