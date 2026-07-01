return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        vim.opt.termguicolors = true
        require("bufferline").setup {
            options = {
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { 'close' },
                },
                separator_style = "thick",
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local icon = level:match("error") and "E" or "W"
                    if level:match("error") then
                        icon = ""
                    end
                    return " " .. icon .. count
                end,
                buffer_close_icon = ' x',
                close_icon = ' x',
                show_buffer_icons = false,
            }
        }
    end,
}
