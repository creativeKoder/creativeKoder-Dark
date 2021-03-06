" Vim color file
"
"========================================================================
"                        _   _           _   __          _              "
"                       | | (_)         | | / /         | |             "
"     ___ _ __ ___  __ _| |_ ___   _____| |/ /  ___   __| | ___ _ __    "
"    / __| '__/ _ \/ _` | __| \ \ / / _ \    \ / _ \ / _` |/ _ \ '__|   "
"   | (__| | |  __/ (_| | |_| |\ V /  __/ |\  \ (_) | (_| |  __/ |      "
"   \___|_|  \___|\__,_|\__|_| \_/ \___\_| \_/\___/ \__,_|\___|_|       "
"                                                                       "
" =======================================================================
"
"         "A colorful, dark color scheme for Vim."
"
" File:         creativeKoder.vim
" Maintainer:   creativeKoder <http://www.creativekode.com/>
" Version:      1.0~git
" Last Change:  July 3rd, 2011
" Contributors: Anthony Josiah Braun <http://iheariam.com>,
"
"
" Copyright (c) 2012-2013 creativeKoder
"
" -----------------------------------------------------------------------------
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
" -----------------------------------------------------------------------------
"
 
set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "creativeKoder"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
  let s:low_color = 0
else
  let s:low_color = 1
endif

" returns an approximate grey index
" for the given grey level

fun! s:grey_number(x)
  if &t_Co == 88
    if a:x < 23
      return 0
    elseif a:x < 69
      return 1
    elseif a:x < 103
      return 2
    elseif a:x < 127
      return 3
    elseif a:x < 150
      return 4
    elseif a:x < 173
      return 5
    elseif a:x < 196
      return 6
    elseif a:x < 219
      return 7
    elseif a:x < 243
      return 8
    else
      return 9
    endif
  else
    if a:x < 14
      return 0
    else
      let l:n = (a:x - 8) / 10
      let l:m = (a:x - 8) % 10
      if l:m < 5
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" returns the actual grey level 
" represented by the grey index

fun! s:grey_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 46
    elseif a:n == 2
      return 92
    elseif a:n == 3
      return 115
    elseif a:n == 4
      return 139
    elseif a:n == 5
      return 162
    elseif a:n == 6
      return 185
    elseif a:n == 7
      return 208
    elseif a:n == 8
      return 231
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 8 + (a:n * 10)
    endif
  endif
endfun

" returns the palette index 
" for the given grey index

fun! s:grey_color(n)
  if &t_Co == 88
    if a:n == 0
      return 16
    elseif a:n == 9
      return 79
    else
      return 79 + a:n
    endif
  else
    if a:n == 0
      return 16
    elseif a:n == 25
      return 231
    else
      return 231 + a:n
    endif
  endif
endfun

" returns an approximate color 
" index for the given color level

fun! s:rgb_number(x)
  if &t_Co == 88
    if a:x < 69
      return 0
    elseif a:x < 172
      return 1
    elseif a:x < 230
      return 2
    else
      return 3
    endif
  else
    if a:x < 75
      return 0
    else
      let l:n = (a:x - 55) / 40
      let l:m = (a:x - 55) % 40
      if l:m < 20
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" returns the actual color level
" for the given color index

fun! s:rgb_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 139
    elseif a:n == 2
      return 205
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 55 + (a:n * 40)
    endif
  endif
endfun

" returns the palette index for 
" the given R/G/B color indices

fun! s:rgb_color(x, y, z)
  if &t_Co == 88
    return 16 + (a:x * 16) + (a:y * 4) + a:z
  else
    return 16 + (a:x * 36) + (a:y * 6) + a:z
  endif
endfun

" returns the palette index to 
" approximate the given R/G/B color levels

