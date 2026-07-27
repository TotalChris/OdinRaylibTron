PROJECT_ROOT=$(git rev-parse --show-toplevel)

if [ ! -d "$PROJECT_ROOT/bin/debug" ]; then
  mkdir -p "$PROJECT_ROOT/bin/debug"
  echo "✅ Created Build Output Folder"
fi