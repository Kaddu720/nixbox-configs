{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../users/noah/home.nix
    ../../users/noah/linux.nix
    ../../modules/home-manager/core
    ../../modules/home-manager/optional
    ../../modules/home-manager/optional/desktop/linux-desktop
    ../../modules/common/static/stylix.nix
  ];
  
  # -------------------- Host-specific Configuration --------------------
  
  # Home directory (home-manager native)
  home.homeDirectory = "/home/noah";
  
  home.sessionVariables = {
    HOME = "/home/noah";
  };
  
  ssh.githubIdentityFile = "~/.ssh/personal/personal";

  programs.nh.flake = "/home/noah/.nixos";
  
  ghostty.fontSize = 12;
  alacritty.fontSize = 12;
  
  sesh.tmuxpLayouts = {
    ekiree_dashboard = ''
      session_name: ekiree_dashboard

      windows:
      - window_name: term
        layout: main-vertical
        shell_command_before:
          - cd ekiree_dashboard
        panes:
          - shell_command:
            - clear
            focus: true
          - shell_command:
            - clear
            - python manage.py runserver

      - window_name: git
        panes:
          - shell_command:
            - lazygit
    '';
  };
  
  sesh.sessions = lib.mkAfter [
  sesh.sessions = lib.mkAfter [
    {
      name = "Second_Brain";
      path = "~/Vaults/Second_Brain";
      startupCommand = "nvim . && tmux new-window lazygit";
    }
    {
      name = "ekiree_dashboard";
      path = "~/Projects/dashboard/dev/ekiree_dashboard";
      startupCommand = "tmuxp load -a ekiree_dashboard && tmux split-window -h -l 30% && nvim && tmux new-window lazygit";
    }
  ];
}

