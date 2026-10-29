# dispatch-extras.vim

Extra strategies for [dispatch.vim](https://github.com/tpope/vim-dispatch):

* **kitty** – runs foreground makes in a kitty split and background tasks in a
  new tab, via kitty's remote control.
* **rex** – runs foreground makes in a split below Vim's block in a
  [Rex](https://www.superlogical.com/rex) terminal and captures the output
  with `rex capture`.

Each handler only takes over when Vim runs inside its terminal, so everything
else keeps using dispatch.vim's built-in strategies.

## Installation

Install it next to dispatch.vim with your plugin manager, e.g. with
[vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'tpope/vim-dispatch'
Plug 'trekdemo/vim-dispatch-extras'
```

Or with Vim's packages:

```sh
mkdir -p ~/.vim/pack/dispatch/start
cd ~/.vim/pack/dispatch/start
git clone https://github.com/tpope/vim-dispatch.git
git clone https://github.com/trekdemo/vim-dispatch-extras.git
vim -u NONE -c "helptags vim-dispatch-extras/doc" -c q
```

The handlers are added to `g:dispatch_handlers` right after `tmux`. If you
maintain that list yourself, set `g:dispatch_extras_no_register = 1` and add
`'kitty'` and `'rex'` where you want them.

## Setup

### kitty

Enable remote control over a Unix socket in `kitty.conf`:

```
allow_remote_control yes
listen_on unix:/tmp/kitty
```

Tune the split size with `let g:dispatch_kitty_bias = 20`.

### Rex

Run Vim inside a Rex terminal with the `rex` CLI on your `PATH`. Tune the
split size with `let g:dispatch_rex_ratio = 20` (default 30 percent).

See `:help dispatch-extras` for details.

## How it works

dispatch.vim calls `dispatch#{handler}#handle()` for every entry in
`g:dispatch_handlers`, so this plugin only has to ship
`autoload/dispatch/kitty.vim` and `autoload/dispatch/rex.vim` and register
their names. The handlers build on dispatch.vim's autoload functions
(`dispatch#isolate()`, `dispatch#prepare_start()`, `dispatch#complete()`, …),
which aren't a documented API. Tested against
[tpope/vim-dispatch@a2ff28a](https://github.com/tpope/vim-dispatch).

## License

Distributed under the same terms as Vim itself. See `:help license`.
