def podman_runtime?
  @podman_runtime ||= begin
    exists = `command -v podman >/dev/null 2>&1; echo $?`.chomp
    exists == '0' ? true : false
  end
end

def docker_build_cmd
  args = ['build']
  args.concat ['-t', "#{image_name}:#{tag}", '-f', 'Dockerfile', '.']

  "docker #{args.join(' ')}"
end

def buildah_build_cmd
  args = ['bud', '--layers']
  args.concat ['-t', "#{image_name}:#{tag}", '-f', 'Dockerfile']

  "buildah #{args.join(' ')}"
end

def tag
  git_tag = `git tag --points-at HEAD`.chomp
  git_tag.empty? ? 'latest' : git_tag
end

def container_runtime
  podman_runtime? ? 'podman' : 'docker'
end

def demo_run_cmd
  [ container_runtime, 'run', '--rm', '--detach',
    '--name', 'ood_demo', '-p 8080:8080',
    '-h', 'ood.demo',
    "#{image_name}:#{tag}"
  ].join(' ')
end

def image_name
  'openondemand/open-ondemand-demo'
end

def build_cmd
  if podman_runtime?
    buildah_build_cmd
  else
    docker_build_cmd
  end
end