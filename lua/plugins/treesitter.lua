-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- 🔴 REQUIRED now
  build = ":TSUpdate",

  config = function()
    -- 1️⃣ Setup treesitter core
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- 2️⃣ Install parsers (old ensure_installed replacement)
    local parsers = {
      "bash",
      "c",
      "cpp",
      "diff",
      "fish",
      "html",
      "latex",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "systemverilog",
      "tcl",
      "vim",
      "vimdoc",
    }

    require("nvim-treesitter").install(parsers)

    -- 3️⃣ Enable highlighting automatically
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup('TSStart', { clear = true }),
      pattern = vim.treesitter.language.get_filetypes(parsers)[1],
      callback = function()
        --[[ Expression folding
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        ]]
        -- indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.treesitter.start()
      end,
    })

    -- 4️⃣ Use treesitter for folding (optional but recommended)
    -- vim.opt.foldmethod = "expr"
    -- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
}
