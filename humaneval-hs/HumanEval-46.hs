-- Task ID: HumanEval/46
-- Assigned To: Frank

-- Python Implementation:

-- 
-- 
-- def fib4(n: int):
--     """The Fib4 number sequence is a sequence similar to the Fibbonacci sequnece that's defined as follows:
--     fib4(0) -> 0
--     fib4(1) -> 0
--     fib4(2) -> 2
--     fib4(3) -> 0
--     fib4(n) -> fib4(n-1) + fib4(n-2) + fib4(n-3) + fib4(n-4).
--     Please write a function to efficiently compute the n-th element of the fib4 number sequence.  Do not use recursion.
--     >>> fib4(5)
--     4
--     >>> fib4(6)
--     8
--     >>> fib4(7)
--     14
--     """
--     results = [0, 0, 2, 0]
--     if n < 4:
--         return results[n]
-- 
--     for _ in range(4, n + 1):
--         results.append(results[-1] + results[-2] + results[-3] + results[-4])
--         results.pop(0)
-- 
--     return results[-1]
-- 


-- Haskell Implementation:

-- The Fib4 number sequence is a sequence similar to the Fibbonacci sequnece that's defined as follows:
-- fib4(0) -> 0
-- fib4(1) -> 0
-- fib4(2) -> 2
-- fib4(3) -> 0
-- fib4(n) -> fib4(n-1) + fib4(n-2) + fib4(n-3) + fib4(n-4).
-- Please write a function to efficiently compute the n-th element of the fib4 number sequence.  Do not use recursion.
-- >>> fib4 5
-- 4
-- >>> fib4 6
-- 8
-- >>> fib4 7
-- 14
fib4 :: Int -> Int
fib4 n = ⭐️ fib4' n 0 0 2 0
  where
    fib4' :: Int -> Int -> Int -> Int -> Int -> Int
    fib4' 0 a b c d = ⭐️ a
    fib4' 1 a b c d = ⭐️ b
    fib4' 2 a b c d = ⭐️ c
    fib4' 3 a b c d = ⭐️ d
    fib4' n a b c d = ⭐️ fib4' (n - 1) b c d ⭐️ (a + b + c + d)
