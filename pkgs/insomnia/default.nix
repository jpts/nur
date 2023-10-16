{
  lib,
  stdenvNoCC,
  fetchurl,
  undmg,
  gitUpdater,
}:
stdenvNoCC.mkDerivation rec {
  pname = "insomnia";
  version = "8.3.0";

  src = fetchurl {
    url = "https://github.com/Kong/insomnia/releases/download/core@${version}/Insomnia.Core-${version}.dmg";
    sha256 = "sha256-kMN3vGTO3HBAXLNKEzYYRnRPOyWpl9X4ziG4dNtjDUU=";
  };

  sourceRoot = ".";

  preferLocalBuild = true;
  nativeBuildInputs = [undmg];

  # dont invalidate sig
  dontFixup = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    mv Insomnia.app $out/Applications

    runHook postInstall
  '';

  passthru.updateScript = gitUpdater {
    url = "https://github.com/Kong/insomnia";
    rev-prefix = "core@";
  };

  meta = with lib; {
    description = "The open-source, cross-platform API client for GraphQL, REST, WebSockets and gRPC.";
    homepage = "https://github.com/Kong/insomnia";
    sourceProvenance = with sourceTypes; [binaryNativeCode];
    platforms = platforms.darwin;
    maintainers = with maintainers; [jpts];
    license = licenses.mit;
  };
}
