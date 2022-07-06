local ok, nvimtree = pcall(require, "nvim-tree")

if not ok then
    return
end

local signs = require("utils").signs

nvimtree.setup {
    auto_reload_on_write = true,
    disable_netrw = true,
    sort_by = "name",
    renderer = {
        add_trailing = true,
        special_files = {},
        indent_markers = {
            enable = true,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
        icons = {
            webdev_colors = true,
            show = {
                file = true,
                folder = true,
                folder_arrow = false,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                git  = {
                    unstaged = "",
                    staged = "ﰶ",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "●",
                    deleted = "﯀",
                    ignored = "",
                },
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
            }
        },
    },
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    open_on_tab = false,
    hijack_cursor = true,
    update_cwd = true,
    diagnostics = {
        enable = true,
        icons = {
            hint = signs.Hint,
            info = signs.Info,
            warning = signs.Warning,
            error = signs.Error,
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    system_open = {
        cmd = nil,
        args = {},
    },
    filters = {
        dotfiles = false,
        custom = {
            "^.git$",
        },
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        width = 35,
        height = 30,
        hide_root_folder = true,
        side = "left",
        mappings = {
            custom_only = false,
            list = {
              { key = "<C-t>", action = "" },
            },
        },
        number = false,
        relativenumber = false,
        signcolumn = "yes",
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
    actions = {
        change_dir = {
            global = false,
        },
        open_file = {
            quit_on_open = false,
        },
    },
}
