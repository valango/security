# Using Docker sbx

The `sbx` is a Docker CLI utility providing convenient pattern for safe containerization on your local machine.
It is a great tool - not only is it significantly safer than previous approaches - it makes it easy
to run different tools in different sandboxes in parallel.<br>
Docker provides base images for different tools, so configuring is pretty simple.

The `sbx` supports different platforms, but the following guide applies to Mac OS showing how to sandbox
Claude Code with a specific version of node.js.

## The Workflow
### Before you start

1. Make sure your system has MacOS-26 or later, is generally up to date and behaves normally. 
2. Install the Docker.app or update it to the latest version available.Besides updating the Docker.app.
3. Make sure the homebrew is OK by using the `brew update` and `brew doctor` commands.
4. Create a dedicated folder for you sandbox _**configurations folder**_ (optional).

The files in the _configuration folder_ define different sandbox configurations, not the sandboxes themselves.
If you wish, you can make the configuration to be a part of a project itself; in this case you might not need
a special name for dockerfile nor the `-f` CLI key.

### Install the SBX and log in
```sh
  $ brew trust docker/tap
  $ brew install docker/tap/sbx
  $ sbx login     ## Everything below assumes you are logged in.
```

### Pull the base image and check its default user (adjust the Dockerfile if needed)
```sh
  $ docker pull docker/sandbox-templates:claude-code-docker
  $ docker image inspect docker/sandbox-templates:claude-code-docker --format '{{.Config.User}}'
  # should respond: agent
```

### Create the configuration
_**NOTE**: this example shows how to bundle the necessary software (here: node v24) with a sandbox template._

Create a dockerfile named `claude-docker-node24.dcr` in the _configurations folder_.

```dockerfile
# Plain `sbx run claude` defaults to the -docker variant (Docker Engine inside the sandbox).
# Use docker/sandbox-templates:claude-code instead if you don't need Docker inside.
FROM docker/sandbox-templates:claude-code-docker

USER root
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - \
&& apt-get install -y nodejs \
&& node --version
# Switch back to the image's original non-root user (check with the command below)
USER agent
```
Run: `$ docker build -f ./claude-docker-node24.dcr -t MY_ORG/claude-docker-node24:v1 .`<br>
should respond: `View build details: docker-desktop://dashboard/build/desktop-linux/desktop-linux/...`

```shell
$ docker image save MY_ORG/claude-docker-node24:v1 -o claude-docker-node24.tar
$ sbx template load claude-docker-node24.tar
$ cd PROJECT_DIR    ## Do NOT miss that!
$ sbx run --template MY_ORG/claude-docker-node24:v1 claude .
```

The MY_ORG can be an arbitrary name for local registry or a string "docker.io/NAME" for global registry.

All done! Since now, you can start this sandbox from everywhere by just typing:<br> 
`sbx run --name SANDBOX_NAME`.

The `sbx ls` comes handy if you are lost.

## About database- and outer connections.

Mostly, there should be no need to access any actual services (DB included) from your code
running under agent control. Automatic tests should rely on proper stubs or emulators.

When absolutely necessary, U can do something like this:<br>
`$ sbx policy allow network api.example.com # or localhost:8080 etc...`

**NOTE:** this won't work for local mongodb connection - supposedly the only proper way is to run
mongodb from a container.

## Troubleshooting

The `sbx diagnose` is useful and Google AI can help you out in most cases.

## Links

* https://docs.docker.com/ai/sandboxes
* https://docs.docker.com/reference/cli/sbx
* https://github.com/docker/sbx-releases/releases
* https://code.visualstudio.com/docs/devcontainers/tutorial
* https://www.freecodecamp.org/news/claude-code-in-a-docker-sandbox/
* tons of content in youtube etc.
