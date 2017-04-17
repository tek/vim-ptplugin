# Deprecation Notice
This plugin is nonfunctional and will not be developed further.
If you're using *neovim*, I created a much more sophisticated successor, [proteome].

## Quick example

Your .vimrc, as a vundle user:
```VimL
let g:project_base_dir = '/projects'
silent! call vundle#rc()
Bundle 'tek/vim-ptplugin'
call ptplugin#bootstrap()
if exists('g:project_ruby')
  Bundle 'tpope/vim-fugitive'
endif
if exists('g:project_detected')
  Bundle 'majutsushi/tagbar'
endif
```
The results of these settings:

`cd /projects/fortran/monolith; vim`

Now `ptplugin` will have sourced the files:

* `project/fortran.vim`
* `project/fortran/monolith.vim`
* `project_after/fortran.vim`
* `project_after/fortran/monolith.vim`

in `&runtimepath` as soon as its own `{,after/}plugin` files are sourced.

`cd /projects/ruby/lasers; vim`

This will set `g:project_ruby`, thus enabling fugitive for this session.

The variable `g:project_detected` is set if some kind of project
has been matched. In this case, only load tagbar when in a project.

For customisation information, read the [documentation][1].

## License

Copyright (c) Torsten Schmits. Distributed under the terms of the [MIT
License][2].

[1]: https://github.com/tek/vim-ptplugin/blob/master/doc/ptplugin.vim 'doc'
[2]: http://opensource.org/licenses/MIT 'mit license'
[proteome]: https://github.com/tek/proteome 'proteome'
