{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  security.rtkit.enable = true;
  boot.kernelModules = ["snd-seq" "usb_midi" "snd_usb_lib"];

  hardware.pulseaudio.enable = false;
  sound.enable = true;
}
