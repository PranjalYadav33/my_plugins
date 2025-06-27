-- lua/config/options.lua

local opt = vim.opt -- for conciseness

-- LINE NUMBERS
opt.number = true         -- Show absolute line numbers
opt.relativenumber = true -- Show line numbers relative to the cursor

-- You can add other core options here too, for example:
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false -- Do not wrap long lines

opt.ignorecase = true
opt.smartcase = true
