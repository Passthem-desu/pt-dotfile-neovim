local M = {}

M.try_require = function(module)
    local status, obj = pcall(require, module)
    if status then
        return obj
    else
        return {}
    end
end

return M
