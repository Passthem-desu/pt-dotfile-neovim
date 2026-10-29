return {
	"chomosuke/typst-preview.nvim",
	ft = { "typst" },
	-- 保留命令全局可用，避免在非 typst buffer 里 :TypstPreview 找不到
	cmd = { "TypstPreview", "TypstPreviewToggle", "TypstPreviewUpdate", "TypstPreviewFollowCursor", "TypstPreviewNoCursor" },
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
