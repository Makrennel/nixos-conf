{ config, inputs, lib, pkgs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    enableMan = true;

    clipboard.providers.wl-copy.enable = true;
    colorscheme = "kanagawa";
    colorschemes.kanagawa.enable = true;
    colorschemes.kanagawa.settings.transparent = true;
    extraConfigLuaPost = ''
      if vim.env.TERM == "tmux-256color" then
        vim.cmd 'colorscheme base16-macintosh'
      end
    '';
    opts.expandtab = true;
    opts.number = true;
    opts.relativenumber = true;
    opts.shiftwidth = 2;
    opts.smarttab = true;
    opts.softtabstop = 2;
    opts.tabstop = 2;
    viAlias = true;
    vimAlias = true;
  };
}

