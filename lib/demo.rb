require_relative 'utils'

desc 'Build the demo container'
task :build do
  sh build_cmd
end

desc 'Start the demo container'
task start: [:build] do
  sh demo_run_cmd
end

desc 'Stop the demo container'
task :stop do
  sh "#{container_runtime} stop ood_demo"
end

desc 'Restart the demo container'
task restart: [:stop, :start] do
  # nothing to do, taken care of in dependencies
end