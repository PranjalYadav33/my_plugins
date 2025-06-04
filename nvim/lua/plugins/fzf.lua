return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" }, -- Assuming mini.icons is also in your lazy.setup
  opts = {}, -- You can add fzf-lua specific options here later if needed
  keys = { -- <-------------------- CORRECTED
    {
      "<leader>ff",
      function()
        -- It's good practice to wrap require in pcall when called from mappings
        -- to prevent errors from breaking the mapping entirely.
        local ok, fzflua = pcall(require, "fzf-lua")
        if ok then
          fzflua.files()
        else
          print("Error: fzf-lua module not found or error during load for files().")
        end
      end,
      desc = "Find Files (fzf-lua)"
    },
    {
      "<leader>fg",
      function()
        local ok, fzflua = pcall(require, "fzf-lua")
        if ok then
          fzflua.live_grep() -- <-------------------- CORRECTED
        else
          print("Error: fzf-lua module not found or error during load for live_grep().")
        end
      end,
      desc = "Live Grep (fzf-lua)"
    },
  }
}
