# plenary-script.nvim

This script uses [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)'s filetype detection to set `'filetype'` to complement the new `filetype.lua` script in Neovim 0.7.

The idea for this plugin was suggested by [comments made on Issue #16940](https://github.com/neovim/neovim/issues/16940#issuecomment-1005902812), which mentions that there is currently no file detection based on file content in the new `filetype.lua` method.

## Background

[`filetype.lua`](https://github.com/neovim/neovim/pull/16600) was recently merged into Neovim. If you set `vim.g.do_filetype_lua` to 1 and `vim.g.did_load_filetypes` to 0, you can use the new `filetype.lua` system exclusively (it's much faster and `vim.filetype.add()` rocks). As [SanchayanMaity](https://github.com/SanchayanMaity) pointed out in [Issue #16940](https://github.com/neovim/neovim/issues/16940), the new API does not check things like shebangs or modelines for filetype.

It was suggested by [clason](https://github.com/clason) that [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) might be a stop-gap solution.

Hence this plugin, which uses [`plenary.filetype`](https://github.com/nvim-lua/plenary.nvim#plenaryfiletype) to guess `filetype` when `filetype.lua` fails (namely for files where `filetype` should be suggested by a shebang and the like).

## Installation

```lua
use({
	"oncomouse/plenary-script.nvim",
	requires = { "nvim-lua/plenary.nvim" },
})
```

## Extension

There are instructions on [`plenary.filetype`](https://github.com/nvim-lua/plenary.nvim#plenaryfiletype)'s documentation for extending detection, but they are also reproduced below:

> Add filetypes by creating a new file named ~/.config/nvim/data/plenary/filetypes/foo.lua and register that file with :lua require'plenary.filetype'.add_file('foo'). Content of the file should look like that:

```lua
return {
  extension = {
    -- extension = filetype
    -- example:
    ['jl'] = 'julia',
  },
  file_name = {
    -- special filenames, likes .bashrc
    -- we provide a decent amount
    -- name = filetype
    -- example:
    ['.bashrc'] = 'bash',
  },
  shebang = {
    -- Shebangs are supported as well. Currently we provide
    -- sh, bash, zsh, python, perl with different prefixes like
    -- /usr/bin, /bin/, /usr/bin/env, /bin/env
    -- shebang = filetype
    -- example:
    ['/usr/bin/node'] = 'javascript',
  }
}
```
