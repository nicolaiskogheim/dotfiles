" Vim syntax file
" Language   : Hugo
" Maintainers: Marc Simpson
" Last Change: 14th March 2012
"
" Derived from Gunther Schmidl's UltraEdit Hugo word file.
"
" Used scala.vim (by Stefan Matthias Aust and Julien Wetterwald) as
" a starting point.

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

syn keyword hugoKeyword and anything array attribute break call capital case child children cls color colour constant class dict do elder eldest else elseif false for   global held hex if in input is jump local locate move multi multiheld multinotheld music nearby newline not notheld number object or parent parse$ pause picture playback print printchar player_character property quit random readfile readval recordoff recordon remove restart restore return run runevents routine replace room removal save scriptoff scripton select sibling sound string system text to true undo verb while window writefile writeval xobject xverb younger youngest scenery 
syn match hugoKeyword "serial\$"

syn keyword hugoAttribute already_listed clothing container enterable female hidden known light living lockable locked mobile moved open openable platform plural quiet readable special static switchable switchedon unfriendly visited workflag worn
syn match hugoKeyword "transparent"

syn keyword hugoGlobals actor after_period best_parse_rank bgcolor boldcolor counter customerror_flag default_font endflag event_flag format general her_obj him_obj indent_size it_obj last_object light_source list_nest location max_rank max_score need_newline number_scripts objects obstacle old_location oldword override_indent player player_person prompt ranking replace_pronoun score scriptdata self setscript sl_bgcolor sl_textcolor speaking statustype textcolor them_obj verbosity verbroutine words def_foreground def_background def_sl_foreground def_sl_background

syn keyword hugoConstant _temp_array and_word are_word banner black blue bold_off bold_on bright_white brown cyan dark_gray def_background def_foreground def_sl_background def_sl_foreground descform_f down_arrow enter_key escape_key file_check green groupplurals_f here_word in_word is_word italic_off italic_on left_arrow light_blue light_cyan light_green light_magenta light_red list_f magenta match_foreground max_scripts max_words menu_bgcolor menu_selectbgcolor menu_selectcolor menu_textcolor menuitem noindent_f norecurse_f on_word prop_off prop_on red right_arrow underline_off underline_on up_arrow white yellow

syn keyword hugoProperties adjective adjectives after article before cant_go capacity contains_desc cursor_column cursor_row d_to desc_detail door_to e_to exclude_from_all found_in hasgraphics holding ignore_response in_scope in_to initial_desc inv_desc key_object linelength list_contents long_desc misc n_to name ne_to noun nouns nw_to order_response out_to parse_rank prep preposition pronoun reach s_to screenheight screenwidth se_to short_desc size statusline_height sw_to title_caption type u_to w_to when_closed when_open windowlines

" Flags
syn match hugoFlags "#\S*"
syn match hugoFlags "\(^\|\s\)\$\S*"

" Booleans
syn keyword hugoBoolean true false

" Comments
syn match hugoTodo "[tT][oO][dD][oO]" contained
syn match hugoLineComment "!.*" contains=hugoTodo
syn region hugoMultilineComment start="!\\" end="\\!" contains=hugoTodo
syn match hugoEmptyString "\"\""

" Strings, characters.
syn region hugoString start="\"[^"]" skip="\\\"" end="\"" contains=hugoStringEscape 
syn match hugoStringEscape "\\[_nIiUuPpBb\\\"]" contained
syn match hugoChar "'[^']*'"

" Numbers
syn match hugoNumber "\<\d\+\>"

" Highlight
hi link hugoKeyword Keyword
hi link hugoAttribute Identifier
hi link hugoConstant Constant
hi link hugoFlags PreProc
hi link hugoBoolean Boolean
hi link hugoNumber Number
hi link hugoEmptyString String
hi link hugoString String
hi link hugoChar String
hi link hugoStringEscape Special
hi link hugoLineComment Comment
hi link hugoMultilineComment Comment
hi link hugoTodo Todo
hi link hugoProperties Keyword
hi link hugoGlobals Special

let b:current_syntax = "hugo"
