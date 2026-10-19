{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    sideloadInitLua = true;

    # environment
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;
    
    extraPython3Packages = p: with p; [
      pynvim
      jupyter-client
      ipython
      nbformat
      jupytext
    ];
  };

  programs.neovide.enable = true;
}
