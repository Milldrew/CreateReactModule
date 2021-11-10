"  import component from './component'
" import ModulularizeCode from './ModulularizeCode'
"Collects a string into the register " and uses it as an argument

nnoremap <leader>rcm diw:call ModularizeReact("<C-R>"")<CR>
" executes commands to create a react component module out of a string
" and a range of JSX
" argument is passed in via the above mapping
" and the argument looks like this ComponentName_20_24
" The numbers are the range of JSX that will be modularized
function ModularizeReact(nameAndRange) 
 let dataList=split(a:nameAndRange,"_")
 let componentName=dataList[0]
 let startingLine=dataList[1]
 let lastLine=dataList[2]
 let currentLine=line(".")
 exec currentLine."normal i <".componentName."/>"
 exec currentLine."normal $xx"
 exec startingLine."normal ireturn ("
 exec startingLine."normal Oexport default function ".componentName."() {"
 let lastLine +=1
 exec lastLine."normal A)"
 exec lastLine."normal o}"
 exec "!touch ".componentName.".js"
 let lastLine+=1
 exec startingLine.",".lastLine."w>> ".componentName.".js"
 exec startingLine.",".lastLine."d"
 exec "0normal O import ".componentName." from './".componentName."'"
 exec "normal G".currentLine
endfunction


nnoremap <leader>mc diw:call ModularizeCode("<C-R>"")<CR>

function ModularizeCode(nameAndRange)
 let dataList=split(a:nameAndRange,"_")
 let componentName=dataList[0]
 let startingLine=dataList[1]
 let lastLine=dataList[2]
 let currentLine=line(".")
 exec "!touch ".componentName.".js"
 exec startingLine.",".lastLine."w>> ".componentName.".js"
 exec "0normal O import ".componentName." from './".componentName."'"
 exec "normal G".currentLine
endfunction


"  





