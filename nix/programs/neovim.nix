{
  pkgs,
  enable ? true,
}:
{
  inherit enable;
  defaultEditor = true;
  withPython3 = false;
  withRuby = false;
  initLua = ''
    require('lsp')
    require('maps')
    require('options')
    require('vim')
    require('auto-cmd')
    require('color')
  '';
  plugins = with pkgs.vimPlugins; [
    vim-airline
    vim-airline-themes
    nvim-autopairs
    cmp-nvim-lsp
    nvim-cmp
    zenburn
    copilot-vim
    vim-flog
    vim-fugitive
    git-blame-nvim
    gitsigns-nvim
    haskell-tools-nvim
    nvim-lspconfig
    vim-visual-multi
    neomake
    vim-prisma
    rust-vim
    undotree
    zig-vim
  ];
}
