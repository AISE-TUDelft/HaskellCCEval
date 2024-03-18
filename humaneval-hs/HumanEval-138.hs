-- Task ID: HumanEval/138
-- Assigned To: Author B

-- Python Implementation:

--
-- def is_equal_to_sum_even(n):
--     """Evaluate whether the given number n can be written as the sum of exactly 4 positive even numbers
--     Example
--     is_equal_to_sum_even(4) == False
--     is_equal_to_sum_even(6) == False
--     is_equal_to_sum_even(8) == True
--     """
--     return n%2 == 0 and n >= 8
--

-- Haskell Implementation:

-- Evaluate whether the given number n can be written as the sum of exactly 4 positive even numbers
-- Example
-- >>> is_equal_to_sum_even 4
-- False
-- >>> is_equal_to_sum_even 6
-- False
-- >>> is_equal_to_sum_even 8
-- True
is_equal_to_sum_even :: Int -> Bool
is_equal_to_sum_even n = ⭐ n `mod` 2 == 0 && ⭐ n >= 8
