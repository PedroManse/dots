{
  pkgs,
  enable ? true,
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
    (pkgs.vimUtils.buildVimPlugin {
      pname = "alabaster.nvim";
      version = "1.0.0";
      src = pkgs.fetchFromGitHub {
        owner = "p00f";
        repo = "alabaster.nvim";
        rev = "1fc9e29fbbce94f127cc8b21960b7e3c85187960";
        sha256 = "Xng+shYT7BtrD6ZSnCGgt01lm9ZALfYwivYRGRjNpUo=";
      };
      meta.homepage = "https://github.com/p00f/alabaster.nvim";
      meta.hydraPlatforms = [ ];
    })
  ];
}
