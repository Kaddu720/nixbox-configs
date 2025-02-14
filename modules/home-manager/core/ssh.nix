{
  lib,
  config,
  vars,
  ...
}: let
  privateKey =
    if vars.hostName == "Home-Box"
    then "~/.ssh/personal/personal"
    else if vars.hostName == "Mobile-Box"
    then "~/.ssh/mobile/mobile"
    else if vars.hostName == "Work-Box"
    then "~/.ssh/work-box"
    else abort "host not specified";
in {
  options = {
    ssh.enable =
      lib.mkEnableOption "enables ssh";
  };

  config = lib.mkIf config.ssh.enable {
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
      extraOptionOverrides = {
        SetEnv = "TERM=xterm";
      };
      matchBlocks = {
        "github.com" = {
          user = "git";
          identityFile = "${privateKey}";
        };
      };
    };
  };
}
