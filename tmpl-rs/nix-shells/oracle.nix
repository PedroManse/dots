{
  pkgs ? import <nixpkgs> { },
}:
let
  oracle_instant_client = pkgs.fetchzip {
    url = "https://download.oracle.com/otn_software/linux/instantclient/2390000/instantclient-basic-linux.x64-23.9.0.25.07.zip";
    stripRoot = false;
    hash = "sha256-3iBitY4AVZRVnn8Aq9/kdqOcUFpRzwlSREU9P1cIUqw=";
  };
  ORACLE_HOME = ''${oracle_instant_client}/instantclient_23_9'';
  shellDef = rec {
    inherit ORACLE_HOME;

    inputsFrom = with pkgs; [
      libaio
    ];

    packages = [ ];

    LD_LIBRARY_PATH = ''${ORACLE_HOME}:${pkgs.libaio}/lib'';

    shellHook = ''
      export PATH=$PATH:$ORACLE_HOME
    '';
  };
in
pkgs.mkShellNoCC shellDef
