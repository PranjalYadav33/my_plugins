-- lua/plugins/flash.lua
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  -- Optional: You can configure keys directly in the plugin spec
  keys = {
    {
      "s", -- The key you press to start the leap
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash Jump",
    },
    {
      "S", -- A capital S for searching across all your open windows
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
}
