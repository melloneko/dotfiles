{ ... }:
{
  flake.modules.nixos.audio = {
    services.pipewire.enable = true;
    systemd.services.mpd.environment = {
      XDG_RUNTIME_DIR = "/run/user/1000";
    };
    services.mpd = {
      enable = true;
      settings = {
        port = 6600;
        auto_update = "yes";
        music_directory = "/home/shrek/Music";
        audio_output = [
          {
            type = "pipewire";
            name = "Output";
            format = "44100:16:2";
            mixer_type = "software";
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