fun! s:color(r, g, b)
  " get the closest grey
  let l:gx = s:grey_number(a:r)
  let l:gy = s:grey_number(a:g)
  let l:gz = s:grey_number(a:b)

  " get the closest color
  let l:x = s:rgb_number(a:r)
  let l:y = s:rgb_number(a:g)
  let l:z = s:rgb_number(a:b)

  if l:gx == l:gy && l:gy == l:gz
    " there are two possibilities
    let l:dgr = s:grey_level(l:gx) - a:r
    let l:dgg = s:grey_level(l:gy) - a:g
    let l:dgb = s:grey_level(l:gz) - a:b
    let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
    let l:dr = s:rgb_level(l:gx) - a:r
    let l:dg = s:rgb_level(l:gy) - a:g
    let l:db = s:rgb_level(l:gz) - a:b
    let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
    if l:dgrey < l:drgb
      " use the grey
      return s:grey_color(l:gx)
    else
      " use the color
      return s:rgb_color(l:x, l:y, l:z)
    endif
  else
    " only one possibility
    return s:rgb_color(l:x, l:y, l:z)
  endif
endfun

" returns the palette index to
" approximate the 'rrggbb' hex string

fun! s:rgb(rgb)
  let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
  let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
  let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0
  return s:color(l:r, l:g, l:b)
endfun

" sets the highlighting for the given group

fun! s:X(group, fg, bg, attr, lcfg, lcbg)
  if s:low_color
    let l:fge = empty(a:lcfg)
    let l:bge = empty(a:lcbg)

    if !l:fge && !l:bge
      exec "hi ".a:group." ctermfg=".a:lcfg." ctermbg=".a:lcbg
    elseif !l:fge && l:bge
      exec "hi ".a:group." ctermfg=".a:lcfg." ctermbg=NONE"
    elseif l:fge && !l:bge
      exec "hi ".a:group." ctermfg=NONE ctermbg=".a:lcbg
    endif
  else
    let l:fge = empty(a:fg)
    let l:bge = empty(a:bg)

    if !l:fge && !l:bge
      exec "hi ".a:group." guifg=#".a:fg." guibg=#".a:bg." ctermfg=".s:rgb(a:fg)." ctermbg=".s:rgb(a:bg)
    elseif !l:fge && l:bge
      exec "hi ".a:group." guifg=#".a:fg." guibg=NONE ctermfg=".s:rgb(a:fg)." ctermbg=NONE"
    elseif l:fge && !l:bge
      exec "hi ".a:group." guifg=NONE guibg=#".a:bg." ctermfg=NONE ctermbg=".s:rgb(a:bg)
    endif
  endif

  if a:attr == ""
    exec "hi ".a:group." gui=none cterm=none"
  else
    let noitalic = join(filter(split(a:attr, ","), "v:val !=? 'italic'"), ",")
    if empty(noitalic)
      let noitalic = "none"
    endif
    exec "hi ".a:group." gui=".a:attr." cterm=".noitalic
  endif
endfun
" }}}

call s:X("Normal","e8e8d3","151515","","White","")
set background=dark

if version >= 700
  call s:X("CursorLine","","1c1c1c","","","Black")
  call s:X("CursorColumn","","1c1c1c","","","Black")
  call s:X("MatchParen","ffffff","80a090","bold","","DarkCyan")

  call s:X("TabLine","000000","b0b8c0","italic","","Black")
  call s:X("TabLineFill","9098a0","","","","Black")
  call s:X("TabLineSel","000000","f0f0f0","italic,bold","Black","White")

  " Auto-completion
  call s:X("Pmenu","ffffff","606060","","White","Black")
  call s:X("PmenuSel","101010","eeeeee","","Black","White")
endif

call s:X("Visual","","404040","","","Black")
call s:X("Cursor","","b0d0f0","","","")

call s:X("LineNr","605958","151515","none","Black","")
call s:X("Comment","888888","","italic","Grey","")
call s:X("Todo","808080","","bold","White","Black")

call s:X("StatusLine","000000","dddddd","italic","Black","White")
call s:X("StatusLineNC","ffffff","403c41","italic","White","Black")
call s:X("VertSplit","777777","403c41","italic","Black","Black")
call s:X("WildMenu","f0a0c0","302028","","Magenta","")

