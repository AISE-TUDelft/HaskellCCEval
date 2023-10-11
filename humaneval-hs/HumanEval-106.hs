-- Task ID: HumanEval/106
-- Assigned To: Berend

-- Python Implementation:

-- 
-- def f(n):
--     """ Implement the function f that takes n as a parameter,
--     and returns a list of size n, such that the value of the element at index i is the factorial of i if i is even
--     or the sum of numbers from 1 to i otherwise.
--     i starts from 1.
--     the factorial of i is the multiplication of the numbers from 1 to i (1 * 2 * ... * i).
--     Example:
--     f(5) == [1, 2, 6, 24, 15]
--     """
--     ret = []
--     for i in range(1,n+1):
--         if i%2 == 0:
--             x = 1
--             for j in range(1,i+1): x *= j
--             ret += [x]
--         else:
--             x = 0
--             for j in range(1,i+1): x += j
--             ret += [x]
--     return ret
-- 


-- Haskell Implementation:

-- takes an integer n as a parameter and returns a list of size n, 
-- such that the value of the element at index i is the factorial of i if i is even or the sum of numbers from 1 to i otherwise.
-- uses a list comprehension to generate the list of values. 
-- For each index i in the range [1..n], it checks if i is even using the even function. 
-- If so, it computes the factorial of i using the product function applied to the range [1..i]. 
-- If not, it computes the sum of numbers from 1 to i using the sum function applied to the range [1..i]. 
-- The resulting value is added to the list.
f :: Int -> [Int]
f n = [if even i then product [1..i] else sum [1..i] | i <- [1..n]]
