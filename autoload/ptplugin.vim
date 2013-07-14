function! ptplugin#bootstrap() "{{{

  if !exists('g:project_base_dir')
    let g:project_base_dir = expand(join(['~', 'code'], '/'))
  endif

  let s:subdir_re = '/\([^/]\+\)'
  if !exists('g:project_dir_regex')
    let g:project_dir_regex = '\%('.g:project_base_dir.
          \ s:subdir_re.s:subdir_re.'\|'.
          \ expand('~').'/.\(vim\)/bundle'.s:subdir_re.
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
    let g:project_type = ''
    let g:project_types = []
    if len(_match) >= 3
      let g:project_detected = 1
      let [g:project_type, g:project_name] = _match[1:2]
      let g:project_types = get(g:project_type_map, g:project_type, [g:project_type]) +
            \ get(g:project_name_map, g:project_type.'_'.g:project_name, [])
      for type in g:project_types
        let g:project_{type} = 1
      endfor
    endif
    let g:project_bootstrapped = 1
  endif
endfunction "}}}

function! ptplugin#init() "{{{
  call ptplugin#bootstrap()
  call ptplugin#runtime()
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
      execute 'runtime '.a:dir.'/'._type.'.vim'
    endfor
    execute 'runtime '.join([a:dir, g:project_type, g:project_name.'.vim'], '/')
  endif
endfunction "}}}
