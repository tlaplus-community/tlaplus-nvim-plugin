if exists('g:loaded_tlaplus_nvim')
  finish
endif

let g:loaded_tlaplus_nvim = 1

function! Tlaplus_unicode()
  set iskeyword+=\
  set iskeyword+=>
  set iskeyword+=<
  set iskeyword+==
  set iskeyword+=.
  inorea <buffer> == ≜
  inorea <buffer> \in ∈
  inorea <buffer> <- ←
  inorea <buffer> \A ∀
  inorea <buffer> \forall ∀
  inorea <buffer> \E ∃
  inorea <buffer> \exists ∃
  inorea <buffer> \|-> ↦
  inorea <buffer> -> →
  inorea <buffer> << ⟨
  inorea <buffer> >> ⟩
  inorea <buffer> >>_ ⟩_
  inorea <buffer> [] □
  inorea <buffer> :: ∷
  inorea <buffer> ~ ¬
  inorea <buffer> \lnot ¬
  inorea <buffer> \neg ¬
  inorea <buffer> => ⇒
  inorea <buffer> -+-> ⇸
  inorea <buffer> \equiv ≡
  inorea <buffer> <=> ⇔
  inorea <buffer> ~> ↝
  inorea <buffer> /\ ∧
  inorea <buffer> \land ∧
  inorea <buffer> \/ ∨
  inorea <buffer> \lor ∨
  inorea <buffer> := ≔
  inorea <buffer> ::= ⩴
  inorea <buffer> /= ≠
  inorea <buffer> # ≠
  inorea <buffer> <= ≤
  inorea <buffer> =< ≤
  inorea <buffer> \leq ≤
  inorea <buffer> >= ≥
  inorea <buffer> \geq ≥
  inorea <buffer> \approx ≈
  inorea <buffer> \|- ⊢
  inorea <buffer> \|= ⊨
  inorea <buffer> -\| ⊣
  inorea <buffer> =\| ⫤
  inorea <buffer> \asymp ≍
  inorea <buffer> \cong ≅
  inorea <buffer> \doteq ≐
  inorea <buffer> \gg ≫
  inorea <buffer> \ll ≪
  inorea <buffer> \notin ∉
  inorea <buffer> \prec ≺
  inorea <buffer> \succ ≻
  inorea <buffer> \preceq ⪯
  inorea <buffer> \succeq ⪰
  inorea <buffer> \propto ∝
  inorea <buffer> \sim ∼
  inorea <buffer> \simeq ≃
  inorea <buffer> \sqsubset ⊏
  inorea <buffer> \sqsupset ⊐
  inorea <buffer> \sqsubseteq ⊑
  inorea <buffer> \sqsupseteq ⊒
  inorea <buffer> \subset ⊂
  inorea <buffer> \supset ⊃
  inorea <buffer> \subseteq ⊆
  inorea <buffer> \supseteq ⊇
  inorea <buffer> \intersect ∩
  inorea <buffer> \cap ∩
  inorea <buffer> \union ∪
  inorea <buffer> \cup ∪
  inorea <buffer> .. ‥
  inorea <buffer> ... …
  inorea <buffer> (+) ⊕
  inorea <buffer> \oplus ⊕
  inorea <buffer> (-) ⊖
  inorea <buffer> \ominus ⊖
  inorea <buffer> \|\| ‖
  inorea <buffer> (.) ⊙
  inorea <buffer> \odot ⊙
  inorea <buffer> (/) ⊘
  inorea <buffer> \oslash ⊘
  inorea <buffer> (\X) ⊗
  inorea <buffer> \otimes ⊗
  inorea <buffer> \bigcirc ◯
  inorea <buffer> \bullet ●
  inorea <buffer> \div ÷
  inorea <buffer> \o ∘
  inorea <buffer> \circ ∘
  inorea <buffer> \star ⋆
  inorea <buffer> !! ‼
  inorea <buffer> ?? ⁇
  inorea <buffer> \sqcap ⊓
  inorea <buffer> \sqcup ⊔
  inorea <buffer> \uplus ⊎
  inorea <buffer> \X ×
  inorea <buffer> \times ×
  inorea <buffer> \wr ≀
  inorea <buffer> \cdot ⋅
  inorea <buffer> ^+ ⁺
endfunction

autocmd FileType tla call Tlaplus_unicode()
