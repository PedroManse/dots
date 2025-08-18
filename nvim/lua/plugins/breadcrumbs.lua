return {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
		lazy = false,
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
    config = function()
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', 'g;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', 'g:', dropbar_api.select_next_context, { desc = 'Select next context' })
    end
  }
