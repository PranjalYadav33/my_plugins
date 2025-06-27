return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- oil needs icons
  config = function()
    require('oil').setup({
      -- Optional, you can add configuration options here
      -- For example, to see hidden files
      view_options = {
        show_hidden = true,
      },
    })

    -- Add a keymap to easily open oil
    -- This maps the "-" key in normal mode to open oil in the current directory
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory with oil.nvim' })
  end,
}
