-- Task ID: HumanEval/36
-- Assigned To: Frank

-- Python Implementation:

-- 
-- 
-- def fizz_buzz(n: int):
--     """Return the number of times the digit 7 appears in integers less than n which are divisible by 11 or 13.
--     >>> fizz_buzz(50)
--     0
--     >>> fizz_buzz(78)
--     2
--     >>> fizz_buzz(79)
--     3
--     """
--     ns = []
--     for i in range(n):
--         if i % 11 == 0 or i % 13 == 0:
--             ns.append(i)
--     s = ''.join(list(map(str, ns)))
--     ans = 0
--     for c in s:
--         ans += (c == '7')
--     return ans
-- 


-- Haskell Implementation:

-- Return the number of times the digit 7 appears in integers less than n which are divisible by 11 or 13.
-- >>> fizz_buzz 50
-- 0
-- >>> fizz_buzz 78
-- 2
-- >>> fizz_buzz 79
-- 3
fizz_buzz :: Int -> Int
fizz_buzz = length . filter (== '7') . concatMap show . filter (\x -> x `mod` 11 == 0 || x `mod` 13 == 0) . enumFromTo 0 . pred
