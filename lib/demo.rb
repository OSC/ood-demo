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

desc 'Publish the image to a repository'
task :publish, [:repo] => [:build] do |t, args|
  repo = args[:repo]
  err_msg = "Repository is not specified. Must specify repository for example \"rake publish['docker.io']\""
  raise(StandardError, err_msg) if repo.nil?

  # tag this as the latest as well
  if tag != "latest"
    build_cmd(true)
  end

  sh "#{container_runtime} push #{repo}/#{image_name}:#{tag}"
  sh "#{container_runtime} push #{repo}/#{image_name}:latest"
end
