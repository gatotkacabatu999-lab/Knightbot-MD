#!/bin/bash
# Startup script for Knight Bot
# Ensures stub modules are in place before starting

# Recreate gtts stub (blocked by security policy - form-data@2.3.3)
if [ ! -f "node_modules/gtts/index.js" ]; then
  mkdir -p node_modules/gtts
  cat > node_modules/gtts/index.js << 'EOF'
'use strict';
class gTTS {
  constructor(text, lang) { this.text = text; this.lang = lang || 'en'; }
  save(path, callback) { callback(new Error('TTS unavailable: gtts not installed')); }
  stream() { const { Readable } = require('stream'); const r = new Readable(); r.push(null); return r; }
}
module.exports = gTTS;
EOF
  echo '{"name":"gtts","version":"0.2.1","main":"index.js"}' > node_modules/gtts/package.json
fi

# Recreate supports-color stub if needed
if [ ! -f "node_modules/supports-color/index.js" ]; then
  mkdir -p node_modules/supports-color
  cat > node_modules/supports-color/index.js << 'EOF'
'use strict';
const {env} = process;
function translateLevel(level) {
  if (level === 0) return false;
  return { level, hasBasic: true, has256: level >= 2, has16m: level >= 3 };
}
function createSupportsColor(stream) {
  if ('FORCE_COLOR' in env) {
    const fc = env.FORCE_COLOR;
    if (fc === 'true') return translateLevel(1);
    if (fc === 'false') return translateLevel(0);
    const n = Math.min(Number.parseInt(fc, 10), 3);
    return translateLevel(isNaN(n) ? 1 : n);
  }
  if (!stream || !stream.isTTY) return translateLevel(0);
  if (env.COLORTERM === 'truecolor') return translateLevel(3);
  if (env.COLORTERM) return translateLevel(2);
  return translateLevel(1);
}
module.exports = {
  supportsColor: createSupportsColor,
  stdout: createSupportsColor({ isTTY: process.stdout && process.stdout.isTTY }),
  stderr: createSupportsColor({ isTTY: process.stderr && process.stderr.isTTY }),
};
EOF
  echo '{"name":"supports-color","version":"7.2.0","main":"index.js"}' > node_modules/supports-color/package.json
fi

# Rebuild sharp if native module is missing
if [ ! -f "node_modules/sharp/build/Release/sharp-linux-x64.node" ]; then
  npm rebuild sharp --ignore-scripts=false 2>/dev/null || true
fi

exec node index.js
