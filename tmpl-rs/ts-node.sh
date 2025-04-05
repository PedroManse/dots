#! /usr/bin/env bash

set -e
proj_name=$1

mkdir "$proj_name"
cd "$proj_name"
echo ".direnv
dist
node_modules
" > .gitignore

echo '{
  "compilerOptions": {
    "target": "es2023",
    "lib": ["es2023"],
    "module": "commonjs",
    "rootDir": "./src",
    "moduleResolution": "node",
    "outDir": "./dist",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "strict": true,
    "noImplicitAny": false,
    "skipLibCheck": true
  }
}' > tsconfig.json

echo '
{
  "name": "'"$proj_name"'",
  "version": "0.0.0",
  "description": "funtion with multiple possibles parameters combinations",
  "main": "src/main.ts",
  "license": "GPL-3.0"
}
' > package.json

mkdir src

echo '
console.log("Hello, world")
' > src/main.ts

bash "$TMPLRS_DIR/nixshell.sh" nodejs_22 typescript
