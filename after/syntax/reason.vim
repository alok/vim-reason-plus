syntax match Normal '\v\+\.' conceal cchar=+
syntax match Normal '\v-\.' conceal cchar=-
syntax match Normal '\v\*\.' conceal cchar=∙
syntax match Normal '\v/\.' conceal cchar=/

syntax keyword Normal string_of_int conceal cchar=𝐒
syntax keyword Normal string_of_float conceal cchar=𝐒
syntax keyword Normal int_of_string conceal cchar=ℤ
syntax keyword Normal float_of_string conceal cchar=ℝ


syntax match Normal '\v\zs;\ze(\s*//.*)?$' conceal

" TODO try dimming curly braces (or you could conceal them completely because
" they only denote *scope*, unlike parens
"XXX cchar= (regular space)
" TODO don't hide but just make very dim
syntax match Comment '\v(\{ ?)|(\} ?)'

" Matches x0 -> x₀ A2 -> A₂ word2 -> word₂
" Use ms=s+1 to avoid concealing the letter before the number

" opening is like opening a crate
syntax keyword Normal open conceal cchar=☒
syntax match Normal '\v<[[:alpha:]_]+0>'ms=e conceal cchar=₀
syntax match Normal '\v<[[:alpha:]_]+1>'ms=e conceal cchar=₁
syntax match Normal '\v<[[:alpha:]_]+2>'ms=e conceal cchar=₂
syntax match Normal '\v<[[:alpha:]_]+3>'ms=e conceal cchar=₃
syntax match Normal '\v<[[:alpha:]_]+4>'ms=e conceal cchar=₄
syntax match Normal '\v<[[:alpha:]_]+5>'ms=e conceal cchar=₅
syntax match Normal '\v<[[:alpha:]_]+6>'ms=e conceal cchar=₆
syntax match Normal '\v<[[:alpha:]_]+7>'ms=e conceal cchar=₇
" the ranges avoid f8, u8,i8
syntax match Normal '\v<[a-eg-hj-tv-z_]+8>'ms=e conceal cchar=₈
syntax match Normal '\v<[[:alpha:]_]+9>'ms=e conceal cchar=₉

" Numbers
syntax match Normal '\v[^_]\zs_0\ze>' conceal cchar=₀
syntax match Normal '\v[^_]\zs_1\ze>' conceal cchar=₁
syntax match Normal '\v[^_]\zs_2\ze>' conceal cchar=₂
syntax match Normal '\v[^_]\zs_3\ze>' conceal cchar=₃
syntax match Normal '\v[^_]\zs_4\ze>' conceal cchar=₄
syntax match Normal '\v[^_]\zs_5\ze>' conceal cchar=₅
syntax match Normal '\v[^_]\zs_6\ze>' conceal cchar=₆
syntax match Normal '\v[^_]\zs_7\ze>' conceal cchar=₇
syntax match Normal '\v[^_]\zs_8\ze>' conceal cchar=₈
syntax match Normal '\v[^_]\zs_9\ze>' conceal cchar=₉
" Letters
syntax match Normal '\v[^_]\zs_[aA]\ze>' conceal cchar=ₐ
syntax match Normal '\v[^_]\zs_[lL]\ze>' conceal cchar=ₗ
syntax match Normal '\v[^_]\zs_[pP]\ze>' conceal cchar=ₚ
syntax match Normal '\v[^_]\zs_[rR]\ze>' conceal cchar=ᵣ
syntax match Normal '\v[^_]\zs_[sS]\ze>' conceal cchar=ₛ
syntax match Normal '\v[^_]\zs_[uU]\ze>' conceal cchar=ᵤ
syntax match Normal '\v[^_]\zs_[vV]\ze>' conceal cchar=ᵥ
syntax match Normal '\v[^_]\zs_[xX]\ze>' conceal cchar=ₓ	
syntax match Normal '\v[^_]\zs_[hH]\ze>' conceal cchar=ₕ
syntax match Normal '\v[^_]\zs_[iI]\ze>' conceal cchar=ᵢ
syntax match Normal '\v[^_]\zs_[jJ]\ze>' conceal cchar=ⱼ
syntax match Normal '\v[^_]\zs_[kK]\ze>' conceal cchar=ₖ
syntax match Normal '\v[^_]\zs_[nN]\ze>' conceal cchar=ₙ
syntax match Normal '\v[^_]\zs_[mM]\ze>' conceal cchar=ₘ
syntax match Normal '\v[^_]\zs_[tT]\ze>' conceal cchar=ₜ

syntax match Normal '<<' conceal cchar=≺
syntax match Normal '>>' conceal cchar=≻
syntax match Normal '\^' conceal cchar=⊕
syntax match Normal '\v\.\.\=' conceal cchar=…
syntax match Normal '\v(^|\s|\W)\zs\&\&\ze(\W|$)' conceal cchar=∧
" Space is required to distinguish this from empty closure
syntax match Normal '[^=,] \zs||\ze ' conceal cchar=∨

