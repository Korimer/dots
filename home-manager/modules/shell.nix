{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    presets = [
      "gruvbox-rainbow"
    ];
  };

  programs.zsh = {
    enable = true;
    initContent = ''
      exec fish
    '';
  };

  programs.fish = {
    enable = true;
  };
}
