local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<CR>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-j>", -- binding to scroll down inside the popup
    scroll_up = "<c-k>", -- binding to scroll up inside the popup
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local leader_opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local leader_mappings = {
  ["a"] = { "<cmd>Alpha<CR>", "Alpha" },
  ["w"] = { "<cmd>w<CR>", "Save" },
  ["q"] = { "<cmd>quit<CR>", "Quit" },
  ["n"] = { "<cmd>noh<CR>", "Clear Highlight" },
  ["x"] = { "<cmd>Bdelete!<CR>", "Delete current buffer" },

  c = {
    -- Typical cmake workflow:
    -- 1. CMake configure (only once)
    -- 2. CMake selec_target (ususally once)
    -- 3. CMake build (once change, build it)
    name = "CMake",
    g = { "<cmd>CMakeGenerate<CR>", "Generate" },
    x = { "<cmd>CMakeGenerate!<CR>", "Clean and Generate" },
    b = { "<cmd>CMakeBuild<CR>", "Build" },
    r = { "<cmd>CMakeRun<CR>", "Run" },
    d = { "<cmd>CMakeDebug<CR>", "Debug" },
    y = { "<cmd>CMakeSelectBuildType<CR>", "Select Build Type" },
    t = { "<cmd>CMakeSelectBuildTarget<CR>", "Select Build Target" },
    l = { "<cmd>CMakeSelectLaunchTarget<CR>", "Select Launch Target" },
    o = { "<cmd>CMakeOpen<CR>", "Open CMake Console" },
    c = { "<cmd>CMakeClose<CR>", "Close CMake Console" },
    i = { "<cmd>CMakeInstall<CR>", "Intall CMake target" },
    n = { "<cmd>CMakeClean<CR>", "Clean CMake target" },
    s = { "<cmd>CMakeStop<CR>", "Stop CMake Process" },
    p = { "<cmd>cd %:p:h<CR> ", "Change pwd to current file" }
  },

  d = {
    name = "Debug",
    t = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "Toggle Condition Breakpoint" },
    k = { "<cmd>lua require'dap'.up()<CR>", "Stack up" },
    j = { "<cmd>lua require'dap'.down()<CR>", "Stack down" },
    n = { "<cmd>lua require'dap'.run_to_cursor()<CR>", "Run To Cursor" },
    q = { "<cmd>lua require'dap'.terminate()<CR>", "Terminate" },
    --[[ .exit               Closes the REPL ]]
    --[[ .c or .continue     Same as |dap.continue| ]]
    --[[ .n or .next         Same as |dap.step_over| ]]
    --[[ .into               Same as |dap.step_into| ]]
    --[[ .into_target        Same as |dap.step_into{askForTargets=true}| ]]
    --[[ .out                Same as |dap.step_out| ]]
    --[[ .up                 Same as |dap.up| ]]
    --[[ .down               Same as |dap.down| ]]
    --[[ .goto               Same as |dap.goto_| ]]
    --[[ .scopes             Prints the variables in the current scopes ]]
    --[[ .threads            Prints all threads ]]
    --[[ .frames             Print the stack frames ]]
    --[[ .capabilities       Print the capabilities of the debug adapter ]]
    --[[ .b or .back         Same as |dap.step_back| ]]
    --[[ .rc or .reverse-continue   Same as |dap.reverse_continue| ]]
    r = { "<cmd>lua require'dap'.repl.toggle()<CR>", "Toggle Repl" },
    f = { "<cmd>Telescope dap frames<CR>", "Stack frames" },
    b = { "<cmd>Telescope dap list_breakpoints<CR>", "All breakpoints" },
    s = { "<cmd>lua require'dap.ui.widgets'.centered_float(require'dap.ui.widgets'.scopes)<CR>", "View current scope" },
  },

  f = {
    name = "Find",
    b = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Buffers" },
    c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
    C = { "<cmd>Telescope commands<CR>", "Commands" },
    f = {
      [[<cmd>lua require('telescope.builtin').find_files()<CR>]],
      "Find files",
    },
    F = {
      "<cmd>lua require('telescope.builtin').find_files({no_ignore=true})<CR>",
      "Find files but no ignore",
    },
    h = { "<cmd>Telescope help_tags<CR>", "Help" },
    l = { "<cmd>Telescope resume<CR>", "Last Search" },
    m = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<CR>", "Recent File" },
    R = { "<cmd>Telescope registers<CR>", "Registers" },
    k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
    t = { "<cmd>TodoTelescope<CR>", "Todos" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    f = { "<cmd>0Gclog<CR>", "File history" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
    L = { "<cmd>G blame<CR>", "Git Blame Information" },
    l = { "<cmd>Gclog<CR>", "Git Log Information" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
    P = { "<cmd>G push<CR>", "Push..." },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
    d = {
      "<cmd>lua require('user.utils.diff')()<CR>",
      "Diff With",
    },
  },

  h = {
    name = "Hop",
    w = { "<cmd>HopWordCurrentLine<CR>", "Hop Word In Current Line" },
    p = { "<cmd>HopPattern<CR>", "Hop Word With Pattern" },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    f = { "<cmd>lua vim.lsp.buf.format({async=true})<CR>", "Format" },
    i = { "<cmd>LspInfo<CR>", "Info" },
    I = { "<cmd>LspInstallInfo<CR>", "Installer Info" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<CR>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<CR>",
      "Workspace Diagnostics",
    },
    j = {
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev()<CR>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
    r = { '<cmd>lua require("renamer").rename()<CR>', "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
      "Workspace Symbols",
    },
  },

  m = {
    name = "Markdown",
    p = { "<Plug>MarkdownPreview", "Preview Markdown" },
    s = { "<Plug>MarkdownPreviewStop", "Stop Preview Markdown" },
    t = { "<cmd>InsertToc<CR>", "Insert Tocs" }
  },

  r = {
    name = "Code Runner",
    r = { "<cmd>RunFile<CR>", "Run File" },
    p = { "<cmd>RunProject<CR>", "Run Project" },
    c = { "<cmd>RunClose<CR>", "Close" },
  },

  s = {
    name = "Rust Tools",
    r = { "<cmd>RustRunnables<CR>", "Runnables List" },
    d = { "<cmd>RustDebuggables<CR>", "Debuggables List" },
    e = { "<cmd>RustExpandMacro<CR>", "Expand Macro" },
    j = { "<cmd>RustMoveItemDown<CR>", "Move Item Down" },
    k = { "<cmd>RustMoveItemUp<CR>", "Move Item Up" },
    K = { "<cmd>lua ShowDocumentation()<CR>", "Hover Me" },
    R = { "<cmd>RustHoverRange<CR>", "Hover Range Me" },
    o = { "<cmd>RustOpenCargo<CR>", "Open Cargo" },
    l = { "<cmd>RustJoinLines<CR>", "Join Lines" },
    v = { "<cmd>lua require('crates').show_versions_popup()<CR>", "Show Versions Popup" },
    f = { "<cmd>lua require('crates').show_features_popup()<CR>", "Show Features Popup" },
    D = { "<cmd>lua require('crates').show_dependencies_popup()<CR>", "Show Dependencies Popup" },
    u = { "<cmd>lua require('crates').update_crate()<CR>", "Update Crate" },
    U = { "<cmd>lua require('crates').update_all_crates()<CR>", "Update All Crates" },
    p = { "<cmd>lua require('crates').upgrade_crate()<CR>", "Upgrade Crate" },
    P = { "<cmd>lua require('crates').upgrade_all_crates()<CR>", "Upgrade All Crates" },
    h = { "<cmd>lua require('crates').open_homepage()<CR>", "Open Homepage" },
    n = { '<cmd>lua require("renamer").rename()<CR>', "Rename" }
  },

  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<CR>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<CR>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<CR>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<CR>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
  },
}

which_key.setup(setup)
which_key.register(leader_mappings, leader_opts)
