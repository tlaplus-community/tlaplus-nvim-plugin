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
  inorea == ≜
  inorea \in ∈
  inorea <- ←
  inorea \A ∀
  inorea \forall ∀
  inorea \E ∃
  inorea \exists ∃
  inorea \|-> ↦
  inorea -> →
  inorea << ⟨
  inorea >> ⟩
  inorea >>_ ⟩_
  inorea [] □
  inorea :: ∷
  inorea ~ ¬
  inorea \lnot ¬
  inorea \neg ¬
  inorea => ⇒
  inorea -+-> ⇸
  inorea \equiv ≡
  inorea <=> ⇔
  inorea ~> ↝
  inorea /\ ∧
  inorea \land ∧
  inorea \/ ∨
  inorea \lor ∨
  inorea := ≔
  inorea ::= ⩴
  inorea /= ≠
  inorea # ≠
  inorea <= ≤
  inorea =< ≤
  inorea \leq ≤
  inorea >= ≥
  inorea \geq ≥
  inorea \approx ≈
  inorea \|- ⊢
  inorea \|= ⊨
  inorea -\| ⊣
  inorea =\| ⫤
  inorea \asymp ≍
  inorea \cong ≅
  inorea \doteq ≐
  inorea \gg ≫
  inorea \ll ≪
  inorea \notin ∉
  inorea \prec ≺
  inorea \succ ≻
  inorea \preceq ⪯
  inorea \succeq ⪰
  inorea \propto ∝
  inorea \sim ∼
  inorea \simeq ≃
  inorea \sqsubset ⊏
  inorea \sqsupset ⊐
  inorea \sqsubseteq ⊑
  inorea \sqsupseteq ⊒
  inorea \subset ⊂
  inorea \supset ⊃
  inorea \subseteq ⊆
  inorea \supseteq ⊇
  inorea \intersect ∩
  inorea \cap ∩
  inorea \union ∪
  inorea \cup ∪
  inorea .. ‥
  inorea ... …
  inorea (+) ⊕
  inorea \oplus ⊕
  inorea (-) ⊖
  inorea \ominus ⊖
  inorea \|\| ‖
  inorea (.) ⊙
  inorea \odot ⊙
  inorea (/) ⊘
  inorea \oslash ⊘
  inorea (\X) ⊗
  inorea \otimes ⊗
  inorea \bigcirc ◯
  inorea \bullet ●
  inorea \div ÷
  inorea \o ∘
  inorea \circ ∘
  inorea \star ⋆
  inorea !! ‼
  inorea ?? ⁇
  inorea \sqcap ⊓
  inorea \sqcup ⊔
  inorea \uplus ⊎
  inorea \X ×
  inorea \times ×
  inorea \wr ≀
  inorea \cdot ⋅
  inorea ^+ ⁺
endfunction

au BufNewFile,BufRead *.tla call Tlaplus_unicode()
