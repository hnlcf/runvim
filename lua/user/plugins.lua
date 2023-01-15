local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
})

-- Install Plugins
return packer.startup(function(use)
  -- My Plugins
  use("wbthomason/packer.nvim") -- Have packer manage itself
  use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

  use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
  use("numToStr/Comment.nvim") -- Easily comment stuff

  use("lewis6991/impatient.nvim") -- Speed up loading Lua modules in neovim to improve startup time
  use("lukas-reineke/indent-blankline.nvim")
  use("kyazdani42/nvim-web-devicons")
  use("goolord/alpha-nvim") -- a fast and fully customizable greeter for neovim
  use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
  use("kyazdani42/nvim-tree.lua") -- tree view
  use("akinsho/bufferline.nvim")
  use("moll/vim-bbye")
  use("nvim-lualine/lualine.nvim")
  use("akinsho/toggleterm.nvim")
  use("folke/which-key.nvim") -- vim which key

  -- Colorschemes
  use("projekt0n/github-nvim-theme")
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "ellisonleao/gruvbox.nvim" }

  -- cmp plugins
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")

  -- snippets
  use("L3MON4D3/LuaSnip") --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- Code runner
  use("CRAG666/code_runner.nvim")

  -- Vim css color
  use("ap/vim-css-color")

  -- Todo comments
  use("folke/todo-comments.nvim")

  -- Git
  use("lewis6991/gitsigns.nvim")
  use("tpope/vim-fugitive")

  -- LSP
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  use("filipdutescu/renamer.nvim") -- vscode like renamer
  use({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" }) -- show diagnostics using virtual lines
  use("p00f/clangd_extensions.nvim") -- clangd extension, some good stuff

  -- Debugging
  use("mfussenegger/nvim-dap")
  use("theHamsta/nvim-dap-virtual-text")
  use("rcarriga/nvim-dap-ui")
  use("rcarriga/cmp-dap")

  use("Civitasv/cmake-tools.nvim")

  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-ui-select.nvim")
  use("nvim-telescope/telescope-dap.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" })

  -- Markdown
  -- preview
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })
  use("godlygeek/tabular")
  use("preservim/vim-markdown")

  -- Copilot
  -- use("github/copilot.vim")

  -- editor config
  use("editorconfig/editorconfig-vim")

  -- Hop
  use("phaazon/hop.nvim")

  -- Fold Code
  use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })

  -- Surround
  use("kylechui/nvim-surround")

  -- Latex
  use("lervag/vimtex")

  -- Neovim config development
  use("folke/neodev.nvim")

  -- rust, rust, it's rust!
  use("simrat39/rust-tools.nvim")
  use {
    "saecki/crates.nvim",
    tag = "v0.3.0",
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end)
