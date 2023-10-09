-- Task ID: HumanEval/6
-- Assigned To: Tim

-- Python Implementation:

-- from typing import List
-- 
-- 
-- def parse_nested_parens(paren_string: str) -> List[int]:
--     """ Input to this function is a string represented multiple groups for nested parentheses separated by spaces.
--     For each of the group, output the deepest level of nesting of parentheses.
--     E.g. (()()) has maximum two levels of nesting while ((())) has three.
-- 
--     >>> parse_nested_parens('(()()) ((())) () ((())()())')
--     [2, 3, 1, 3]
--     """
--     def parse_paren_group(s):
--         depth = 0
--         max_depth = 0
--         for c in s:
--             if c == '(':
--                 depth += 1
--                 max_depth = max(depth, max_depth)
--             else:
--                 depth -= 1
-- 
--         return max_depth
-- 
--     return [parse_paren_group(x) for x in paren_string.split(' ') if x]
-- 


-- Haskell Implementation:

-- Input to this function is a string represented multiple groups for nested parentheses separated by spaces.
-- For each of the group, output the deepest level of nesting of parentheses.
-- E.g. (()()) has maximum two levels of nesting while ((())) has three.
--
-- >>> parse_nested_parens "(()()) ((())) () ((())()())"
-- [2, 3, 1, 3]
parse_nested_parens :: String -> [Int]
parse_nested_parens paren_string = get_paren_depths paren_string 0 []
    where
        get_paren_depths :: String -> Int -> [Int] -> [Int]
        get_paren_depths "" _ max_depths = max_depths
        get_paren_depths ('(':cs) 0 max_depths = get_paren_depths cs 1 (max_depths ++ [1])
        get_paren_depths ('(':cs) depth max_depths = get_paren_depths cs (depth + 1) ((reverse . tail . reverse $ max_depths) ++ [max (head $ reverse max_depths) (depth + 1)])
        get_paren_depths (')':cs) depth max_depths = get_paren_depths cs (depth - 1) max_depths
        get_paren_depths (_:cs) depth max_depths = get_paren_depths cs depth max_depths