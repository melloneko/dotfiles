{ ... }:
{
  flake.modules.nixos.audio = {
    services.pipewire.enable = true;

    services.mpd = {
      enable = true;
      settings = {
        music_directory = "/home/shrek/Music";
        audio_output = [
          {
            type = "alsa";
            name = "Output";
            format = "44100:16:2";
            mixer_type = "hardware";
            mixer_device = "default";
            mixer_control = "PCM";
          }
          {
            type = "fifo";
            name = "Visualizer";
            path = "/tmp/mpd.fifo";
            format = "44100:16:2";
          }
        ];
      };
    };
  };
}
