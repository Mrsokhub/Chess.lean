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
  opponent_move

#print axioms false_win_on_stalemate
