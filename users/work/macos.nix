{pkgs, ...}: {
  # -------------------- macOS-specific Configuration --------------------
  
  # macOS desktop environment (custom module option)
  mac-desktop.enable = true;
  
  # Programs configuration (home-manager native)
  # programs.bash.enable = true;
  programs.zsh.enable = true;
}
