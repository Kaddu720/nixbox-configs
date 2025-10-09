{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    sesh = {
      enable = lib.mkEnableOption "enables sesh";
      
      sessions = lib.mkOption {
        type = lib.types.listOf (lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              description = "Session name";
            };
            path = lib.mkOption {
              type = lib.types.str;
              description = "Session working directory";
            };
            startupCommand = lib.mkOption {
              type = lib.types.str;
              default = "nvim .";
              description = "Command to run when session starts";
            };
          };
        });
        default = [];
        description = "List of sesh sessions";
      };

      defaultStartupCommand = lib.mkOption {
        type = lib.types.str;
        default = "tmux split-window -h -l 30% && tmux new-window -n lazygit lazygit && tmux select-window -t 1 && nvim";
        description = "Default startup command for new sessions";
      };

      tmuxpLayouts = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = {};
        description = "Tmuxp layout configurations";
      };
    };
  };

  config = let
    seshConfig = pkgs.writeTextFile {
      name = "sesh.toml";
      text = ''
        ${lib.concatStringsSep "\n" (map (session: ''
          [[session]]
          name = "${session.name}"
          path = "${session.path}"
          startup_command = "${session.startupCommand}"
        '') config.sesh.sessions)}

        [default_session]
        startup_command = "${config.sesh.defaultStartupCommand}"
      '';
    };

    tmuxpConfigs = lib.mapAttrs' (name: content:
      lib.nameValuePair name (pkgs.writeTextFile {
        name = "${name}.yaml";
        text = content;
      })
    ) config.sesh.tmuxpLayouts;
  in lib.mkIf config.sesh.enable {
    home.packages = [pkgs.sesh] 
      ++ lib.optional (config.sesh.tmuxpLayouts != {}) pkgs.tmuxp;

    xdg.configFile = {
      "sesh/sesh.toml".source = seshConfig;
    } // (lib.mapAttrs' (name: file:
      lib.nameValuePair "tmuxp/${name}.yaml" { source = file; }
    ) tmuxpConfigs);
  };
}
