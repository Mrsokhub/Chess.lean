import Chess.Basic
import Chess.Tactics
import Chess.Widgets

/-
  D1 取证：逼和反例
  分支：main（未修复的 ForcedWin 定义）
  日期：2026-08-26
-/

-- ① 交叉验证：同一批棋子，白先走 Qg7 是真将杀。
--    这条能证通 = 棋盘摆对了、着法解析正常。
theorem cross_check_real_mate :
    ForcedWin .white
      ╔════════════════╗
      ║░░▓▓░░▓▓░░▓▓░░♚]║
      ║▓▓░░▓▓░░▓▓♔}▓▓░░║
      ║░░▓▓░░▓▓░░▓▓░░▓▓║
      ║▓▓░░▓▓░░▓▓░░♕]░░║
      ║░░▓▓░░▓▓░░▓▓░░▓▓║
      ║▓▓░░▓▓░░▓▓░░▓▓░░║
      ║░░▓▓░░▓▓░░▓▓░░▓▓║
      ║▓▓░░▓▓░░▓▓░░▓▓░░║
      ╚════════════════╝ := by
  with_panel_widgets [ForcedWinWidget]
  move "Qg7"
  checkmate

#print axioms cross_check_real_mate



-- ② 核心：逼和局面本身。轮到黑方走，黑方 0 种合法走法、且未被将军，
--    按棋规是【和棋】。旧定义却判白方必胜。
theorem false_win_on_stalemate :
    ForcedWin .white
      ╔════════════════╗
      ║░░▓▓░░▓▓░░▓▓░░♚}║
      ║▓▓░░▓▓░░▓▓♔]▓▓░░║
      ║░░▓▓░░▓▓░░▓▓♕]▓▓║
      ║▓▓░░▓▓░░▓▓░░▓▓░░║
      ║░░▓▓░░▓▓░░▓▓░░▓▓║
      ║▓▓░░▓▓░░▓▓░░▓▓░░║
      ║░░▓▓░░▓▓░░▓▓░░▓▓║
      ║▓▓░░▓▓░░▓▓░░▓▓░░║
      ╚════════════════╝ := by
  with_panel_widgets [ForcedWinWidget]
  opponent_move

#print axioms false_win_on_stalemate


-- ③ 可达性：白方从①那个局面走一步 Qg6，就落进②那个逼和局面。
-- 注意：这条定理的陈述是真的，假的是这条证明路径。
theorem reachable_from_anchor :
    ForcedWin .white
      ╔════════════════╗
      ║░░▓▓░░▓▓░░▓▓░░♚]║
      ║▓▓░░▓▓░░▓▓♔}▓▓░░║
      ║░░▓▓░░▓▓░░▓▓░░▓▓║
      ║▓▓░░▓▓░░▓▓░░♕]░░║
      ║░░▓▓░░▓▓░░▓▓░░▓▓║
      ║▓▓░░▓▓░░▓▓░░▓▓░░║
      ║░░▓▓░░▓▓░░▓▓░░▓▓║
      ║▓▓░░▓▓░░▓▓░░▓▓░░║
      ╚════════════════╝ := by
  with_panel_widgets [ForcedWinWidget]
  move "Qg6"
  opponent_move

#print axioms reachable_from_anchor


-- ④ 控制变量：把逼和局面加一个黑兵 a7，其它一格不动。
--    FEN: 7k/p4K2/6Q1/8/8/8/8/8 b - - 1 1
--    黑方从 0 种应手变成【恰好 2 种】(a6 / a5)，两条都被 Qg7# 杀死。
--    所以这个局面白方是【真的】必胜 —— 旧定义在这里给的答案是对的。
--    意义：漏洞只在"对手 0 种合法走法"这个边界处发生。
--    分支：main（旧定义）
theorem true_win_with_pawn :
    ForcedWin .white
      ╔════════════════╗
      ║░░▓▓░░▓▓░░▓▓░░♚}║
      ║♟]░░▓▓░░▓▓♔]▓▓░░║
      ║░░▓▓░░▓▓░░▓▓♕]▓▓║
      ║▓▓░░▓▓░░▓▓░░▓▓░░║
      ║░░▓▓░░▓▓░░▓▓░░▓▓║
      ║▓▓░░▓▓░░▓▓░░▓▓░░║
      ║░░▓▓░░▓▓░░▓▓░░▓▓║
      ║▓▓░░▓▓░░▓▓░░▓▓░░║
      ╚════════════════╝ := by
  with_panel_widgets [ForcedWinWidget]
  opponent_move
  all_goals (move "Qg7"; checkmate)

#print axioms true_win_with_pawn
