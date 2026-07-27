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

  sh "#{container_runtime} tag #{image_name}:#{tag} #{repo}/#{image_name}:#{tag}"
  sh "#{container_runtime} tag #{image_name}:#{tag} #{repo}/#{image_name}:latest"

  sh "#{container_runtime} push #{repo}/#{image_name}:#{tag}"
  sh "#{container_runtime} push #{repo}/#{image_name}:latest"
end

desc 'Publish a single-architecture image, tagged with its arch suffix'
# No :build dependency - the workflow builds in its own step, and rebuilding
# here would be a second `git clone` of the example app that could differ.
task :publish_arch, [:repo, :arch] do |t, args|
  repo = args[:repo]
  arch = args[:arch]
  raise(StandardError, "Repository is not specified. Example: \"rake publish_arch['docker.io','amd64']\"") if repo.nil?
  raise(StandardError, "Architecture is not specified. Example: \"rake publish_arch['docker.io','amd64']\"") if arch.nil?

  # Only the versioned per-arch tag. These are scratch tags for the manifest
  # job to assemble; pushing a shared `latest-<arch>` would let concurrent
  # releases mix architectures from different builds.
  dest = "#{repo}/#{image_name}:#{tag}-#{arch}"
  sh "#{container_runtime} tag #{image_name}:#{tag} #{dest}"
  sh "#{container_runtime} push #{dest}"
end

desc 'Combine the per-architecture images into a multi-arch manifest list'
task :manifest, [:repo] do |t, args|
  repo = args[:repo]
  raise(StandardError, "Repository is not specified. Example: \"rake manifest['docker.io']\"") if repo.nil?

  # publish_arch pushes <tag>-<arch>, so without a real tag there's nothing to
  # assemble and we'd chase :latest-amd64, which is never pushed.
  raise(StandardError, 'No release tag found - manifest needs a tagged build') if tag == 'latest'

  arches = %w[amd64 arm64]

  src = "#{repo}/#{image_name}:#{tag}"

  %W[#{tag} latest].uniq.each do |t_name|
    list = "#{repo}/#{image_name}:#{t_name}"

    # Local storage only - matters when rebuilding locally, no-op in CI.
    sh "#{container_runtime} manifest rm #{list} || true"
    sh "#{container_runtime} manifest create #{list}"

    # docker:// forces a registry lookup - the per-arch images were pushed by
    # the other runners and aren't in this one's local storage. Both lists are
    # built from the versioned tags so `latest` can't mix builds.
    arches.each do |a|
      sh "#{container_runtime} manifest add #{list} docker://#{src}-#{a}"
    end

    # Fail loudly if the list didn't end up with both architectures.
    sh "#{container_runtime} manifest inspect #{list}"

    sh "#{container_runtime} manifest push --all #{list} docker://#{list}"
  end
end
