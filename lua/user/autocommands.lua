local is_win32 = vim.fn.has("win32") == 1
if is_win32 then
  vim.cmd [[
    augroup _previewer
    autocmd!
    autocmd BufReadCmd *.png,*.jpg,*.jpeg,*.gif,*.pdf,*ico silent exe '!powershell -c start ' shellescape(expand("<afile>")) | Bdelete
    augroup end
  ]]
else
  vim.cmd [[
    augroup _previewer
    autocmd!
    autocmd BufReadCmd *.png,*.jpg,*.jpeg,*.gif,*.pdf,*ico silent exe '!xdg-open ' shellescape(expand("<afile>")) | Bdelete
    augroup end
  ]]
end

vim.cmd([[
  " if has('wsl')
  " """Copy vim to Windows"""
  " augroup _Yank
  " autocmd!
  " autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ', @")
  " augroup END
  " endif

  augroup _general_settings
  autocmd!
  autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
  autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
  autocmd BufWinEnter * :set formatoptions-=cro
  autocmd FileType qf set nobuflisted
  autocmd FileType toml lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }
  augroup end

  augroup _git
  autocmd!
  autocmd FileType gitcommit setlocal wrap
  autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
  autocmd!
  autocmd FileType markdown setlocal wrap
  augroup end

  augroup _auto_resize
  autocmd!
  autocmd VimResized * tabdo wincmd = 
  augroup end

  augroup _alpha
  autocmd!
  autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
  ]]
)
