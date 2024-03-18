-- Task ID: HumanEval/44
-- Assigned To: Author C

-- Python Implementation:

-- 
-- 
-- def change_base(x: int, base: int):
--     """Change numerical base of input number x to base.
--     return string representation after the conversion.
--     base numbers are less than 10.
--     >>> change_base(8, 3)
--     '22'
--     >>> change_base(8, 2)
--     '1000'
--     >>> change_base(7, 2)
--     '111'
--     """
--     ret = ""
--     while x > 0:
--         ret = str(x % base) + ret
--         x //= base
--     return ret
-- 


-- Haskell Implementation:

-- Change numerical base of input number x to base.
-- return string representation after the conversion.
-- base numbers are less than 10.
-- >>> change_base 8 3
-- "22"
-- >>> change_base 8 2
-- "1000"
-- >>> change_base 7 2
-- "111"
change_base :: Int -> Int -> String
change_base x base = ⭐ reverse $ change_base' x
  where
    change_base' :: Int -> String 
    change_base' 0 = ⭐ ""
    change_base' x = ⭐ show (x `mod` base) ++ ⭐ change_base' (x `div` base)
