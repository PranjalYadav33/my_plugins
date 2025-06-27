-- lua/plugins/everforest.lua
return {
  'neanias/everforest-nvim',
  lazy = false,
  priority = 1000,
  config = function()
    -- Setup must be called before loading the colorscheme
    require('everforest').setup({
      -- Your existing options
      background = 'hard',

      -- ADD THIS LINE to enable transparency
      transparent_background = true,
    })
    
    -- Load the colorscheme
    vim.cmd.colorscheme('everforest')
  end,
}