call s:X("Folded","a0a8b0","384048","italic","Black","")
call s:X("FoldColumn","a0a8b0","384048","","","Black")

hi! link SignColumn FoldColumn

call s:X("Title","70b950","","bold","Green","")
call s:X("Constant","cf6a4c","","","Red","")
call s:X("Special","799d6a","","","Green","")
call s:X("Delimiter","668799","","","Grey","")

call s:X("String","9cbb89","","","Green","")
call s:X("StringDelimiter","556633","","","DarkGreen","")

call s:X("Identifier","c6b6ee","","","LightCyan","")
call s:X("Structure","8fbfdc","","","LightCyan","")
call s:X("Function","fad07a","","","Yellow","")
call s:X("Statement","8197bf","","","DarkBlue","")
call s:X("PreProc","8fbfdc","","","LightBlue","")

hi! link Operator Normal

call s:X("Type","ffb964","","","Yellow","")
call s:X("NonText","606060","151515","","Black","")

call s:X("SpecialKey","444444","1c1c1c","","Black","")

call s:X("Search","f0a0c0","302028","underline","Magenta","")

call s:X("Directory","dad085","","","Yellow","")
call s:X("ErrorMsg","","902020","","","DarkRed")

hi! link Error ErrorMsg
hi! link MoreMsg Special

call s:X("Question","65C254","","","Green","")

" Spell Checking

call s:X("SpellBad","","902020","underline","","DarkRed")
call s:X("SpellCap","","0000df","underline","","Blue")
call s:X("SpellRare","","540063","underline","","DarkMagenta")
call s:X("SpellLocal","","2D7067","underline","","Green")

" Diff

hi! link diffRemoved Constant
hi! link diffAdded String

" VimDiff

call s:X("DiffAdd","D2EBBE","437019","","White","DarkGreen")
call s:X("DiffDelete","40000A","700009","","DarkRed","DarkRed")
call s:X("DiffChange","","2B5B77","","White","DarkBlue")
call s:X("DiffText","8fbfdc","000000","reverse","Yellow","")

" PHP

hi! link phpFunctions Function
call s:X("StorageClass","c59f6f","","","Red","")
hi! link phpSuperglobal Identifier
hi! link phpQuoteSingle StringDelimiter
hi! link phpQuoteDouble StringDelimiter
hi! link phpBoolean Constant
hi! link phpNull Constant
hi! link phpArrayPair Operator

" Ruby

hi! link rubySharpBang Comment
call s:X("rubyClass","447799","","","DarkBlue","")
call s:X("rubyIdentifier","c6b6fe","","","Cyan","")
hi! link rubyConstant Type
hi! link rubyFunction Function

call s:X("rubyInstanceVariable","c6b6fe","","","Cyan","")
call s:X("rubySymbol","AB0001","","","LightOrange","")
hi! link rubyGlobalVariable rubyInstanceVariable
hi! link rubyModule rubyClass
call s:X("rubyControl","7597c6","","","Blue","")

hi! link rubyString String
hi! link rubyStringDelimiter StringDelimiter
hi! link rubyInterpolationDelimiter Identifier

call s:X("rubyRegexpDelimiter","540063","","","Magenta","")
call s:X("rubyRegexp","dd0093","","","DarkMagenta","")
call s:X("rubyRegexpSpecial","a40073","","","Magenta","")

call s:X("rubyPredefinedIdentifier","de5577","","","Red","")

" JavaScript
hi! link javaScriptValue Constant
hi! link javaScriptRegexpString rubyRegexp

call s:X("javaScriptParen", "f5e499", "", "", "yellow", "")
call s:X("javaScriptFunction", "f5e8b5", "", "", "yellowish", "")
call s:X("javaScriptFuncBlock", "f5e499", "", "", "yellow", "")
call s:X("javaScriptType", "b8f5f5", "", "", "lightBlue", "")
call s:X("javaScriptGlobalObjects", "f5c5e7", "", "", "Pink", "")
call s:X("javaScriptStrings", "c6f1b3", "", "", "lightGreen", "")
call s:X("javaScriptBranch", "c6a8c9", "", "", "pink", "")
call s:X("javaScriptConditional", "be94eb", "", "", "purple", "")
call s:X("javaScriptLabel", "eb9c40", "", "", "orange", "")
call s:X("javaScriptNumber", "eb9c40", "", "", "orange", "")




