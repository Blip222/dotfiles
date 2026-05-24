local M = {}

M.transparent = true

M.palette = {
  background = "#071026",
  foreground = "#CFE9FF",
  cursor = "#CFE9FF",
  black = "#0D0D10",
  red = "#4FC3F7",
  green = "#6EED76",
  yellow = "#FED7AB",
  blue = "#3B87FE",
  magenta = "#6EE7D6",
  cyan = "#4FC3F7",
  white = "#BACBDB",
  bright_black = "#5B6476",
}

local function apply_transparency()
  -- Core UI
  vim.cmd("hi Normal guibg=none")
  vim.cmd("hi NormalNC guibg=none")
  vim.cmd("hi SignColumn guibg=none")
  vim.cmd("hi LineNr guibg=none")
  vim.cmd("hi CursorLineNr guibg=none")
  vim.cmd("hi EndOfBuffer guibg=none")

  -- Floating windows
  vim.cmd("hi NormalFloat guibg=none")
  vim.cmd("hi FloatBorder guibg=none")
  vim.cmd("hi FloatTitle guibg=none")

  -- Popup menus (completion, command)
  vim.cmd("hi Pmenu guibg=none")
  vim.cmd("hi PmenuSel guibg=none")
  vim.cmd("hi PmenuSbar guibg=none")
  vim.cmd("hi PmenuThumb guibg=none")

  -- Telescope
  vim.cmd("hi TelescopeNormal guibg=none")
  vim.cmd("hi TelescopeBorder guibg=none")
  vim.cmd("hi TelescopePromptNormal guibg=none")
  vim.cmd("hi TelescopePromptBorder guibg=none")
  vim.cmd("hi TelescopeResultsNormal guibg=none")
  vim.cmd("hi TelescopeResultsBorder guibg=none")
  vim.cmd("hi TelescopePreviewNormal guibg=none")
  vim.cmd("hi TelescopePreviewBorder guibg=none")

  -- Bufferline
  vim.cmd("hi BufferLineFill guibg=none")
  vim.cmd("hi BufferLineBackground guibg=none")
  vim.cmd("hi BufferLineBufferSelected guibg=none")
  vim.cmd("hi BufferLineBufferVisible guibg=none")
  vim.cmd("hi BufferLineSeparator guibg=none")
  vim.cmd("hi BufferLineSeparatorSelected guibg=none")
  vim.cmd("hi BufferLineSeparatorVisible guibg=none")
  vim.cmd("hi BufferLineTab guibg=none")
  vim.cmd("hi BufferLineTabSelected guibg=none")
  vim.cmd("hi BufferLineTabClose guibg=none")
  vim.cmd("hi BufferLineCloseButton guibg=none")
  vim.cmd("hi BufferLineCloseButtonSelected guibg=none")
  vim.cmd("hi BufferLineCloseButtonVisible guibg=none")

  -- Treesitter (optional but looks cleaner)
  vim.cmd("hi @comment guibg=none")
  vim.cmd("hi @string guibg=none")
  vim.cmd("hi @keyword guibg=none")
end

function M.apply()
  vim.o.background = "dark"

  -- Base highlight
  vim.cmd("hi Normal guibg=" .. M.palette.background .. " guifg=" .. M.palette.foreground)

  -- Terminal colors
  vim.g.terminal_color_0 = M.palette.black
  vim.g.terminal_color_1 = M.palette.red
  vim.g.terminal_color_2 = M.palette.green
  vim.g.terminal_color_3 = M.palette.yellow
  vim.g.terminal_color_4 = M.palette.blue
  vim.g.terminal_color_5 = M.palette.magenta
  vim.g.terminal_color_6 = M.palette.cyan
  vim.g.terminal_color_7 = M.palette.white
  vim.g.terminal_color_8 = M.palette.bright_black
  vim.g.terminal_color_9 = M.palette.red
  vim.g.terminal_color_10 = M.palette.green
  vim.g.terminal_color_11 = M.palette.yellow
  vim.g.terminal_color_12 = M.palette.blue
  vim.g.terminal_color_13 = M.palette.magenta
  vim.g.terminal_color_14 = M.palette.cyan
  vim.g.terminal_color_15 = M.palette.white
  -- Bufferline minimal theme support
vim.cmd("hi BufferLineFill guibg=" .. M.palette.background)
vim.cmd("hi BufferLineBackground guibg=" .. M.palette.background)
vim.cmd("hi BufferLineBufferSelected guibg=" .. M.palette.background .. " guifg=" .. M.palette.foreground .. " gui=bold")
vim.cmd("hi BufferLineBufferVisible guibg=" .. M.palette.background .. " guifg=" .. M.palette.foreground)
vim.cmd("hi BufferLineSeparator guibg=" .. M.palette.background .. " guifg=" .. M.palette.bright_black)
vim.cmd("hi BufferLineSeparatorSelected guibg=" .. M.palette.background .. " guifg=" .. M.palette.blue)
vim.cmd("hi BufferLineSeparatorVisible guibg=" .. M.palette.background .. " guifg=" .. M.palette.bright_black)


  if M.transparent then
    apply_transparency()
  end
end

function M.toggle_transparency()
  M.transparent = not M.transparent
  M.apply()
end

return M

