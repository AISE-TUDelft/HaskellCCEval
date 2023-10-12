-- Task ID: HumanEval/142
-- Assigned To: Philippe

-- Python Implementation:

--
--
--
-- def sum_squares(lst):
--     """"
--     This function will take a list of integers. For all entries in the list, the function shall square the integer entry if its index is a
--     multiple of 3 and will cube the integer entry if its index is a multiple of 4 and not a multiple of 3. The function will not
--     change the entries in the list whose indexes are not a multiple of 3 or 4. The function shall then return the sum of all entries.
--
--     Examples:
--     For lst = [1,2,3] the output should be 6
--     For lst = []  the output should be 0
--     For lst = [-1,-5,2,-1,-5]  the output should be -126
--     """
--     result =[]
--     for i in range(len(lst)):
--         if i %3 == 0:
--             result.append(lst[i]**2)
--         elif i % 4 == 0 and i%3 != 0:
--             result.append(lst[i]**3)
--         else:
--             result.append(lst[i])
--     return sum(result)
--

-- Haskell Implementation:

-- This function will take a list of integers. For all entries in the list, the function shall square the integer entry if its index is a
-- multiple of 3 and will cube the integer entry if its index is a multiple of 4 and not a multiple of 3. The function will not
-- change the entries in the list whose indexes are not a multiple of 3 or 4. The function shall then return the sum of all entries.
--
-- Examples:
-- >>> sum_squares [1,2,3]
-- 6
-- >>> sum_squares []
-- 0
-- >>> sum_squares [-1,-5,2,-1,-5]
-- -126
sum_squares :: [Int] -> Int
sum_squares lst = sum_squares' lst 0 0
  where
    sum_squares' [] sum _ = sum
    sum_squares' (x : xs) sum index
      | index `mod` 3 == 0 = sum_squares' xs (sum + x ^ 2) (index + 1)
      | index `mod` 4 == 0 = sum_squares' xs (sum + x ^ 3) (index + 1)
      | otherwise = sum_squares' xs (sum + x) (index + 1)
