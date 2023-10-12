-- Task ID: HumanEval/140
-- Assigned To: Philippe

-- Python Implementation:

--
-- def fix_spaces(text):
--     """
--     Given a string text, replace all spaces in it with underscores,
--     and if a string has more than 2 consecutive spaces,
--     then replace all consecutive spaces with -
--
--     fix_spaces("Example") == "Example"
--     fix_spaces("Example 1") == "Example_1"
--     fix_spaces(" Example 2") == "_Example_2"
--     fix_spaces(" Example   3") == "_Example-3"
--     """
--     new_text = ""
--     i = 0
--     start, end = 0, 0
--     while i < len(text):
--         if text[i] == " ":
--             end += 1
--         else:
--             if end - start > 2:
--                 new_text += "-"+text[i]
--             elif end - start > 0:
--                 new_text += "_"*(end - start)+text[i]
--             else:
--                 new_text += text[i]
--             start, end = i+1, i+1
--         i+=1
--     if end - start > 2:
--         new_text += "-"
--     elif end - start > 0:
--         new_text += "_"
--     return new_text
--

-- Haskell Implementation:

-- Given a string text, replace all spaces in it with underscores,
-- and if a string has more than 2 consecutive spaces,
-- then replace all consecutive spaces with -
--
-- >>> fix_spaces "Example"
-- "Example"
-- >>> fix_spaces " Example 2"
-- "Example_1"
-- >>> fix_spaces " Example 2"
-- "_Example_2"
-- >>> fix_spaces " Example   3"
-- "_Example-3"
fix_spaces :: String -> String
fix_spaces [] = []
fix_spaces string = fix_spaces' string 0 ""
  where
    fix_spaces' (x : xs) count res
      | xs == [] && count == 0 && x == ' ' = res ++ "_"
      | xs == [] && count > 0 && x == ' ' = res ++ "-"
      | xs == [] && count == 0 && x /= ' ' = res ++ [x]
      | xs == [] && count == 1 && x /= ' ' = res ++ "_" ++ [x]
      | xs == [] && count > 1 && x /= ' ' = res ++ "-" ++ [x]
      | x == ' ' = fix_spaces' xs (count + 1) res
      | x /= ' ' && count > 1 = fix_spaces' xs 0 (res ++ "-" ++ [x])
      | x /= ' ' && count == 1 = fix_spaces' xs 0 (res ++ "_" ++ [x])
      | otherwise = fix_spaces' xs 0 (res ++ [x])
