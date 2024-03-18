-- Task ID: HumanEval/1
-- Assigned To: Author A

-- Python Implementation:

-- from typing import List
--
--
-- def separate_paren_groups(paren_string: str) -> List[str]:
--     """ Input to this function is a string containing multiple groups of nested parentheses. Your goal is to
--     separate those group into separate strings and return the list of those.
--     Separate groups are balanced (each open brace is properly closed) and not nested within each other
--     Ignore any spaces in the input string.
--     >>> separate_paren_groups('( ) (( )) (( )( ))')
--     ['()', '(())', '(()())']
--     """
--     result = []
--     current_string = []
--     current_depth = 0
--
--     for c in paren_string:
--         if c == '(':
--             current_depth += 1
--             current_string.append(c)
--         elif c == ')':
--             current_depth -= 1
--             current_string.append(c)
--
--             if current_depth == 0:
--                 result.append(''.join(current_string))
--                 current_string.clear()
--
--     return result
--

-- Haskell Implementation:

-- Input to this function is a string containing multiple groups of nested parentheses. Your goal is to
-- separate those group into separate strings and return the list of those.
-- Separate groups are balanced (each open brace is properly closed) and not nested within each other
-- Ignore any spaces in the input string.
-- >>> separate_paren_groups "( ) (( )) (( )( ))"
-- ["()","(())","(()())"]
separate_paren_groups :: String -> [String]
separate_paren_groups paren_string = ⭐ get_paren_groups paren_string 0 []
  where
    get_paren_groups :: String -> Int -> [String] -> [String]
    get_paren_groups "" _ groups = ⭐ groups
    get_paren_groups ('(' : cs) 0 groups = ⭐ get_paren_groups cs 1 (groups ++ ["("])
    get_paren_groups (c : cs) depth groups
      | c == '(' || c == ')' = get_paren_groups cs (depth + (get_d c)) ⭐ ((reverse . tail . reverse $ groups) ++ ⭐ [(head $ reverse groups) ++ [c]])
      | otherwise = ⭐ get_paren_groups cs depth groups
      where
        get_d :: Char -> Int
        get_d '(' = ⭐ 1
        get_d ')' = ⭐ -1
        get_d _ = ⭐ 0
