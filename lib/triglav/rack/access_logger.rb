require 'time'

module Triglav
  module Rack
    class AccessLogger
      PID = Process.pid

      def initialize(app, logger=nil)
        @app = app
        @logger = logger || $stdout
      end

      def call(env)
        began_at = Time.now.instance_eval { to_i + (usec/1000000.0) }

        status, headers, body = @app.call(env)

        now = Time.now
        reqtime = now.instance_eval { to_i + (usec/1000000.0) } - began_at

        params = {
          time: now.iso8601,
          logtime: now.to_i,
          d: now.strftime("%Y-%m-%d"),
          # host: env["REMOTE_ADDR"] || "-", # useless, nginx
          vhost: env['HTTP_HOST'] || "-",
          # pid: PID,
          # forwardedfor: env['HTTP_X_FORWARDED_FOR'] || "-",
          # user: env["REMOTE_USER"] || "-",
          method: env["REQUEST_METHOD"],
          path: env["PATH_INFO"],
          # query: env["QUERY_STRING"].empty? ? "" : "?"+env["QUERY_STRING"],
          # protocol: env["HTTP_VERSION"],
          ua: env['HTTP_USER_AGENT'] || "-",
          status: status.to_s[0..3],
          size: extract_content_length(headers) || -1,
          reqtime: reqtime,
        }
        # See ApplicationController for 'triglav_access_log'
        params.merge!(env['triglav_access_log']) if env['triglav_access_log']
        @logger.write params.to_json << "\n"

        [status, headers, body]
      end

      private

      def extract_content_length(headers)
        value = headers['Content-Length'] or return nil
        value.to_i
      end
    end
  end
end
