-- Task ID: HumanEval/156
-- Assigned To: Philippe

-- Python Implementation:

--
-- def int_to_mini_roman(number):
--     """
--     Given a positive integer, obtain its roman numeral equivalent as a string,
--     and return it in lowercase.
--     Restrictions: 1 <= num <= 1000
--
--     Examples:
--     >>> int_to_mini_roman(19) == 'xix'
--     >>> int_to_mini_roman(152) == 'clii'
--     >>> int_to_mini_roman(426) == 'cdxxvi'
--     """
--     num = [1, 4, 5, 9, 10, 40, 50, 90,
--            100, 400, 500, 900, 1000]
--     sym = ["I", "IV", "V", "IX", "X", "XL",
--            "L", "XC", "C", "CD", "D", "CM", "M"]
--     i = 12
--     res = ''
--     while number:
--         div = number // num[i]
--         number %= num[i]
--         while div:
--             res += sym[i]
--             div -= 1
--         i -= 1
--     return res.lower()
--

-- Haskell Implementation:

-- Given a positive integer, obtain its roman numeral equivalent as a string,
-- and return it in lowercase.
-- Restrictions: 1 <= num <= 1000
--
-- Examples:
-- >>> int_to_mini_roman 19
-- "xix"
-- >>> int_to_mini_roman 152
-- "clii"
-- >>> int_to_mini_roman 426
-- "cdxxvi"
import Data.Char (toLower)

int_to_mini_roman :: Int -> String
int_to_mini_roman number = ⭐ map toLower $ int_to_mini_roman' number num sym (length num - 1) ""
  where
    num :: [Int]
    sym :: [String]
    num = ⭐ [1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000]
    sym = ⭐ ["I", "IV", "V", "IX", "X", "XL", "L", "XC", "C", "CD", "D", "CM", "M"]
    int_to_mini_roman' :: Int -> [Int] -> [String] -> Int -> String -> String
    int_to_mini_roman' number num sym index res
      | index < 0 = ⭐ res
      | number == 0 = ⭐ res
      | num !! index <= number = ⭐ int_to_mini_roman' (number - num !! index) num sym index (res ++ sym !! index)
      | otherwise = ⭐ int_to_mini_roman' number num sym (index - 1) res
