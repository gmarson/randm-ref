# Adds support for Apple Silicon brew directory
export PATH="$PATH:/opt/homebrew/bin"

if which sourcery >/dev/null; then
    sourcery --config Modules/Sources/DesignSystem/.sourcery.yml
else
  echo "warning: Sourcery not installed, download from https://github.com/krzysztofzablocki/Sourcery"
fi