" CoffeeScript

hi! link coffeeRegExp javaScriptRegexpString


" Haml
call s:X("hamlClass", "77b0c7", "", "","lightPink", "")
call s:X("hamlTag", "c1c1c1", "", "", "lightBlue", "")
call s:X("htmlTagName", "fdd189", "","","lightYellow", "")
call s:X("hamlAttributesHash", "878787", "","","Gray", "")
call s:X("hamlAttributesDelimiter", "c1c1c1", "","","lightGray", "")
call s:X("hamlIDChar", "878787", "","","Gray", "")
call s:X("hamlAttributes", "878787", "","","Gray", "")
call s:X("htmlArg", "D90000", "","","Gray", "")
call s:X("hamlID", "99e1ff", "","","lightBlue", "")

" CSS & SASS

call s:X("cssRenderProp", "b8b9c7", "","","lightBlue", "")
call s:X("cssBoxProp", "b8b9c7", "","","lightBlue", "")
call s:X("cssFontProp", "b8b9c7", "","","lightBlue", "")
call s:X("cssColorProp", "b8b9c7", "","","lightBlue", "")
call s:X("cssUIProp", "b8b9c7", "","","lightBlue", "")
call s:X("cssTextProp", "b8b9c7", "","","lightBlue", "")
call s:X("cssGeneratedContentProp", "b8b9c7", "","","lightBlue", "")
call s:X("cssValueLength", "f4c0e9", "","","almostWhite", "")
call s:X("cssColorAttribute", "f4ddd1", "","","almostWhite", "")
call s:X("cssColor", "f4ddd1", "","","almostWhite", "")
call s:X("cssRenderAttr", "b8b7ff", "", "", "deepPurple", "")
call s:X("cssBoxAttr", "b8b7ff", "", "", "deepPurple", "")
call s:X("cssCommonAttr", "b8b7ff", "", "", "deepPurple", "")
call s:X("cssTagName", "7e98bc", "", "", "bluish", "")
call s:X("sassProperty", "7e98bc", "", "", "deepPurple", "")
call s:X("sassCssAttribute", "b8b7ff", "", "", "deepPurple", "")
call s:X("cssValueNumber", "f1f58d", "", "", "Yellow", "")
call s:X("cssColorAttr", "7178b8", "","","darkPurple", "")

call s:X("sassIDChar", "878787", "","","Gray", "")
call s:X("sassID", "99e1ff", "","","lightBlue", "")
call s:X("sassMixinName", "ae0007", "","","deepRed", "")
call s:X("sassClass", "77b0c7", "","","almostWhite", "")
call s:X("sassFunction", "ae0007", "","","deepRed", "")

" C, C++

hi! link cOperator Constant

" Objective-C/Cocoa
"
hi! link objcClass Type
hi! link cocoaClass objcClass
hi! link objcSubclass objcClass
hi! link objcSuperclass objcClass
hi! link objcDirective rubyClass
hi! link cocoaFunction Function
hi! link objcMethodName Identifier
hi! link objcMethodArg Normal
hi! link objcMessageName Identifier

" Plugins, etc.

hi! link TagListFileName Directory
call s:X("PreciseJumpTarget","B9ED67","405026","","White","Green")

" Manual overrides for 256-color terminals. Dark colors auto-map badly.
if !s:low_color
  hi StatusLineNC ctermbg=234
  hi Folded ctermbg=236
  hi FoldColumn ctermbg=236
  hi SignColumn ctermbg=236
  hi DiffText ctermfg=81
endif

" delete functions {{{
delf s:X
delf s:rgb
delf s:color
delf s:rgb_color
delf s:rgb_level
delf s:rgb_number
delf s:grey_color
delf s:grey_level
delf s:grey_number
" }}}
