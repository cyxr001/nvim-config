local telescope = require('telescope')


local open_in_nvim_tree = function(prompt_bufnr)
    local action_state = require "telescope.actions.state"
    local Path = require "plenary.path"
    local actions = require "telescope.actions"

    local entry = action_state.get_selected_entry()[1]
    local entry_path = Path:new(entry):parent():absolute()
    actions._close(prompt_bufnr, true)
    entry_path = Path:new(entry):parent():absolute() 
    entry_path = entry_path:gsub("\\", "\\\\")

    vim.cmd("NvimTreeClose")
    vim.cmd("NvimTreeOpen " .. entry_path)

    file_name = nil
    for s in string.gmatch(entry, "[^/]+") do
        file_name = s
    end

    vim.cmd("/" .. file_name)
end


telescope.setup{
    defaults = {
        path_display = { "smart" },
        mappings = {
            i = {
                ["<c-s>"] = open_in_nvim_tree,
            },
            n = {
                ["<c-s>"] = open_in_nvim_tree,
            },
        },
    },
}

--require('telescope').load_extension('fzf')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fo', builtin.lsp_document_symbols, {})
-- native fzf telescope
require('telescope').load_extension('fzf')

