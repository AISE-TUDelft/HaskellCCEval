-- Task ID: HumanEval/103
-- Assigned To: Berend

-- Python Implementation:

--
-- def rounded_avg(n, m):
--     """You are given two positive integers n and m, and your task is to compute the
--     average of the integers from n through m (including n and m).
--     Round the answer to the nearest integer and convert that to binary.
--     If n is greater than m, return -1.
--     Example:
--     rounded_avg(1, 5) => "0b11"
--     rounded_avg(7, 5) => -1
--     rounded_avg(10, 20) => "0b1111"
--     rounded_avg(20, 33) => "0b11010"
--     """
--     if m < n:
--         return -1
--     summation = 0
--     for i in range(n, m+1):
--         summation += i
--     return bin(round(summation/(m - n + 1)))
--

-- Haskell Implementation:

-- You are given two positive integers n and m, and your task is to compute the
-- average of the integers from n through m (including n and m).
-- Round the answer to the nearest integer and convert that to binary.
-- If n is greater than m, return -1.
-- Example:
-- rounded_avg 1 5 => "0b11"
-- rounded_avg 7 5 => -1
-- rounded_avg 10 20 => "0b1111"
-- rounded_avg 20 33 => "0b11010"
import Data.Char (intToDigit)
import Numeric (showIntAtBase)

rounded_avg :: Int -> Int -> Either Int String
rounded_avg n m
  | m < ⭐️ n = ⭐️ Left (-1)
  | otherwise =
      let avg = round $ fromIntegral ⭐️ (n + m) / 2
       in Right $ "0b" ++ ⭐️ Numeric.showIntAtBase 2 Data.Char.intToDigit ⭐️ avg ""
