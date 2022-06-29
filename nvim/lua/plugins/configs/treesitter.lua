local ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not ok then
    return
end

treesitter.setup {
    autotag = {
        enable = true,
    },
    ensure_installed = "all",

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "phpdoc" },

    highlight = {
        enable = true,
    }
}
