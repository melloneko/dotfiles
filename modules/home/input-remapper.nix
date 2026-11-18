# input-remapper presets, version-controlled and portable.
# The `origin_hash` inside presets is md5(device capabilities + device
# name), which upstream keeps stable across reboots and machines — so the
# same preset works on another machine with the same keyboard model.
#
# These are symlinks into the Nix store: to change a mapping, edit the JSON
# under config/input-remapper-2/ and rebuild. Saving from the GUI will not
# persist across a rebuild. xmodmap.json is intentionally left local — the
# GUI regenerates it for the current keyboard layout.
{ ... }:
{
  flake.modules.homeManager.input-remapper = { ... }: {
    xdg.configFile = {
      "input-remapper-2/config.json" = {
        source = ../../config/input-remapper-2/config.json;
      };
      "input-remapper-2/presets/Razer Razer Ornata Chroma/Keymap.json" = {
        source = ../../config/input-remapper-2/presets + "/Razer Razer Ornata Chroma/Keymap.json";
      };
    };
  };
}
