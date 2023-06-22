{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  name = "penelope";
  version = "0.9.2";
  owner = "brightio";
  repo = name;

  src = fetchFromGitHub {
    inherit owner repo;
    rev = "v${version}";
    sha256 = "sha256-KlbB7i009UttTp+/MaF3y9CGUkAGEQQq/W+hQYKk9CY=";
  };

  dontUnpack = true;
  dontStrip = true;
  installPhase = "install -Dm755 $src/penelope.py $out/bin/penelope";

  meta = with lib; {
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/tag/v${version}";
    description = "Penelope Shell Handler";
    longDescription = ''
      Penelope is a shell handler designed to be easy to use and intended to replace netcat when exploiting RCE vulnerabilities. It is compatible with Linux and macOS and requires Python 3.6 or higher. It is a standalone script that does not require any installation or external dependencies, and it is intended to remain this way.
    '';
    license = licenses.gpl3;
    maintainers = with maintainers; [];
    platforms = platforms.unix;
  };
}
