{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "bambu-cli";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "tobiasbischoff";
    repo = "bambu-cli";
    rev = "v${version}";
    hash = "sha256-mmwhgi57SPFIAHDuIFrEvxw5uyyo8wmWyS3IzPi4LqM=";
  };

  vendorHash = "sha256-ReZz8Ihqf6jo8ME6jV626b3JVKNHl2kYKl0ZsZlKcm4=";

  subPackages = [ "cmd/bambu-cli" ];

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];

  meta = with lib; {
    description = "Command-line client for Bambu Lab printers";
    homepage = "https://github.com/tobiasbischoff/bambu-cli";
    license = licenses.mit;
    mainProgram = "bambu-cli";
    maintainers = [ ];
  };
}
