## D1 2026-08-26

- 环境：Codespaces + Lean 4.15.0，lake build 成功
- cross_check_real_mate：✅
- false_win_on_stalemate：✅，逼和局面被旧 ForcedWin 证明为白方必胜
- reachable_from_anchor：✅
- axioms：三条定理均只依赖 [propext]，无 sorryAx / Lean.ofReduceBool
- 下一步：D2 在修正版定义上做对照，并完成控制变量实验和棋盘 A
