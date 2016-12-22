require "open3"

namespace :db do
  def apply(argopts)
    config_file = File.join("#{Rails.root}", "config", "database.yml")
    schema_file = File.join("#{Rails.root}", "db", "schemas", "Schemafile")
    command = "ridgepole --file #{schema_file} -c #{config_file} --ignore-table repli_chk,repli_clock #{argopts} -E #{Rails.env}"
    puts command

    out = []

    Open3.popen2e(command) do |stdin, stdout_and_stderr, wait_thr|
      stdin.close

      stdout_and_stderr.each_line do |line|
        out << line
        yield(line) if block_given?
      end
    end

    out.join("\n")
  end

  desc "apply schema with ridgepole"
  task :apply do |t, args|
    apply('--apply') do |line|
      puts line
    end
  end

  desc "apply-dry-run schema with ridgepole"
  task :'apply-dry-run' do |t, args|
    apply('--apply --dry-run') do |line|
      puts line
    end
  end
end

namespace :ridgepole do
end
