{pkgs, ...}: {
  # -------------------- User Preferences (same across all machines) --------------------
  # User info (home-manager native)
  home.username = "noah";
  
  # Session variables (home-manager native)
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  
  # Allow unfree packages (nixpkgs native)
  nixpkgs.config.allowUnfree = true;

  # Common packages (home-manager native)
  home.packages = with pkgs; [
    tree
    obsidian
    onlyoffice-desktopeditors
    presenterm
    vlc
    zoom-us
  ];

  # Shell and terminal (custom module options)
  fish.enable = true;
  nushell.enable = true;
  ghostty.enable = true;
  alacritty.enable = true;
  
  # Development tools (custom module options)
  devPkgs.enable = true;
  dev-cloud.enable = true;
  dev-kubernetes.enable = true;
  nvim.enable = true;
  
  # Common sesh sessions (custom module option)
  sesh = {
    enable = true;
    sessions = [
      {
        name = "nixos";
        path = "~/.nixos";
        startupCommand = "tmux rename-window config && tmux split-window -h -l 30% && tmux new-window -n lazygit lazygit && tmux select-window -t 1 && nvim";
      }
      {
        name = "nvim-dev";
        path = "~/.config/nvim";
        startupCommand = "nvim && tmux new-window lazygit";
      }
    ];
  };
  
  programs.home-manager.enable = true;
  
  home.stateVersion = "23.11";
}
