{
  pkgs,
  enable ? true
}:
{
  inherit enable;
  defaultEditor = true;
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
    gruber-darker-nvim
    zig-vim
  ];
}
