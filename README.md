# Security Rules for Software Development

_The rules are not exhaustive and apply to javascript/typescript technologies in the first place.
Be aware that other ecosystems (Python, GoLang, ...) are under attack as well._

NOTE: for better readability the more in-depth explanations are in the end of the document.

## Rules and Requirements

### Using Package Managers

Currently, the `pnpm` is probably the safest option.

Keep your package manager and other tools up to date but do not install any updates less than 3 days old.

See recommendations on [using (p)npm](./docs/pnpm.md).

### Preventing AI Tools from Stealing or Compromising Your Data

The https://claude.ai claims that _Claude.app_ / _Claude.exe_ is "safe", but this might not be true.
Hereby we speak of command line tools - the things you can run from the terminal window command line.

As for now, the safest way is to run CLI AI tools from docker sandbox. See [using docker sbx](./docs/docker-sbx.md).

## Comments

**Q**: Is it secure to run any software in a Web Browser window?<br>
**A**: No. Malware and infected web sites have always been there.<br>
People think local files can't be read by a web browser, but they can.
Running AI web apps in a browser is just _moderately safer_ than running installed versions.

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
   
**Q**: Why do I need play with .pnpmrc file if I already set the global options?<br>
**A**: When deploying your stuff to hosting, your global settings will not follow. Those are only your local safeguards.

### Preventing AI Tools from Stealing or Compromising Your Data

_Any software installed on your system **can steal or compromise your data**.
If this is not bad enough, then so can do any browser plugin/add-on, too._

The main known attack vectors are:
1. A tool in use gets auto-updated to a new version that contains a malicious code (unlikely).
2. A _command insertion_ type attack to a model / agent you are using.
3. A spyware installed or prepared for during installation of a tool.<br>
   Example: https://www.thatprivacyguy.com/blog/anthropic-spyware 😨

## Links

* https://pnpm.io/supply-chain-security
* https://developer.chrome.com/docs/capabilities/web-apis/file-system-access
