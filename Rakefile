require 'rspec/core/rake_task'

namespace :spec do
  desc 'Run all tests'
  RSpec::Core::RakeTask.new(:spec)

  desc 'Start autotest daemon'
  task :auto do
    sh 'autotest'
  end

  desc 'Run smoke tests'
  RSpec::Core::RakeTask.new(:smoke) do |t|
    t.rspec_opts = '--tag smoke'
  end

  desc 'Run wip tests'
  RSpec::Core::RakeTask.new(:wip) do |t|
    t.rspec_opts = '--tag wip'
  end
end
task :spec => :'spec:spec'
task :wip => :'spec:wip'

task :default => :spec

desc 'Start Pry with lib loaded'
task :pry do
  sh 'pry --require "./lib/all"'
end