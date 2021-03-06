function! ptplugin#bootstrap() "{{{

  if !exists('g:project_base_dir')
    let g:project_base_dir = expand('~')
  endif

  let subdir_re = '/\([^/]\+\)'
  if !exists('g:project_dir_regex')
    let g:project_dir_regex = '\%('.g:project_base_dir.
          \ subdir_re.subdir_re.'\|'.
          \ expand('~').'/.\(vim\)/bundle'.subdir_re.
          \ '\)'
  endif

  if !exists('g:project_type_map')
    let g:project_type_map = {
          \ 'rails': ['rails', 'ruby'],
          \ }
  endif

  if !exists('g:project_name_map')
    let g:project_name_map = {
          \ 'python_myprojectname': ['nose'],
          \ }
  endif

  if !exists('g:project_bootstrapped')
    let _match = matchlist(getcwd(), g:project_dir_regex)
    let matches = filter(_match[1:], 'len(v:val)')
    let g:project_type = ''
    let g:project_types = []
    let g:project_detected = 0
    if len(matches) == 2
      let g:project_detected = 1
      let [g:project_type, g:project_name] = matches[:1]
      let g:project_types = get(g:project_type_map, g:project_type, [g:project_type]) +
            \ get(g:project_name_map, g:project_type.'_'.g:project_name, [])
      for _type in g:project_types
        exe 'let g:project_'.substitute(_type, '\.', '_', '').' = 1'
      endfor
    endif
    let g:project_bootstrapped = 1
  endif
endfunction "}}}

function! ptplugin#init() "{{{
  call ptplugin#bootstrap()
  " call ptplugin#runtime()
endfunction "}}}

function! ptplugin#runtime() "{{{
  call s:runtime('project')
endfunction "}}}

function! ptplugin#runtime_after() "{{{
  call s:runtime('project_after')
endfunction "}}}

function! s:runtime(dir) "{{{
  if len(g:project_type)
    for _type in g:project_types
      execute 'runtime! '.a:dir.'/'._type.'.vim'
    endfor
    execute 'runtime! '.join([a:dir, g:project_type, g:project_name.'.vim'], '/')
  endif
endfunction "}}}
