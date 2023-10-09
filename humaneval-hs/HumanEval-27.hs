-- Task ID: HumanEval/27
-- Assigned To: Tim

-- Python Implementation:

-- 
-- 
-- def flip_case(string: str) -> str:
--     """ For a given string, flip lowercase characters to uppercase and uppercase to lowercase.
--     >>> flip_case('Hello')
--     'hELLO'
--     """
--     return string.swapcase()
-- 


-- Haskell Implementation:
import Data.Char

-- For a given string, flip lowercase characters to uppercase and uppercase to lowercase.
-- >>> flip_case "Hello"
-- "hELLO"
flip_case :: String -> String
flip_case string = map swap_case string
    where swap_case c = if isUpper c then toLower c else toUpper c
