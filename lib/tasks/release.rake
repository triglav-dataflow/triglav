namespace :release do
  task :core do
    sh "git tag #{VERSION} || true"
    sh "git push origin #{VERSION}"
  end

  task :"client-java" do
    Dir.chdir(TRIGLAV_CLIENT_JAVA_PATH) do
      sh "git commit -a -m '#{VERSION}'"
      sh "git push origin master"
    end
  end

  task :"client-ruby" do
    Dir.chdir(TRIGLAV_CLIENT_RUBY_PATH) do
      sh "git commit -a -m '#{VERSION}'"
      sh "git push origin master"
      sh "bundle"
      sh "bundle exec rake release"
    end
  end

  task :all => ['swagger:codegen', 'client-java', 'client-ruby', 'core']
end
