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

### Build a template

The `configs/` folder contains few Dockerfiles (templates). You can modify any existing or add a new one.
Run on terminal:
```sh
  $ ./use-template.sh claude-node24  # Uses configs/claude-node24.dcr
```
... and follow the instructions for the next step.

The sbx assigns a descriptive name to new sandbox it creates. When in doubt, use `sbx ls`.<br>
I am a lazy person so I added a line in my `~/.zshrc` file: `alias dev='sbx run --name'`,<br>
so to run an existing sandbox, I just type: `dev <sandbox-name>`.

NOTE: The system modifications, e.g. installing new software, persist between sandbox sessions. 😎

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
