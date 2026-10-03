local M = {}

M.colors = require("vercel.colors").getColors("light")
M.config = require("vercel.config")
M.utils = require("vercel.utils")

---@param options table|nil Options
function M.setup(options)
  options = options or {}

  setmetatable(M.config, { __index = vim.tbl_extend("force", M.config.defaults, options) })

  -- Re-apply the colorscheme when the background changes so theme toggles
  -- (e.g. Snacks <leader>ub) stay in sync.
  vim.api.nvim_create_autocmd("OptionSet", {
    group = vim.api.nvim_create_augroup("vercel.nvim", { clear = true }),
    pattern = "background",
    callback = function()
      if (vim.g.colors_name or ""):find("vercel") then
        M.colorscheme()
      end
    end,
  })
end

function M.colorscheme()
  vim.api.nvim_command("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.api.nvim_command("syntax reset")
  end

  vim.g.VM_theme_set_by_colorscheme = true
  vim.o.termguicolors = true
  vim.g.colors_name = "vercel"

  M.colors = require("vercel.colors").getColors(M.config.theme or vim.opt.background:get())

  M.set_terminal_colors()
  M.set_groups()
  M.set_bufferline_highlights()
  M.set_lazygit_theme()
end

---Apply BufferLine* highlight groups directly so users don't need to wire
---`opts.highlights` into bufferline.nvim themselves.
function M.set_bufferline_highlights()
  local bufferline = require("vercel.integrations.bufferline")
  M.highlights = { bufferline = bufferline.highlights(M.config) }
  for name, opts in pairs(M.highlights.bufferline) do
    vim.api.nvim_set_hl(0, bufferline.group_name(name), opts)
  end
end

---Override snacks.nvim's lazygit theme so its inactive border follows the
---foreground color instead of the border color, leaving the rest untouched.
function M.set_lazygit_theme()
  require("vercel.integrations.lazygit").apply()
end

function M.set_terminal_colors()
  local c = M.colors
  vim.g.terminal_color_0 = c.background_reverse
  vim.g.terminal_color_1 = c.red
  vim.g.terminal_color_2 = c.green
  vim.g.terminal_color_3 = c.amber
  vim.g.terminal_color_4 = c.blue
  vim.g.terminal_color_5 = c.purple
  vim.g.terminal_color_6 = c.teal
  vim.g.terminal_color_7 = c.foreground_reverse
  vim.g.terminal_color_8 = c.background_reverse
  vim.g.terminal_color_9 = c.red
  vim.g.terminal_color_10 = c.green
  vim.g.terminal_color_11 = c.amber
  vim.g.terminal_color_12 = c.blue
  vim.g.terminal_color_13 = c.purple
  vim.g.terminal_color_14 = c.teal
  vim.g.terminal_color_15 = c.foreground_reverse
  vim.g.terminal_color_background = M.colors.background
  vim.g.terminal_color_foreground = M.colors.foreground
end

function M.set_groups()
  local bg = M.config.transparent and "NONE" or M.colors.background
  local fg = M.colors.foreground

  local groups = {
    -- Base, see https://neovim.io/doc/user/syntax/#highlight-groups
    ColorColumn = { bg = M.colors.background_match },
    Conceal = {},
    CurSearch = {
      bg = M.colors.background_match,
      fg = M.colors.foreground_match,
    },
    -- TODO: fg or bg?
    Cursor = { fg = fg },
    lCursor = { link = "Cursor" },
    CursorIM = { link = "Cursor" },
    CursorColumn = { link = "CursorLine" },
    CursorLine = { bg = M.colors.background_hover },
    Directory = { fg = fg },
    DiffAdd = {
      bg = M.colors.background_diff_add,
      fg = M.colors.green,
    },
    DiffChange = {
      bg = M.colors.background_diff_change,
      fg = M.colors.amber,
    },
    DiffDelete = {
      bg = M.colors.background_diff_delete,
      fg = M.colors.red,
    },
    DiffText = { fg = M.colors.amber },
    DiffTextAdd = { fg = M.colors.green },
    EndOfBuffer = { fg = M.colors.blue },
    TermCursor = { link = "Cursor" },
    OkMsg = { fg = M.colors.green },
    WarningMsg = { fg = M.colors.amber },
    ErrorMsg = { fg = M.colors.red },
    StderrMsg = { link = "ErrorMsg" },
    StdoutMsg = { fg = M.colors.foreground },
    Winseparator = { fg = M.colors.border, bg = "NONE" },
    Folded = { bg = M.colors.background_active },
    FoldColumn = { link = "SignColumn" },
    SignColumn = { link = "Normal" },
    IncSearch = {
      bg = M.colors.background_match,
      fg = M.colors.foreground_match,
    },
    Substitute = { link = "IncSearch" },
    LineNr = { fg = fg },
    LineNrAbove = { fg = M.colors.secondary },
    LineNrBelow = { link = "LineNrAbove" },
    CursorLineNr = { fg = M.colors.secondary },
    CursorLineFold = { link = "SignColumn" },
    CursorLineSign = { link = "SignColumn" },
    MatchParen = { fg = M.colors.pink },
    MCursor = { fg = fg },
    MCursorVisual = { link = "MCursor" },
    ModeMsg = { link = "Normal" },
    MsgArea = { link = "Normal" },
    -- MsgSeparator = {},
    MoreMsg = { fg = M.colors.blue },
    NonText = { fg = M.colors.tertiary },
    Normal = { fg = fg, bg = bg },
    NormalFloat = { link = "Normal" },
    FloatBorder = { fg = M.colors.border },
    -- FloatShadow = {},
    -- FloatShadowThrough = {},
    -- FloatTitle = {},
    -- FloatFooter = {},
    NormalNC = { link = "Normal" },
    Pmenu = { link = "NormalFloat" },
    PmenuSel = { bg = M.colors.background_active },
    -- PmenuKind = {},
    -- PmenuKindSel = {},
    -- PmenuExtra = {},
    -- PmenuExtraSel = {},
    PmenuSbar = { bg = M.colors.scrollbar_tracker },
    PmenuThumb = { bg = M.colors.scrollbar_thumb },
    -- PmenuMatch = {},
    -- PmenuMatchSel = {},
    PmenuBorder = { link = "FloatBorder" },
    -- PmenuShadow = {},
    -- PmenuShadowThrough = {},
    -- ComplMatchIns = {},
    -- PreInsert = {},
    -- ComplHint = {},
    -- ComplHintMore = {},
    Question = { fg = M.colors.purple },
    QuickFixLine = { fg = M.colors.purple },
    Search = {
      bg = M.colors.background_match,
      fg = M.colors.foreground_match,
    },
    -- SnippetTabstop = {},
    -- SnippetTabstopActive = {},
    SpecialKey = { fg = fg },
    SpellBad = { undercurl = true, sp = M.colors.red },
    SpellCap = { undercurl = true, sp = M.colors.purple },
    SpellLocal = { undercurl = true, sp = M.colors.blue },
    SpellRare = { undercurl = true, sp = M.colors.amber },
    StatusLine = { fg = fg, bg = bg },
    StatusLineNC = {
      fg = M.colors.tertiary,
      bg = bg,
    },
    TabLine = {
      fg = M.colors.secondary,
      bg = bg,
    },
    TabLineFill = { link = "TabLine" },
    TabLineSel = {
      fg = fg,
      bg = M.colors.background_active,
    },
    Title = { fg = M.colors.blue, bold = true },
    Visual = { bg = M.colors.background_hover },
    VisualNOS = { link = "Visual" },
    Whitespace = { fg = M.colors.tertiary },
    WildMenu = { bg = bg, fg = fg },
    -- WinBar = {},
    -- WinBarNC = {},
    Menu = { bg = bg, fg = fg },
    Scrollbar = {
      fg = M.colors.scrollbar_thumb,
      bg = M.colors.scrollbar_tracker,
    },
    Tooltip = {
      bg = bg,
      fg = fg,
    },

    Comment = {
      fg = M.colors.tertiary,
      italic = M.config.italics.comments or false,
    },
    Constant = { fg = M.colors.blue },
    String = {
      fg = M.colors.green,
      italic = M.config.italics.strings or false,
    },
    Character = { fg = M.colors.green },
    Number = { fg = M.colors.blue },
    Boolean = { fg = M.colors.blue },
    Float = { link = "Number" },
    Identifier = { fg = fg },
    Function = { fg = M.colors.purple },
    Method = { fg = M.colors.purple },
    Property = { fg = M.colors.blue },
    Field = { link = "Property" },
    Parameter = { fg = fg },
    Statement = { fg = M.colors.pink },
    Conditional = { fg = M.colors.pink },
    -- Repeat = {},
    Label = { fg = M.colors.purple },
    Operator = { fg = M.colors.pink },
    Keyword = { link = "Statement", italic = M.config.italics.keywords or false },
    Exception = { fg = M.colors.pink },
    PreProc = { link = "Keyword" },
    -- Include = {},
    Define = { fg = M.colors.blue },
    Macro = { link = "Define" },
    PreCondit = { fg = M.colors.pink },
    Type = { fg = M.colors.purple },
    Struct = { link = "Type" },
    Class = { link = "Type" },
    -- StorageClass = {},
    -- Structure = {},
    -- Typedef = {},
    Attribute = { fg = M.colors.blue },
    Punctuation = { fg = fg },
    Special = { fg = fg },
    SpecialChar = { fg = M.colors.red },
    Tag = { fg = M.colors.green },
    Delimiter = { fg = fg },
    -- SpecialComment = {},
    Debug = { fg = fg },
    Underlined = { underline = true },
    Bold = { bold = true },
    Italic = { italic = true },
    Ignore = { fg = bg },
    Error = { link = "ErrorMsg" },
    Todo = { fg = M.colors.blue, bold = true },

    -- LspCodeLens = {},
    -- LspCodeLensSeparator = {},
    LspInlayHint = { link = "Comment" },
    -- LspReferenceRead = {},
    -- LspReferenceText = {},
    -- LspReferenceWrite = {},
    -- LspSignatureActiveParameter = {},

    DiagnosticError = { link = "Error" },
    DiagnosticWarn = { link = "WarningMsg" },
    DiagnosticInfo = { fg = M.colors.blue },
    DiagnosticHint = { fg = M.colors.blue },
    DiagnosticVirtualTextError = { link = "DiagnosticError" },
    DiagnosticVirtualTextWarn = { link = "DiagnosticWarn" },
    DiagnosticVirtualTextInfo = { link = "DiagnosticInfo" },
    DiagnosticVirtualTextHint = { link = "DiagnosticHint" },
    DiagnosticUnderlineError = { undercurl = true, link = "DiagnosticError" },
    DiagnosticUnderlineWarn = { undercurl = true, link = "DiagnosticWarn" },
    DiagnosticUnderlineInfo = { undercurl = true, link = "DiagnosticInfo" },
    DiagnosticUnderlineHint = { undercurl = true, link = "DiagnosticHint" },
    -- DiagnosticFloatingError = {},
    -- DiagnosticFloatingWarn = {},
    -- DiagnosticFloatingInfo = {},
    -- DiagnosticFloatingHint = {},
    -- DiagnosticSignError = {},
    -- DiagnosticSignWarn = {},
    -- DiagnosticSignInfo = {},
    -- DiagnosticSignHint = {},

    ["@text"] = { fg = fg },
    ["@texcolorscheme.literal"] = { link = "Property" },
    -- ["@texcolorscheme.reference"] = {},
    ["@texcolorscheme.strong"] = { link = "Bold" },
    ["@texcolorscheme.italic"] = { link = "Italic" },
    ["@texcolorscheme.title"] = { link = "Keyword" },
    ["@texcolorscheme.uri"] = {
      fg = M.colors.blue,
      sp = M.colors.blue,
      underline = true,
    },
    ["@texcolorscheme.underline"] = { link = "Underlined" },
    ["@symbol"] = { fg = fg },
    ["@texcolorscheme.todo"] = { link = "Todo" },
    ["@comment"] = { link = "Comment" },
    ["@punctuation"] = { link = "Punctuation" },
    ["@punctuation.bracket"] = { fg = fg },
    ["@punctuation.delimiter"] = { fg = fg },
    ["@punctuation.terminator.statement"] = { link = "Delimiter" },
    ["@punctuation.special"] = { fg = M.colors.pink },
    ["@punctuation.separator.keyvalue"] = { fg = M.colors.pink },

    ["@texcolorscheme.diff.add"] = { fg = M.colors.blue },
    ["@texcolorscheme.diff.delete"] = { fg = M.colors.pink },

    ["@constant"] = { link = "Constant" },
    ["@constant.builtin"] = { link = "Constant" },
    ["@constancolorscheme.builtin"] = { link = "Keyword" },
    -- ["@constancolorscheme.macro"] = {},
    -- ["@define"] = {},
    -- ["@macro"] = {},
    ["@string"] = { link = "String" },
    -- TODO: No source evidence from vercel.com!
    ["@string.escape"] = { fg = M.colors.pink },
    ["@string.special"] = { fg = M.colors.pink },
    -- ["@character"] = {},
    -- ["@character.special"] = {},
    ["@number"] = { link = "Number" },
    ["@number.tsx"] = { link = "Constant" },
    ["@boolean"] = { link = "Boolean" },
    -- ["@float"] = {},
    ["@function"] = {
      link = "Function",
      italic = M.config.italics.functions or false,
    },
    ["@function.call"] = { link = "Function" },
    ["@function.builtin"] = { link = "Function" },
    -- ["@function.macro"] = {},
    ["@parameter"] = { link = "Parameter" },
    ["@method"] = { link = "Function" },
    ["@field"] = { link = "Property" },
    ["@property"] = { link = "Property" },
    ["@constructor"] = { fg = M.colors.purple },
    -- ["@conditional"] = {},
    -- ["@repeat"] = {},
    ["@label"] = { link = "Label" },
    ["@operator"] = { link = "Operator" },
    ["@exception"] = { link = "Exception" },
    ["@variable"] = {
      fg = fg,
      italic = M.config.italics.variables or false,
    },
    ["@variable.builtin"] = { fg = M.colors.blue },
    ["@variable.member"] = { fg = fg },
    ["@variable.parameter"] = {
      fg = fg,
      italic = M.config.italics.variables or false,
    },
    ["@type"] = { link = "Type" },
    ["@type.definition"] = { fg = fg },
    ["@type.builtin"] = { fg = M.colors.blue },
    ["@type.qualifier"] = { fg = M.colors.purple },
    ["@type.tsx"] = { fg = fg },
    ["@module.tsx"] = { fg = fg },
    ["@keyword"] = { link = "Keyword" },
    -- ["@storageclass"] = {},
    -- ["@structure"] = {},
    ["@namespace"] = { fg = M.colors.blue },
    ["@annotation"] = { link = "Label" },
    -- ["@include"] = {},
    -- ["@preproc"] = {},
    ["@debug"] = { fg = fg },
    ["@tag"] = { link = "Tag" },
    ["@tag.builtin"] = { link = "Tag" },
    ["@tag.delimiter"] = { fg = fg },
    ["@tag.attribute"] = { fg = M.colors.blue },
    ["@tag.jsx.element"] = { fg = M.colors.blue },
    ["@tag.tsx"] = { fg = M.colors.blue },
    ["@attribute"] = { fg = M.colors.blue },
    ["@error"] = { link = "Error" },
    ["@warning"] = { link = "WarningMsg" },
    ["@info"] = { fg = M.colors.blue },

    -- Specific languages
    -- overrides
    ["@label.json"] = { fg = fg }, -- For json
    ["@label.help"] = { link = "@texcolorscheme.uri" }, -- For help files
    ["@texcolorscheme.uri.html"] = { underline = true }, -- For html
    ["@markup.heading"] = { fg = fg, bold = true }, -- For markdown

    -- semantic highlighting
    ["@lsp.type.namespace"] = { link = "@namespace" },
    ["@lsp.type.type"] = { link = "@function" },
    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { fg = M.colors.purple },
    ["@lsp.type.interface"] = { link = "@function" },
    ["@lsp.type.struct"] = { link = "@type" },
    ["@lsp.type.parameter"] = { link = "@parameter" },
    ["@lsp.type.property"] = { link = "@text" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.method"] = { link = "@method" },
    ["@lsp.type.macro"] = { link = "@label" },
    ["@lsp.type.decorator"] = { link = "@label" },
    ["@lsp.type.variable"] = { link = "@text" },

    -- specific typescriptreact highlights
    ["@type.typescript"] = { fg = fg },
    ["@lsp.type.variable.typescript"] = { fg = M.colors.blue },
    ["@lsp.type.property.typescript"] = { fg = fg },
    ["@lsp.type.typeParameter.typescript"] = { fg = M.colors.purple },
    ["@lsp.mod.local.typescript"] = { fg = fg },
    ["@lsp.typemod.property.declaration.typescript"] = { fg = fg },
    ["@lsp.typemod.variable.declaration.typescript"] = { fg = M.colors.blue },
    ["@lsp.typemod.function.declaration.typescript"] = { fg = M.colors.purple },
    ["@lsp.typemod.variable.defaultLibrary.typescript"] = { fg = fg },

    ["@lsp.mod.declaration.typescriptreact"] = { fg = M.colors.purple },
    ["@lsp.typemod.variable.local.typescriptreact"] = { fg = fg },
    ["@lsp.typemod.variable.declaration.typescriptreact"] = { fg = M.colors.blue },
    ["@lsp.typemod.function.declaration.typescriptreact"] = { fg = M.colors.blue },
    ["@lsp.typemod.property.declaration.typescriptreact"] = { fg = fg },
    ["@lsp.typemod.variable.defaultLibrary.typescriptreact"] = { fg = M.colors.blue },

    ["@lsp.type.parameter.typescript"] = { fg = fg },
    ["@lsp.type.parameter.typescriptreact"] = { fg = fg },
    ["@lsp.typemod.parameter.declaration.typescript"] = { fg = fg },
    ["@lsp.typemod.parameter.declaration.typescriptreact"] = { fg = fg },
  }

  -- integrations
  -- groups = vim.tbl_extend("force", groups, require("vercel.integrations.{pack}").highlights())
  groups = vim.tbl_extend("force", groups, require("vercel.integrations.blink-cmp").highlights(M.config))
  groups = vim.tbl_extend("force", groups, require("vercel.integrations.cmp").highlights(M.config))

  -- overrides
  groups = vim.tbl_extend(
    "force",
    groups,
    type(M.config.overrides) == "function" and M.config.overrides(M.config) or M.config.overrides
  )

  for group, parameters in pairs(groups) do
    vim.api.nvim_set_hl(0, group, parameters)
  end
end

return M
