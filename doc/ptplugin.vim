*ptplugin.txt*       runtime loader for directory-based project types
*ptplugin*
===============================================================================
CONTENTS                                                    *ptplugin-contents*

    1. Intro........................................|ptplugin-intro|
    2. Options......................................|ptplugin-options|
    3. Advanced usage...............................|ptplugin-advanced|

===============================================================================
INTRO                                                          *ptplugin-intro*

ptplugin extracts a project type, like "rails", and the project name from cwd
and sources files based on that information.
To use it, put files into >
  &rtp/project{,_after}/<project_type>.vim
or >
  &rtp/project{,_after}/<project_type>/<project_name>.vim
By default, the directory structure is assumed to be >
  /base/path/project_type/project_name".
You can substitute or extend the applied project type configs by changing
|g:project_type_map|.

Example:~

Given a cwd "/projects/rails/secret_service" and a type map >
  let g:project_type_map = { 'rails': ['rails', 'coffee', 'ruby'] }

Then ptplugin would source the files in your runtimepath >
  project/rails.vim
  project/coffee.vim
  project/ruby.vim
  project/rails/secret_service.vim
  project/after/rails.vim
  project/after/coffee.vim
  project/after/ruby.vim
  project/after/rails/secret_service.vim

in that order, and set the variables >
  g:project_detected = 1
  g:project_type = 'rails'
  g:project_types = ['rails', 'coffee', 'ruby']
  g:project_name = 'secret_service'
  g:project_rails = 1
  g:project_coffee = 1
  g:project_ruby = 1

The files in "project_after" will be sourced in an "after" runtime path
plugin, of course.
"g:project_detected" will remain unset if the regex didn't match!

===============================================================================
OPTIONS                                                      *ptplugin-options*

Overview:~

  |project_base_dir|............Where your projects live.
  |project_dir_regex|...........How to determine project type and name.
  |project_type_map|............Include other types.
  |project_name_map|............Include types in a specific project.

-------------------------------------------------------------------------------
Detailed descriptions and default values:~

                                                        *'g:project_base_dir'*
>
  let g:project_base_dir = '~/code'

Used only for the |g:project_dir_regex| default.

                                                       *'g:project_dir_regex'*
>
  let g:project_dir_regex =
  '\%(~/code/\([^/]\+\)/\([^/]\+\)\|~/.\(vim\)/bundle/\([^/]\+\)\)'

This regex is matched against cwd. The first submatch is used as main project
type, the second one as its name.
These two are used to assemble the project specific config with the format: >
  project{,_after}/type/name.vim
The main type is also used to index |g:project_type_map|, as is the name for
|g:project_name_map|.

                                                        *'g:project_type_map'*
>
  let g:project_type_map = { 'rails': ['rails', 'ruby'] }

These are additional or substitute types to be sourced for a given main type,
with the format: >
  project{,_after}/type.vim
<
                                                        *'g:project_name_map'*
>
  let g:project_name_map = { 'secret_service': ['cucumber'] }

These work just like |g:project_name_map|, but is project name specific.

===============================================================================
ADVANCED USAGE                                              *ptplugin-advanced*

If you are using a lot of plugins, it could be desirable to run them
selectively based on what type of project you are working on. To achieve
this, |ptplugin| must set its variables early in the startup process.
This is possible by calling "ptplugin#bootstrap()" before including other
plugins. After that, you can test the existence of the "g:project_{type}"
variables.

An example using vundle:~
>
  Bundle('tek/vim-ptplugin')
  call ptplugin#bootstrap()
  if exists('g:project_ruby') || !exists('g:project_detected')
    Bundle 'nelstrom/vim-textobj-rubyblock'
  endif

Using only |exists()| for testing ensures that your vimrc still works without
|ptplugin|.

===============================================================================
CREDITS                                                      *ptplugin-credits*

Developed by Torsten Schmits <github.com/tek>. Distributed under Vim's
|license|.

Git repository:       https://github.com/tek/vim-ptplugin

===============================================================================
CHANGELOG                                                  *ptplugin-changelog*

===============================================================================
vim:ft=help:et:ts=2:sw=2:sts=2:norl