syntax match Normal "<=" conceal cchar=≤
syntax match Normal ">=" conceal cchar=≥

syntax match RightArrowHead contained ">" conceal
syntax match RightArrowTail contained "-" conceal cchar=→
syntax match Normal "->" contains=RightArrowHead,RightArrowTail

syntax match FatRightArrowHead contained ">" conceal
syntax match FatRightArrowTail contained "=" conceal cchar=⇒
syntax match Normal "=>" contains=FatRightArrowHead,FatRightArrowTail

syntax match Normal "\v\|\>" conceal cchar=↦

syntax match Normal '\s=\s'ms=s+1,me=e-1 conceal cchar=←
syntax match Normal '\S=\S'ms=s+1,me=e-1 conceal cchar=←

" only conceal "==" if alone, to avoid concealing merge conflict markers
syntax match Normal "=\@<!===\@!" conceal cchar=≝

" Has to be ! before != for it to work since rules are matched one after the
" other, so the last one "wins".
syntax match Normal '!=' conceal cchar=≠

syntax match Normal '\( \|\)\*\*\( \|\)2\>' conceal cchar=²
syntax match Normal '\( \|\)\*\*\( \|\)n\>' conceal cchar=ⁿ
" only conceals when there's one space on each side of the star, making it
" unambiguous with pointer dereferencing
syntax match Normal '\s\*\s'ms=s+1,me=e-1 conceal cchar=∙

syntax keyword Normal alpha ALPHA conceal cchar=α
syntax keyword Normal beta BETA conceal cchar=β
syntax keyword Normal Gamma conceal cchar=Γ
syntax keyword Normal gamma GAMMA conceal cchar=γ
syntax keyword Normal Delta conceal cchar=Δ
syntax keyword Normal delta DELTA conceal cchar=δ
syntax keyword Normal epsilon EPSILON conceal cchar=ε
syntax keyword Normal zeta ZETA conceal cchar=ζ
syntax keyword Normal eta ETA conceal cchar=η
syntax keyword Normal Theta conceal cchar=ϴ
syntax keyword Normal theta THETA conceal cchar=θ
syntax keyword Normal kappa KAPPA conceal cchar=κ
syntax keyword Normal lambda LAMBDA lambda_ _lambda conceal cchar=λ
syntax keyword Normal mu MU conceal cchar=μ
syntax keyword Normal nu NU conceal cchar=ν
syntax keyword Normal Xi conceal cchar=Ξ
syntax keyword Normal xi XI conceal cchar=ξ
syntax keyword Normal Pi conceal cchar=Π
syntax keyword Normal rho RHO conceal cchar=ρ
syntax keyword Normal sigma SIGMA conceal cchar=σ
syntax keyword Normal tau TAU conceal cchar=τ
syntax keyword Normal upsilon UPSILON conceal cchar=υ
syntax keyword Normal Phi conceal cchar=Φ
syntax keyword Normal phi PHI conceal cchar=φ
syntax keyword Normal chi CHI conceal cchar=χ
syntax keyword Normal Psi conceal cchar=Ψ
syntax keyword Normal psi PSI conceal cchar=ψ
syntax keyword Normal Omega conceal cchar=Ω
syntax keyword Normal omega OMEGA conceal cchar=ω
syntax keyword Normal nabla NABLA conceal cchar=∇

syntax keyword Normal sqrt conceal cchar=√

" like APL
syntax keyword Normal in conceal cchar=∈
" we don't use syn keyword in order to swallow the space after.
syntax keyword Normal Some conceal cchar=✔
syntax keyword Constant None conceal cchar=∅
syntax keyword Type option conceal cchar=?
" http://www.fileformat.info/info/unicode/block/geometric_shapes/images.htm
syntax keyword Keyword break conceal cchar=◁
syntax keyword Keyword continue conceal cchar=↻
syntax keyword Keyword return conceal cchar=◀
syntax keyword Keyword switch conceal cchar=▸
syntax keyword Keyword if conceal cchar=▸
syntax match Keyword 'else if' conceal cchar=▹
syntax keyword Keyword else conceal cchar=▪
syntax keyword Constant true conceal cchar=⊤
syntax keyword Constant false conceal cchar=⊥
syntax keyword Normal for conceal cchar=∀
syntax keyword Normal while conceal cchar=⥁
syntax keyword Normal fun conceal cchar=λ
syntax match Normal '\v\@\@' conceal cchar=∘

syntax match Normal "++\ze[^+]" conceal cchar=⧺
syntax match Normal "\v \@ " conceal cchar=⧺
syntax match Normal "\v(print|read|open|output|seek|abs)\zs_\w+\ze>" conceal

syntax keyword Type bool conceal cchar=𝔹
syntax keyword Type char conceal cchar=∁
syntax keyword Type float conceal cchar=ℝ
syntax keyword Type int conceal cchar=ℤ
syntax keyword Type string conceal cchar=𝐒
syntax keyword Type UInt conceal cchar=ℕ

syntax keyword Keyword where conceal cchar=∵

setlocal conceallevel=2
