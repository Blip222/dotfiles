local M = {};

local colors = {
  bg          = "NONE",
  primary     = "#00D8FF",
  secondary   = "#0F1A2A",
  darkBlue    = "#1A3A63",
  lightGray   = "#C8D6E5",
  harborGray  = "#82A3B8",
  charcoal    = "#4A607A",
  trim        = "#00B8D4",
  black       = "#050A12",
  vegusGold   = "#E0C068",
  transGray   = "#627A94",
  seafoamTeal = "#2CEAA3",
  bluePurple  = "#6C8EEF",
  white       = "#F0F6FC",
  mintGreen   = "#00E676",
  amber       = "#FFAB40",
  eclipsBlack = "#0A111A",
}

function M.colorscheme()

  vim.cmd('highlight clear')
  vim.cmd('syntax reset')

  vim.o.termguicolors = true
  vim.o.background = "dark";
  vim.g.colors_name = "dark_blue_transparent"

  vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"

  local set = vim.api.nvim_set_hl  

--set(0,"",{})

  set(0,"Normal", {bg = colors.bg, fg = colors.primary}) --background
  set(0,"Cursor",  {fg = colors.black, bg = colors.primary }) --cursor background
  set(0,"CursorLine",{bg = colors.secondary})
  set(0,"CursorLineNr",{fg=colors.primary})
  set(0,"Type",{fg = colors.bluePurple})
  set(0,"StorageClass",{fg = colors.vegusGold})
  set(0,"Structure",{fg = colors.mintGreen})
  set(0,"Constant",{fg = colors.darkBlue})
  set(0,"Character",{fg=colors.primary})
  set(0,"Number",{fg = colors.primary})
  set(0,"Boolean",{fg = colors.charcoal})
  set(0,"Float",{fg = colors.primary})
  set(0,"Statement",{fg = colors.primary})
  set(0,"Label",{fg =colors.bluePurple})
  set(0,"Operator",{fg = colors.seafoamTeal})
  set(0,"Exception",{fg = colors.amber})
  set(0,"PreProc",{fg = colors.vegusGold})
  set(0,"Include",{fg = colors.vegusGold})
  set(0,"Define",{fg = colors.vegusGold})
  set(0,"Macro",{fg = colors.vegusGold})
  set(0,"Typedef",{fg = colors.mintGreen})
  set(0,"PreCondit",{})
  set(0,"Special",{fg = colors.vegusGold})
  set(0,"SpecialChar",{fg = colors.vegusGold})
  set(0,"Tag",{fg = colors.primary})
  set(0,"Delimiter",{fg = colors.white})
  set(0,"SpecialComment",{fg = colors.mintGreen})
  set(0,"Debug",{fg = colors.amber})
  set(0,"Underlined",{fg = colors.white})
  --set(0,"Ignore",{})
  set(0,"Todo",{fg = "#000000", bg = colors.mintGreen, bold=true, italic=true, underline=true})
  set(0,"@comment.todo.comment",{fg = "#000000", bg = colors.mintGreen, bold=true, italic=true, underline=true}) 
  set(0, "@lsp.type.comment", {fg=colors.transGray, italic=true})
  --set(0,"Conceal",{})
  set(0,"Error",{fg = colors.amber})
  set(0,"Comment",{fg = colors.transGray, italic=true})
  set(0,"Conditional",{fg = colors.seafoamTeal, italic=true})
  set(0,"Function",{fg = colors.white, italic=true})
  set(0,"Identifier",{fg = colors.primary, italic=true})
  set(0,"Keyword",{fg = colors.vegusGold, italic=true})
  set(0,"Repeat",{fg = colors.vegusGold, italic=true})
  set(0,"String",{fg = colors.harborGray})
  set(0,"@variable",{fg = colors.primary})
  set(0,"Directory",{fg = colors.lightGray})

  --Buffers
  set(0, "NormalFloat",    { bg = colors.secondary, fg = colors.white })
  set(0, "FloatBorder",    { bg = colors.secondary, fg = colors.trim })
  set(0, "WinSeparator",   { fg = colors.darkBlue })
  set(0, "CursorLine",     { bg = colors.secondary })
  set(0, "LineNr",         { fg = colors.transGray })
  set(0, "SignColumn",     { bg = colors.bg })
  set(0, "Visual",         { bg = colors.darkBlue })
  set(0, "Search",         { fg = colors.black, bg = colors.vegusGold })
  set(0, "IncSearch",      { fg = colors.black, bg = colors.amber })
  set(0, "StatusLine",     { fg = colors.white, bg = colors.secondary })
  set(0, "StatusLineNC",   { fg = colors.transGray, bg = colors.eclipsBlack })
  set(0, "TabLine",        { fg = colors.harborGray, bg = colors.eclipsBlack })
  set(0, "TabLineSel",     { fg = colors.primary, bg = colors.secondary, bold = true })
  set(0, "TabLineFill",    { bg = colors.bg })
  set(0, "Pmenu",          { fg = colors.lightGray, bg = colors.secondary })
  set(0, "PmenuSel",       { fg = colors.black, bg = colors.primary, bold = true })
  set(0, "EndOfBuffer",    { fg = colors.charcoal })

  --Floating windows
  set(0, "BufferTabpageFill", { bg = colors.bg })
  set(0, "BufferCurrent", { bg = colors.darkBlue, fg = colors.white })
  set(0, "BufferCurrentMod", { bg = colors.darkBlue, fg = colors.amber })
  set(0, "BufferCurrentIcon", { bg = colors.darkBlue, fg = colors.primary })
  set(0, "BufferCurrentSign", { bg = colors.darkBlue, fg = colors.trim })
  set(0, "BufferCurrentIndex", { bg = colors.darkBlue, fg = colors.primary })
  set(0, "BufferCurrentTarget", { bg = colors.darkBlue, fg = colors.mintGreen })

  set(0, "BufferInactive", { bg = colors.secondary, fg = colors.harborGray })
  set(0, "BufferInactiveMod", { bg = colors.secondary, fg = colors.amber })
  set(0, "BufferInactiveIcon", { bg = colors.secondary, fg = colors.transGray })
  set(0, "BufferInactiveSign", { bg = colors.secondary, fg = colors.transGray })
  set(0, "BufferInactiveIndex", { bg = colors.secondary, fg = colors.transGray })
  set(0, "BufferInactiveTarget", { bg = colors.secondary, fg = colors.mintGreen })

  set(0, "BufferVisible", { bg = colors.charcoal, fg = colors.lightGray })
  set(0, "BufferVisibleMod", { bg = colors.charcoal, fg = colors.amber })
  set(0, "BufferVisibleIcon", { bg = colors.charcoal, fg = colors.lightGray })
  set(0, "BufferVisibleSign", { bg = colors.charcoal, fg = colors.lightGray })
  set(0, "BufferVisibleIndex", { bg = colors.charcoal, fg = colors.lightGray })
  set(0, "BufferVisibleTarget", { bg = colors.charcoal, fg = colors.mintGreen })

  -- Bufferline.nvim
  set(0, "BufferLineFill",              { bg = colors.bg })
  set(0, "BufferLineBackground",        { bg = colors.secondary, fg = colors.harborGray })
  set(0, "BufferLineBufferVisible",     { bg = colors.charcoal, fg = colors.lightGray })
  set(0, "BufferLineBufferSelected",    { bg = colors.darkBlue, fg = colors.white, bold = true, italic = false })

  -- Separators & Indicators
  set(0, "BufferLineSeparator",         { bg = colors.secondary, fg = colors.bg })
  set(0, "BufferLineSeparatorVisible",  { bg = colors.charcoal, fg = colors.bg })
  set(0, "BufferLineSeparatorSelected", { bg = colors.darkBlue, fg = colors.bg })
  set(0, "BufferLineIndicatorSelected", { bg = colors.darkBlue, fg = colors.trim })

  -- Modified & Close Icons
  set(0, "BufferLineModified",          { bg = colors.secondary, fg = colors.amber })
  set(0, "BufferLineModifiedVisible",   { bg = colors.charcoal, fg = colors.amber })
  set(0, "BufferLineModifiedSelected",  { bg = colors.darkBlue, fg = colors.amber })
  set(0, "BufferLineCloseButton",       { bg = colors.secondary, fg = colors.transGray })
  set(0, "BufferLineCloseButtonVisible",{ bg = colors.charcoal, fg = colors.lightGray })
  set(0, "BufferLineCloseButtonSelected",{ bg = colors.darkBlue, fg = colors.primary })

  -- Tabpages
  set(0, "BufferLineTab",               { bg = colors.secondary, fg = colors.harborGray })
  set(0, "BufferLineTabSelected",       { bg = colors.darkBlue, fg = colors.primary, bold = true })
  set(0, "BufferLineTabClose",          { bg = colors.secondary, fg = colors.amber })

  -- Treesitter Syntax
  set(0, "@variable",          { fg = colors.lightGray }) -- Easier on the eyes than pure cyan
  set(0, "@variable.builtin",  { fg = colors.amber, italic = true }) -- self, this, nil
  set(0, "@property",          { fg = colors.primary })
  set(0, "@parameter",         { fg = colors.lightGray, italic = true })
  set(0, "@function",          { fg = colors.white, italic = true })
  set(0, "@function.call",     { fg = colors.white })
  set(0, "@function.builtin",  { fg = colors.trim })
  set(0, "@keyword",           { fg = colors.vegusGold, italic = true })
  set(0, "@keyword.return",    { fg = colors.seafoamTeal, bold = true })
  set(0, "@type",              { fg = colors.bluePurple })
  set(0, "@type.builtin",      { fg = colors.bluePurple, italic = true })
  set(0, "@constant",          { fg = colors.seafoamTeal })
  set(0, "@constant.builtin",  { fg = colors.amber }) -- true, false, null
  set(0, "@punctuation.bracket",{ fg = colors.harborGray })

  -- LSP Diagnostics (Errors, Warnings, Hints)
  set(0, "DiagnosticError",    { fg = colors.amber })
  set(0, "DiagnosticWarn",     { fg = colors.vegusGold })
  set(0, "DiagnosticInfo",     { fg = colors.primary })
  set(0, "DiagnosticHint",     { fg = colors.seafoamTeal })

  -- Diagnostics Underlines
  set(0, "DiagnosticUnderlineError", { sp = colors.amber, undercurl = true })
  set(0, "DiagnosticUnderlineWarn",  { sp = colors.vegusGold, undercurl = true })
  set(0, "DiagnosticUnderlineInfo",  { sp = colors.primary, undercurl = true })
  set(0, "DiagnosticUnderlineHint",  { sp = colors.seafoamTeal, undercurl = true })

  -- Git Signs (gitsigns.nvim)
  set(0, "GitSignsAdd",        { fg = colors.mintGreen })
  set(0, "GitSignsChange",     { fg = colors.vegusGold })
  set(0, "GitSignsDelete",     { fg = colors.amber })


end

return M


--Notes
--Must run :TSInstall comment before you get TODO's
--:Inspect is a god send
