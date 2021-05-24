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
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/home/smoodle/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/smoodle/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/smoodle/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/smoodle/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/smoodle/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  edge = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/edge"
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
  ["nvim-compe"] = {
    config = { "\27LJ\1\2¯\2\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\vsource\1\0\6\rnvim_lua\2\rnvim_lsp\2\vbuffer\2\nvsnip\2\tcalc\2\tpath\2\1\0\f\17autocomplete\2\19source_timeout\3È\1\fenabled\2\ndebug\1\14preselect\venable\19max_abbr_width\3d\21incomplete_delay\3\3\19max_menu_width\3d\19max_kind_width\3d\15min_length\3\1\18throttle_time\3P\18documentation\2\nsetup\ncompe\frequire\0" },
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lsputils"] = {
    config = { "\27LJ\1\2¾\5\0\0\3\0\23\0A4\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\5\0>\1\2\0027\1\6\1:\1\3\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\b\0>\1\2\0027\1\t\1:\1\a\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\b\0>\1\2\0027\1\v\1:\1\n\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\b\0>\1\2\0027\1\r\1:\1\f\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\b\0>\1\2\0027\1\15\1:\1\14\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\b\0>\1\2\0027\1\17\1:\1\16\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\19\0>\1\2\0027\1\20\1:\1\18\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\19\0>\1\2\0027\1\22\1:\1\21\0G\0\1\0\22workspace_handler\21workspace/symbol\21document_handler\20lsputil.symbols textDocument/documentSymbol\27implementation_handler textDocument/implementation\27typeDefinition_handler textDocument/typeDefinition\24declaration_handler\29textDocument/declaration\23definition_handler\28textDocument/definition\23references_handler\22lsputil.locations\28textDocument/references\24code_action_handler\23lsputil.codeAction\frequire\28textDocument/codeAction\rhandlers\blsp\bvim\0" },
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/nvim-lsputils"
  },
  ["nvim-markdown-preview"] = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/nvim-markdown-preview"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\1\2Ÿ\1\0\0\3\0\b\0\v4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\0013\2\6\0:\2\a\1>\0\2\1G\0\1\0\vindent\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0" },
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
  popfix = {
    loaded = true,
    path = "/home/smoodle/.local/share/nvim/site/pack/packer/start/popfix"
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

time("Defining packer_plugins", false)
-- Config for: nvim-treesitter
time("Config for nvim-treesitter", true)
try_loadstring("\27LJ\1\2Ÿ\1\0\0\3\0\b\0\v4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\0013\2\6\0:\2\a\1>\0\2\1G\0\1\0\vindent\1\0\1\venable\2\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time("Config for nvim-treesitter", false)
-- Config for: nvim-compe
time("Config for nvim-compe", true)
try_loadstring("\27LJ\1\2¯\2\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\1G\0\1\0\vsource\1\0\6\rnvim_lua\2\rnvim_lsp\2\vbuffer\2\nvsnip\2\tcalc\2\tpath\2\1\0\f\17autocomplete\2\19source_timeout\3È\1\fenabled\2\ndebug\1\14preselect\venable\19max_abbr_width\3d\21incomplete_delay\3\3\19max_menu_width\3d\19max_kind_width\3d\15min_length\3\1\18throttle_time\3P\18documentation\2\nsetup\ncompe\frequire\0", "config", "nvim-compe")
time("Config for nvim-compe", false)
-- Config for: nvim-lsputils
time("Config for nvim-lsputils", true)
try_loadstring("\27LJ\1\2¾\5\0\0\3\0\23\0A4\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\5\0>\1\2\0027\1\6\1:\1\3\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\b\0>\1\2\0027\1\t\1:\1\a\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\b\0>\1\2\0027\1\v\1:\1\n\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\b\0>\1\2\0027\1\r\1:\1\f\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\b\0>\1\2\0027\1\15\1:\1\14\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\b\0>\1\2\0027\1\17\1:\1\16\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\19\0>\1\2\0027\1\20\1:\1\18\0004\0\0\0007\0\1\0007\0\2\0004\1\4\0%\2\19\0>\1\2\0027\1\22\1:\1\21\0G\0\1\0\22workspace_handler\21workspace/symbol\21document_handler\20lsputil.symbols textDocument/documentSymbol\27implementation_handler textDocument/implementation\27typeDefinition_handler textDocument/typeDefinition\24declaration_handler\29textDocument/declaration\23definition_handler\28textDocument/definition\23references_handler\22lsputil.locations\28textDocument/references\24code_action_handler\23lsputil.codeAction\frequire\28textDocument/codeAction\rhandlers\blsp\bvim\0", "config", "nvim-lsputils")
time("Config for nvim-lsputils", false)
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
