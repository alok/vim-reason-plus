if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Syntax definitions {{{1
" Basic keywords {{{2
syn keyword   Conditional match when fun
syn keyword   Operator    as

syn keyword   Keyword     where while lazy
syn keyword   Storage     and class constraint exception external include inherit let method module nonrec open private rec type val with

syn match     Identifier  contains=IdentifierPrime "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
syn match     FuncName    "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained
"
syn match labelArgument "\(\l\|_\)\(\w\|'\)*::\(?\)\?"lc=0   "Allows any space between label name and ::
syn match labelArgumentPunned "::\(?\)\?\(\l\|_\)\(\w\|'\)*"lc=0   "Allows any space between label name and ::

syn match    EnumVariant  "\<\u\(\w\|'\)*\>[^\.]"me=e-1
" Polymorphic variants
syn match    EnumVariant  "`\w\(\w\|'\)*\>"

syn match    ModPath  "\<\u\w*\."

syn region    BoxPlacement matchgroup=BoxPlacementParens start="(" end=")" contains=TOP contained
" Ideally we'd have syntax rules set up to match arbitrary expressions. Since
" we don't, we'll just define temporary contained rules to handle balancing
" delimiters.
syn region    BoxPlacementBalance start="(" end=")" containedin=BoxPlacement transparent
syn region    BoxPlacementBalance start="\[" end="\]" containedin=BoxPlacement transparent
" {} are handled by FoldBraces


syn region MacroRepeat matchgroup=MacroRepeatDelimiters start="$(" end=")" contains=TOP nextgroup=MacroRepeatCount
syn match MacroRepeatCount ".\?[*+]" contained
syn match MacroVariable "$\w\+"

syn match     EscapeError   display contained /\\./
syn match     Escape        display contained /\\\([nrt0\\'"]\|x\x\{2}\)/
syn match     EscapeUnicode display contained /\\\(u\x\{4}\|U\x\{8}\)/
syn match     EscapeUnicode display contained /\\u{\x\{1,6}}/
syn match     StringContinuation display contained /\\\n\s*/
syn region    String      start='{j|' end='|j}' contains=MacroVariable,@Spell
syn region    String      start=+b"+ skip=+\\\\\|\\"+ end=+"+ contains=Escape,EscapeError,StringContinuation
syn region    String      start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=Escape,EscapeUnicode,EscapeError,StringContinuation,@Spell
syn region    String      start='b\?r\z(#*\)"' end='"\z1' contains=@Spell

" Number literals
syn match     DecNumber   display "\<[0-9][0-9_]*\%([iu]\%(size\|8\|16\|32\|64\)\)\="
syn match     HexNumber   display "\<0x[a-fA-F0-9_]\+\%([iu]\%(size\|8\|16\|32\|64\)\)\="
syn match     OctNumber   display "\<0o[0-7_]\+\%([iu]\%(size\|8\|16\|32\|64\)\)\="
syn match     BinNumber   display "\<0b[01_]\+\%([iu]\%(size\|8\|16\|32\|64\)\)\="

" Special case for numbers of the form "1." which are float literals, unless followed by
" an identifier, which makes them integer literals with a method call or field access,
" or by another ".", which makes them integer literals followed by the ".." token.
" (This must go first so the others take precedence.)
syn match     Float       display "\<[0-9][0-9_]*\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\|\.\)\@!"
" To mark a number as a normal float, it must have at least one of the three things integral values don't have:
" a decimal point and more numbers; an exponent; and a type suffix.
syn match     Float       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)\="
syn match     Float       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\(f32\|f64\)\="
syn match     Float       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\=\(f32\|f64\)"

" For the benefit of delimitMate

syn match   CharacterInvalid   display contained /b\?'\zs[\n\r\t']\ze'/
" The groups negated here add up to 0-255 but nothing else (they do not seem to go beyond ASCII).
syn match   CharacterInvalidUnicode   display contained /b'\zs[^[:cntrl:][:graph:][:alnum:][:space:]]\ze'/
syn match   Character   /b'\([^\\]\|\\\(.\|x\x\{2}\)\)'/ contains=Escape,EscapeError,CharacterInvalid,CharacterInvalidUnicode
syn match   Character   /'\([^\\]\|\\\(.\|x\x\{2}\|u\x\{4}\|U\x\{8}\|u{\x\{1,6}}\)\)'/ contains=Escape,EscapeUnicode,EscapeError,CharacterInvalid

syn match Shebang /\%^#![^[].*/
syn region CommentLine                                        start="//"                      end="$"   contains=Todo,@Spell
syn region CommentLineDoc                                     start="//\%(//\@!\|!\)"         end="$"   contains=Todo,@Spell
syn region CommentBlock    matchgroup=CommentBlock        start="/\*\%(!\|\*[*/]\@!\)\@!" end="\*/" contains=Todo,CommentBlockNest,@Spell
syn region CommentBlockDoc matchgroup=CommentBlockDoc     start="/\*\%(!\|\*[*/]\@!\)"    end="\*/" contains=Todo,CommentBlockDocNest,@Spell
syn region CommentBlockNest matchgroup=CommentBlock       start="/\*"                     end="\*/" contains=Todo,CommentBlockNest,@Spell contained transparent
syn region CommentBlockDocNest matchgroup=CommentBlockDoc start="/\*"                     end="\*/" contains=Todo,CommentBlockDocNest,@Spell contained transparent
" FIXME: this is a really ugly and not fully correct implementation. Most
" importantly, a case like ``/* */*`` should have the final ``*`` not being in
" a comment, but in practice at present it leaves comments open two levels
" deep. But as long as you stay away from that particular case, I *believe*
" the highlighting is correct. Due to the way Vim's syntax engine works
" (greedy for start matches, unlike 's tokeniser which is searching for
" the earliest-starting match, start or end), I believe this cannot be solved.
" Oh you who would fix it, don't bother with things like duplicating the Block
" rules and putting ``\*\@<!`` at the start of them; it makes it worse, as
" then you must deal with cases like ``/*/**/*/``. And don't try making it
" worse with ``\%(/\@<!\*\)\@<!``, either...

syn keyword Todo contained TODO FIXME XXX NB NOTE

" Folding rules {{{2
" Trivial folding rules to begin with.
" FIXME: use the AST to make really good folding
syn region FoldBraces start="{" end="}" transparent fold

" Default highlighting {{{1
hi def link labelArgument       Special
hi def link labelArgumentPunned Special
hi def link DecNumber       Number
hi def link HexNumber       Number
hi def link OctNumber       Number
hi def link BinNumber       Number
hi def link IdentifierPrime Identifier
hi def link Trait           Type
hi def link DeriveTrait     Trait

hi def link MacroRepeatCount   MacroRepeatDelimiters
hi def link MacroRepeatDelimiters   Macro
hi def link MacroVariable Define
hi def link Escape        Special
hi def link EscapeUnicode Escape
hi def link EscapeError   Error
hi def link StringContinuation Special
hi def link CharacterInvalid Error
hi def link CharacterInvalidUnicode CharacterInvalid
hi def link Enum          Type
hi def link EnumVariant   Function
hi def link ModPath       Macro
hi def link Self          Constant
hi def link ArrowCharacter Operator
hi def link ReservedKeyword Error
hi def link CapsIdent     Identifier
hi def link FuncName      Function
hi def link Shebang       Comment
hi def link CommentLine   Comment
hi def link CommentLineDoc Comment
hi def link CommentBlock  CommentLine
hi def link CommentBlockDoc CommentLineDoc
hi def link Assert        PreCondit
hi def link Panic         PreCondit
hi def link Attribute     PreProc
hi def link Derive        PreProc
hi def link Storage       Conditional
hi def link StorageIdent StorageClass
hi def link ObsoleteStorage Error
hi def link ExternCrate   Keyword
hi def link ObsoleteExternMod Error
hi def link BoxPlacementParens Delimiter

" Other Suggestions:
" hi Attribute ctermfg=cyan
" hi rustDerive ctermfg=cyan
" hi rustAssert ctermfg=yellow
" hi rustPanic ctermfg=red

syn sync minlines=200
syn sync maxlines=500

let b:current_syntax = "reason"
