namespace :swagger do
  desc "Generate tmp/swagger.json"
  task :generate => :environment do |t, args|
    swagger_data = Swagger::Blocks.build_root_json(Api::V1::ApidocsController::SWAGGERED_CLASSES)
    swagger_path = File.join(Rails.root, 'tmp', 'swagger.json')
    File.open(swagger_path, 'w') { |file| file.write(swagger_data.to_json) }
    puts "Generated #{swagger_path}"
  end
end
