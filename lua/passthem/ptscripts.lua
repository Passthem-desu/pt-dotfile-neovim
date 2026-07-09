vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function ()
        vim.keymap.set("n", "<C-CR>", function ()
            local line = vim.api.nvim_get_current_line()

            local indent, symbol, rest = line:match("^(%s*)- %[(.)%] (.*)")
            if indent then
                if symbol == " " then
                    symbol = "-"
                elseif symbol == "-" then
                    symbol = "x"
                elseif symbol == "x" then
                    symbol = " "
                end

                local new_line = indent .. "- [" .. symbol .. "] " .. rest
                vim.api.nvim_set_current_line(new_line)
                return
            end

            indent, rest = line:match("^(%s*)- (.*)")
            if indent then
                local new_line = indent .. "- [ ] " .. rest
                vim.api.nvim_set_current_line(new_line)
            end
        end)
    end
})
