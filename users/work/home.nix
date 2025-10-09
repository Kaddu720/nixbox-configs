{pkgs, ...}: {
  # -------------------- User Preferences (same across all machines) --------------------
  
  # Shell and terminal (custom module options)
  fish.enable = true;
  nushell.enable = true;
  ghostty.enable = true;
  alacritty.enable = true;
  
  # Development tools (custom module options)
  devPkgs.enable = true;
  dev-kubernetes.enable = true;
  dev-cloud.enable = true;
  nvim.enable = true;
  
  # Disable personal git credentials (custom module option)
  git.enable = false;
  
  # User info (home-manager native)
  home.username = "noahwilson";
  
  # Session variables (home-manager native)
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  
  # Common packages (home-manager native)
  home.packages = with pkgs; [
    obsidian
    slack
  ];
  
  # Allow unfree packages (nixpkgs native)
  nixpkgs.config.allowUnfree = true;
  
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
}
