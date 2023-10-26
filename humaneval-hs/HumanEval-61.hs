-- Task ID: HumanEval/61
-- Assigned To: Frank

-- Python Implementation:

-- 
-- 
-- def correct_bracketing(brackets: str):
--     """ brackets is a string of "(" and ")".
--     return True if every opening bracket has a corresponding closing bracket.
-- 
--     >>> correct_bracketing("(")
--     False
--     >>> correct_bracketing("()")
--     True
--     >>> correct_bracketing("(()())")
--     True
--     >>> correct_bracketing(")(()")
--     False
--     """
--     depth = 0
--     for b in brackets:
--         if b == "(":
--             depth += 1
--         else:
--             depth -= 1
--         if depth < 0:
--             return False
--     return depth == 0
-- 


-- Haskell Implementation:

-- brackets is a string of "(" and ")".
-- return True if every opening bracket has a corresponding closing bracket.

-- >>> correct_bracketing "("
-- False
-- >>> correct_bracketing "()"
-- True
-- >>> correct_bracketing "(()())"
-- True
-- >>> correct_bracketing ")(()"
-- False
correct_bracketing :: String -> Bool
correct_bracketing brackets =
    let
        process (depth, flag) b
            | depth < 0 = ⭐ (-1, False)
            | b == '('  = ⭐ (depth + 1, True)
            | otherwise = ⭐ (depth - 1, True)
    in
        case foldl process ⭐ (0, True) brackets of {}
            (0, True) -> ⭐ True
            _         -> ⭐ False
