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
                separator_style = "slant",
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local icon = level:match("error") and " " or " "
                    if level:match("error") then
                        icon = ""
                    end
                    return " " .. icon .. count
                end
            }
        }
    end,
}
