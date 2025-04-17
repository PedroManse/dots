set -e
module_name="$1"
mkdir "$module_name"
echo 'use super::*' > "$module_name/mod.rs"
