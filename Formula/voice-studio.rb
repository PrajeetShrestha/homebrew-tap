class VoiceStudio < Formula
  desc "Local Siri and Kokoro voiceover studio with a browser UI and MP3 export"
  homepage "https://github.com/PrajeetShrestha/voice-cli"
  url "https://github.com/PrajeetShrestha/voice-cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "cb8d64ae06a2848323524459e2a409d6a21694eb1c029807e70742ead4e2860b"

  depends_on "ffmpeg"
  depends_on "python@3.12"
  on_macos do
    depends_on :macos => :ventura
    depends_on :xcode => ["15.0", :build]
  end

  def install
    libexec.install "run.sh", "VERSION", "Sources", "scripts"
    (bin/"voice-studio").write <<~SH
      #!/bin/sh
      export PATH="#{Formula["ffmpeg"].opt_bin}:$PATH"
      export VOICE_STUDIO_PYTHON="${VOICE_STUDIO_PYTHON:-#{Formula["python@3.12"].opt_bin}/python3.12}"
      exec "#{libexec}/run.sh" "$@"
    SH
  end

  def caveats
    <<~EOS
      Start: voice-studio web
      Headless: voice-studio web --no-open
      macOS requires Apple Command Line Tools/Swift for Siri.
      Linux requires optional Kokoro packages before it can generate speech.
      Kokoro models/packages are not bundled or downloaded automatically.
      Setup: https://github.com/PrajeetShrestha/voice-cli#install-with-homebrew-macos-or-linux
      Existing ~/.local/bin/voice-studio may shadow the Homebrew command.
      Check: type -a voice-studio
    EOS
  end

  test do
    assert_equal "0.2.0", shell_output("#{bin}/voice-studio --version").strip
    assert_match "Usage: voice-studio", shell_output("#{bin}/voice-studio web --help")
    assert_match "Unknown command", shell_output("#{bin}/voice-studio invalid 2>&1", 2)
    result = shell_output("#{Formula["python@3.12"].opt_bin}/python3.12 #{libexec}/Sources/VoiceStudio/kokoro_bridge.py detect")
    assert_match "kokoro", result
  end
end
