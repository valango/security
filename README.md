# Security Rules for Software Development

_The rules are not exhaustive and apply to javascript/typescript technologies in the first place.
Be aware that other ecosystems (Python, GoLang, ...) are under attack as well._

NOTE: for better readability the more in-depth explanations are in the end of the document.

## Rules and Requirements

### Using Package Managers

Use only `npm` or `pnpm`. If you need anything else, consult the IT guys first!

1. Never delete an existing `package-lock.json` or `pnpm-lock.yaml` file. This file ensures that the exact same versions
   of
   dependencies are installed when you re-install your project.
2. Prevent package auto-run: run
   ```sh
   $ npm config set -g ignore-scripts true # or 
   $ pnpm config set ignore-scripts true
   ```
2. Make sure there is a .npmrc or .pnpmrc file in your project directory and it contains a line:<br>
   `ignore-scripts=true`
   The pnpm provides more flexible configuration options, see https://pnpm.io/settings#onlybuiltdependencies
3. Always check that none of package or configuration files contain any access keys, URLs etc., unless these are really
   secure.
4. _**Do not** install_ the _default version of any package_. Always use a specific version.
   Check the package's release history and security advisories.
   The same rules apply to updating your project dependencies, too.
   Infected uploads are usually detected in about a week or so.
   Instead of `npm install something` use `npm install something@1.2.3`.
5. Always use `npm ci` and NOT `npm install` when re-installing dependencies of a project.<br>With `pnpn` use
   `pnpm install --frozen-lockfile`
6. Do not use `npm audit fix` or `pnpn audit --fix`, because the latest versions might be installed w/o checking.

### Preventing AI Tools from Stealing or Compromising Your Data

The https://claude.ai claims that _Claude.app_ / _Clause.exe_ is "safe", but this might not be true.
Hereby we speak of command line tools - the things you can run from the terminal window command line.

#### On Mac OS

Create a dedicated `claudedev` user on your Mac. Log into it (or `su -` into it) when running Claude Code. That user has
its own home directory, its own (empty) Keychain, no access to your real `~/.ssh/`, no AWS credentials. Project files
live in a directory you've chmod'd to be readable by both users, or you symlink/bind-mount them in.

#### On Windows

As for now, the only trusted way to run Claude Code is to run it from a virtual machine (VM) or a Docker container.

## Explanations

### Using package managers

There are some prominent attack vectors known:

1. an infected 3-rd party package may contain a script in its package.json file that will run automatically during
   installation. A malware may harvest all passwords, API keys, access tokens from your system, send them to somebody
   and/or try to exploit those immediately.
2. The code itself may be infected as well. In this case, the malware activates when the package or your code using it,
   is executed.
3. If you are a developer owning any packages in public repos like npmjs.com, a malware may publish new infected
   releases of your existing packages. Usually only the release number will differ and in some cases the same release
   can be replaced.

### Preventing AI Tools from Stealing or Compromising Your Data

_Any software installed on your system **can steal or compromise your data**.
If this is not bad enough, then so can do any browser plugin/add-on, too._

The main known attack vectors are:
1. A tool in use gets auto-updated to a new version that contains a malicious code (unlikely).
2. A _command insertion_ type attack to a model / agent you are using.
3. A spyware installed or prepared for during installation of a tool.<br>
   Example: https://www.thatprivacyguy.com/blog/anthropic-spyware 