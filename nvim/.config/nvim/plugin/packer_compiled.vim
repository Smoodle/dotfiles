" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/smoodle/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/smoodle/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/smoodle/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/smoodle/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/smoodle/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  ["deoplete-lsp"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/deoplete-lsp"
  },
  ["deoplete.nvim"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/deoplete.nvim"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["goyo.vim"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/goyo.vim"
  },
  nerdtree = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/nerdtree"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\1\2˜\1\0\0\3\0\b\0\v4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\0013\2\6\0:\2\a\1>\0\2\1G\0\1\0\vindent\1\0\1\venable\1\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  sonokai = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/sonokai"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-pandoc"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/vim-pandoc"
  },
  ["vim-pandoc-syntax"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/vim-pandoc-syntax"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["zephyr-nvim"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/zephyr-nvim"
  }
}

-- Config for: nvim-treesitter
try_loadstring("\27LJ\1\2˜\1\0\0\3\0\b\0\v4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\0013\2\6\0:\2\a\1>\0\2\1G\0\1\0\vindent\1\0\1\venable\1\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
