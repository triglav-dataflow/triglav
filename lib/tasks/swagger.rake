require 'tempfile'

namespace :swagger do
  VERSION = File.read("#{Rails.root}/VERSION").chomp
  SWAGGER_JSON_PATH = "#{Rails.root}/tmp/swagger.json"
  SWAGGER_CODEGEN_CLI_PATH = "#{Rails.root}/bin/swagger-codegen-cli.jar"

  SWAGGER_CODEGEN_JAVA_CONFIG = {
    "modelPackage"=>"io.github.triglav_dataflow.client",
    "apiPackage"=>"io.github.triglav_dataflow.client.api",
    "groupId"=>"io.github.triglav_dataflow",
    "artifactId"=>"triglav-client-java",
    "artifactVersion"=>VERSION,
  }

  SWAGGER_CODEGEN_RUBY_CONFIG = {
    "gemName"=>"triglav_client",
    "moduleName"=>"TriglavClient",
    "gemAuthor"=>"Triglav Team",
    "gemHomepage"=>"https://github.com/triglav-dataflow/triglav-client-ruby",
    "gemSummary"=>"A ruby client library for Triglav, data-driven workflow tool",
    "gemDescription"=>"A ruby client library for Triglav, data-driven workflow tool",
    "gemVersion"=>VERSION,
  }

  desc "Generate tmp/swagger.json"
  task :generate => :environment do |t, args|
    swagger_data = Swagger::Blocks.build_root_json(
      Api::V1::ApidocsController::SWAGGERED_CLASSES
    )
    File.open(SWAGGER_JSON_PATH, 'w') { |file| file.write(swagger_data.to_json) }
    puts "Generated #{SWAGGER_JSON_PATH}"
  end

  desc "Generate ../triglav-client-java"
  task :"codegen-java" => :generate do |t, args|
    output = File.expand_path(File.join(Rails.root, '..', 'triglav-client-java'))
    %w[
      LICENSE
      README.md
      build.gradle
      build.sbt
      git_push.sh
      gradle.properties
      gradlew.bat
      pom.xml
      settings.gradle
    ].each do |file|
      sh "rm -f #{File.join(output, file)}"
    end
    Tempfile.create('triglav') do |fp|
      fp.write SWAGGER_CODEGEN_JAVA_CONFIG.to_json
      fp.close
      sh "java -jar #{SWAGGER_CODEGEN_CLI_PATH} generate" \
        " -i #{SWAGGER_JSON_PATH}" \
        " -l java" \
        " -c #{fp.path}" \
        " -o #{output}"
      sh "cd #{output} && ./gradlew build"
    end
  end

  desc "Generate ../triglav-client-ruby"
  task :"codegen-ruby" => :generate do |t, args|
    output = File.expand_path(File.join(Rails.root, '..', 'triglav-client-ruby'))
    Tempfile.create('triglav') do |fp|
      fp.write SWAGGER_CODEGEN_RUBY_CONFIG.to_json
      fp.close
      sh "java -jar #{SWAGGER_CODEGEN_CLI_PATH} generate" \
        " -i #{SWAGGER_JSON_PATH}" \
        " -l ruby" \
        " -c #{fp.path}" \
        " -o #{output}"
    end
  end

  desc "Generate triglav clients"
  task :codegen => [:"codegen-java", :"codegen-ruby"]
end
