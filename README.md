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
```
The results of these settings:

`cd /projects/fortran/monolith; vim`

Now `ptplugin` will have sourced the files:

* `project/fortran.vim`
* `project/fortran/monolith.vim`
* `project_after/fortran.vim`
* `project_after/fortran/monolith.vim`

in `&runtimepath`.

`cd /projects/ruby/lasers; vim`

This will set `g:project_ruby`, thus enabling fugitive for this session.

For customisation information, read the
[documentation](https://github.com/tek/vim-ptplugin/blob/master/doc/ptplugin.vim).
