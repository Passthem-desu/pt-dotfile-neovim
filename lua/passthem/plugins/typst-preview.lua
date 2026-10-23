return {
	"chomosuke/typst-preview.nvim",
	lazy = false,
	version = "1.*",
	opts = function ()
	    local tinymist = vim.fn.exepath("tinymist")
        return {
            dependencies_bin = {
                tinymist = tinymist ~= "" and tinymist or nil
            },
        }
	end,
}
