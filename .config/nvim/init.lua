vim.g.mapleader = " "


--   L a z y   -- 
--     - -     --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


--   P l u g i n s   --
--        - -        --

require("lazy").setup({spec = {

  {"nyoom-engineering/oxocarbon.nvim", lazy = false, priority = 1000, name = "oxocarbon",
  config = function()
    vim.cmd.colorscheme "oxocarbon"
  end},

  {"nvim-telescope/telescope.nvim", tag = '0.1.8', 
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  end},

  {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = { "lua", "javascript" },
      highlight = { enable = true},
      indent = { enable = true}})
  end},

  {"nvim-neo-tree/neo-tree.nvim", branch = "v3.x", 
  dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"},
  config = function()
    vim.keymap.set('n', '<leader>fs', ':Neotree<CR>', {})
  end},

  {"nvim-lualine/lualine.nvim",
  config = function()
    require('lualine').setup({options = {theme = 'oxocarbon'}})
  end}
},
checker = {enabled = true} })
