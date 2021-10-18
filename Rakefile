# frozen_string_literal: true

require 'rubocop/rake_task'

task default: 'play'

task :play do
  ruby 'lib/main.rb'
end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb']
  task.fail_on_error = true
end
