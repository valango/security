# Using pnpm package manager

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
   The pnpm provides additional quite flexible configuration options, see https://pnpm.io/settings#onlybuiltdependencies
3. Always check that none of package or configuration files contain any access keys, URLs etc., unless these are really
   irrelevant.
4. _**Do not** install_ the _default version of any package_. Always use a specific version.
   Check the package's release history and security advisories.
   The same rules apply to updating your project dependencies, too.
   Infected uploads are usually detected in about a week or so.
   Instead of `npm install something` use `npm install something@1.2.3`.
5. Always use `npm ci` and NOT `npm install` when re-installing dependencies of a project.<br>With `pnpn` use
   `pnpm install --frozen-lockfile`
6. Do not use `npm audit fix` or `pnpn audit --fix`, because the latest versions might be installed w/o checking.
