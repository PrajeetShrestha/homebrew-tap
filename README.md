# Voice Studio Homebrew tap

Install on macOS or Linux with Homebrew:

```sh
brew install PrajeetShrestha/tap/voice-studio
voice-studio web
```

Update with `brew upgrade voice-studio`. Remove with `brew uninstall voice-studio`.

The formula installs the CLI, ffmpeg and Python 3.12. Siri synthesis is macOS-only
and needs Apple Command Line Tools. Linux uses optional Kokoro. No model or Kokoro
package is automatically installed. Follow the [setup guide](https://github.com/PrajeetShrestha/voice-cli#install-with-homebrew-macos-or-linux).

Models and virtual environments should remain outside the Cellar, in your own
user directories, so package upgrades do not remove them. The server is local-only.

This is a project-maintained tap, not Homebrew/core. Formula source archives use
versioned tags and SHA-256 verification. Test with `brew test voice-studio`.
