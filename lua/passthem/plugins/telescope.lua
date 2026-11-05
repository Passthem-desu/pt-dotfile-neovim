return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "andrew-george/telescope-themes",
    },
    config = function ()
        require('telescope').setup {
            pickers = {
                buffers = {
                    sort_mru = true,
                    ignore_current_buffer = true,
                },
            },
        }

        local actions = require('telescope.actions')
        local b = require('telescope.builtin')

        local function deco_bcommits(picker)
            return function(opts)
                opts = opts or {}
                opts.attach_mappings = function(_, map)
                    map({ "i", "n" }, "<CR>", actions.select_vertical)
                    return true
                end
                picker(opts)
            end
        end

        local man_pages = function ()
            b.man_pages({
                sections = { "ALL" }
            })
        end
        local git_bcommits = deco_bcommits(b.git_bcommits)
        local git_bcommits_range = deco_bcommits(b.git_bcommits_range)

        vim.keymap.set('n', '<leader>pb', b.buffers,          { desc = '查找 Buffers'       })
        vim.keymap.set('n', '<leader>pg', b.live_grep,        { desc = '在所有文件搜索'     })
        vim.keymap.set('n', '<leader>ph', b.help_tags,        { desc = 'NeoVim 帮助'        })
        vim.keymap.set('n', '<leader>pm', man_pages,          { desc = '搜索 Manpage'       })
        vim.keymap.set('n', '<leader>gs', b.git_status,       { desc = 'git status'         })
        vim.keymap.set('n', '<leader>gb', b.git_branches,     { desc = 'git branch'         })
        vim.keymap.set('n', '<leader>gC', git_bcommits,       { desc = '当前文件历史'       })
        vim.keymap.set('x', '<leader>gC', git_bcommits_range, { desc = '选中行的历史'       })
        vim.keymap.set('n', '<leader>pf', b.find_files,       { desc = '查找文件'           })
        vim.keymap.set('n', '<leader>pk', b.keymaps,          { desc = '查找键位'           })
        vim.keymap.set('n', '<leader>pd', b.diagnostics,      { desc = '查找工作区代码诊断' })
        vim.keymap.set('n', '<leader>pt', b.filetypes,        { desc = '设置文件类型'       })
        vim.keymap.set('n', '<leader>pq', b.quickfix,         { desc = 'Quickfix'           })
        vim.keymap.set('n', '<leader>pl', b.loclist,          { desc = 'Location List'      })
    end
}
