# Preview.nvim

<!--toc:start-->

- [Preview.nvim](#previewnvim)
  - [Installation](#installation)
  - [Usage](#usage)

<!--toc:end-->

Neovim wrapper around [MD-TUI](https://github.com/henriklovhaug/md-tui)

## Installation

Lazy

```lua
{
	"henriklovhaug/Preview.nvim",
	cmd = { "Preview" },
	config = function()
		require("preview").setup()
	end,
},
```

## Usage

With a markdown file open run `Preview` with optionally the filename afterwards.
