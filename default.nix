let
    pkgs = import <nixpkgs> { };
in
    pkgs.stdenv.mkDerivation {
        name = "useful-scripts";

        phases = [ "installPhase" "fixupPhase" ];

        inherit (pkgs) bash pulseaudio brightnessctl libnotify;
        bluez_tools = pkgs.bluez-tools; # Can't inherit as `-` isn't allowed in env var names.

        installPhase = ''
            mkdir -p "$out/bin"
            for f in "${./scripts}"/* ; do
                f="$(basename $f)"
                substituteAll "${./scripts}/$f" "$out/bin/$f"
            done

            chmod +x "$out/bin/"*
        '';
    }
