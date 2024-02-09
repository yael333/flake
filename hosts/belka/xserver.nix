{ pkgs, lib, config, ... }:

{
  services.xserver = {
    windowManager.bspwm.enable = true;
    videoDrivers = ["nvidia"]; # gotta get a new card ;w; 
    deviceSection = ''
      Option "TearFree" "true"
    '';
    dpi = 150;
     #displayManager.setupCommands = ''
      #${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --off --output DVI-D-1 --off --output DP-1 --mode 1920x1080 --pos 2560x0 --rotate normal --output DP-2 --primary --mode 2
     #560x1440 --pos 0x0 --rotate normal --output DP-3 --off
    #'';
  };

  hardware.nvidia = {

    # Modesetting is required.
    #modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    #powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    #powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    #open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
