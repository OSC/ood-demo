def podman_runtime?
  return @podman_runtime unless @podman_runtime.nil?

  @podman_runtime = `command -v podman >/dev/null 2>&1; echo $?`.chomp == '0'
end

def docker_build_cmd
  args = ['build']
  args.concat ['-t', "#{image_name}:#{tag}", '-f', 'Dockerfile', '.']

  "docker #{args.join(' ')}"
end

def buildah_build_cmd
  args = ['bud', '--layers']
  args.concat ['-t', "#{image_name}:#{tag}", '-f', 'Dockerfile', '.']

  "buildah #{args.join(' ')}"
end

def podman_build_cmd
  args = ['build']
  args.concat ['-t', "#{image_name}:#{tag}", '-f', 'Dockerfile', '.']

  "podman #{args.join(' ')}"
end

def tag
  # In a tag-triggered Actions run the ref is authoritative. A shallow checkout
  # has no local tag refs, so asking git would fall back to 'latest' and quietly
  # publish over it.
  return ENV['GITHUB_REF_NAME'] if ENV['GITHUB_REF_TYPE'] == 'tag' && !ENV['GITHUB_REF_NAME'].to_s.empty?

  git_tag = `git tag --points-at HEAD`.chomp
  git_tag.empty? ? 'latest' : git_tag
end

def container_runtime
  podman_runtime? ? 'podman' : 'docker'
end

def demo_run_cmd
  # --privileged is required because the container boots systemd as PID 1.
  # Podman's systemd mode can often manage without it, but Docker cannot,
  # and the flag is harmless where it isn't strictly needed.
  [ container_runtime, 'run', '--rm', '--detach',
    '--name', 'ood_demo', '--privileged',
    '-p 8080:8080', '-h', 'ood.demo',
    "#{image_name}:#{tag}"
  ].join(' ')
end

def image_name
  'openondemand/open-ondemand-demo'
end

def buildah?
  return @buildah unless @buildah.nil?

  @buildah = `command -v buildah >/dev/null 2>&1; echo $?`.chomp == '0'
end

def build_cmd
  # Stay on whichever runtime container_runtime picked, or the built image
  # lands in one store and the later tag/push looks in the other. buildah
  # isn't always installed alongside podman, so fall back to `podman build`.
  if podman_runtime?
    buildah? ? buildah_build_cmd : podman_build_cmd
  else
    docker_build_cmd
  end
end