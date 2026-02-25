if vim.g.neovide then
    vim.g.neovide_opacity = 1
    vim.g.neovide_normal_opacity = 0.9

    -- 唉这个只有 MacOS 才有！！
    vim.g.neovide_window_blurred = true

    vim.o.guifont = "Maple Mono NF CN:h14"
    vim.g.neovide_theme = 'dark'

    vim.g.neovide_refresh_rate = 180

    vim.g.neovide_remember_window_size = true

    vim.g.neovide_cursor_vfx_mode = "pixiedust"
end
