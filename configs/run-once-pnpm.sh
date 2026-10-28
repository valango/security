#!/bin/bash
# Runs once per sandbox, started from /etc/sandbox-persistent.sh (which sets the
# once-only marker BEFORE calling this, as every bash started here re-sources that file):
# make sure the workspace package.json pins pnpm, then self-update pnpm to that version.

node -e '
const fs = require("fs");
const v = process.env.PNPM_VERSION;
let p = {};
if (fs.existsSync("package.json")) p = JSON.parse(fs.readFileSync("package.json", "utf8"));
if (!p.packageManager) {
  p.packageManager = "pnpm@" + v;
  fs.writeFileSync("package.json", JSON.stringify(p, null, 2) + "\n");
}
' || echo "first-run: could not update package.json" >&2

pnpm self-update "$PNPM_VERSION" || echo "first-run: pnpm self-update failed" >&2
