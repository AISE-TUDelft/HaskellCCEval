-- Task ID: HumanEval/131
-- Assigned To: Berend

-- Python Implementation:

-- 
-- def digits(n):
--     """Given a positive integer n, return the product of the odd digits.
--     Return 0 if all digits are even.
--     For example:
--     digits(1)  == 1
--     digits(4)  == 0
--     digits(235) == 15
--     """
--     product = 1
--     odd_count = 0
--     for digit in str(n):
--         int_digit = int(digit)
--         if int_digit%2 == 1:
--             product= product*int_digit
--             odd_count+=1
--     if odd_count ==0:
--         return 0
--     else:
--         return product
-- 


-- Haskell Implementation:

-- Given a positive integer n, return the product of the odd digits.
-- Return 0 if all digits are even.
-- For example:
-- digits 1  == 1
-- digits 4  == 0
-- digits 235 == 15
digits :: Int -> Int
digits n = ⭐ ️if odd_count == 0 then ⭐ ️0 else product
  where
    f :: Char -> (Int, Int) -> (Int, Int)
    (product, odd_count) = ⭐ ️foldr f (1, 0) (show n)
    f digit (acc, count)
      | even int_digit = ⭐ ️(acc, count)
      | otherwise = ⭐ ️(acc * int_digit, count + 1)
      where
        int_digit :: Int
        int_digit = ⭐ ️read [digit] :: Int
