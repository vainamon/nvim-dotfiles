require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "clangd",
    "cmake",
    "asm_lsp",
    "bashls",
    "rust_analyzer",
  }
})

local lspconfig = require("lspconfig")

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  }
}

lspconfig.clangd.setup {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders=0",
    "--fallback-style=llvm",
  },
  root_dir = lspconfig.util.root_pattern(
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "Makefile",
    "configure.in",
    "config.h.in",
    "configure.ac",
    ".git"
  ),
}

lspconfig.cmake.setup {}

lspconfig.bashls.setup {}

lspconfig.rust_analyzer.setup {}

require("fidget").setup {}

local lsp_configs = require("lspconfig.configs")

if not lsp_configs.plantuml_lsp then
  lsp_configs.plantuml_lsp = {
    default_config = {
      cmd = {
        "/home/danilov/go/bin/plantuml-lsp",
        "--stdlib-path=/home/danilov/doc/plantuml",
        "--exec-path=plantuml",
      },
      filetypes = { "plantuml" },
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
      end,
      settings = {},
    }
  }
end

lspconfig.plantuml_lsp.setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    opts.desc = 'Go to symbol declaration';
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    opts.desc = 'Go to symbol definition';
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    opts.desc = 'Show context help for symbol';
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    opts.desc = 'Go to symbol implementation';
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    opts.desc = 'Add workspace folder';
    vim.keymap.set('n', '<Space>wa', vim.lsp.buf.add_workspace_folder, opts)
    opts.desc = 'Remove workspace folder';
    vim.keymap.set('n', '<Space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    opts.desc = 'List workspace folder';
    vim.keymap.set('n', '<Space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    opts.desc = 'Go to type definition';
    vim.keymap.set('n', '<Space>D', vim.lsp.buf.type_definition, opts)
    opts.desc = 'Rename all references to the symbol';
    vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, opts)
    opts.desc = 'Select a code action';
    vim.keymap.set({ 'n', 'v' }, '<Space>ca', vim.lsp.buf.code_action, opts)
    opts.desc = 'Format buffer';
    vim.keymap.set('n', '<Space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

-- override border globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
