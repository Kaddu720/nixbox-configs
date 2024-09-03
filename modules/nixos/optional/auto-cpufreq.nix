{
  config,
  lib,
  ...
}: {
  options = {
    auto-cpufreq.enable =
      lib.mkEnableOption "enables auto-cpufreq";
  };

  config = lib.mkIf config.auto-cpufreq.enable {
    # Configure Programs
    programs = {
      # Battery Power Controls
      auto-cpufreq = {
        enable = true;
        settings = {
          charger = {
            governor = "performance";
            turbo = "auto";
          };

          battery = {
            governor = "powersave";
            turbo = "auto";
          };
        };
      };
    };
  };
}
