{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  security.rtkit.enable = true;

  hardware.pulseaudio.enable = false;
  sound.enable = true;
}
