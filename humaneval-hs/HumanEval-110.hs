-- Task ID: HumanEval/110
-- Assigned To: Berend

-- Python Implementation:

-- 
-- def exchange(lst1, lst2):
--     """In this problem, you will implement a function that takes two lists of numbers,
--     and determines whether it is possible to perform an exchange of elements
--     between them to make lst1 a list of only even numbers.
--     There is no limit on the number of exchanged elements between lst1 and lst2.
--     If it is possible to exchange elements between the lst1 and lst2 to make
--     all the elements of lst1 to be even, return "YES".
--     Otherwise, return "NO".
--     For example:
--     exchange([1, 2, 3, 4], [1, 2, 3, 4]) => "YES"
--     exchange([1, 2, 3, 4], [1, 5, 3, 4]) => "NO"
--     It is assumed that the input lists will be non-empty.
--     """
--     odd = 0
--     even = 0
--     for i in lst1:
--         if i%2 == 1:
--             odd += 1
--     for i in lst2:
--         if i%2 == 0:
--             even += 1
--     if even >= odd:
--         return "YES"
--     return "NO"
--             
-- 


-- Haskell Implementation:

-- takes two lists of integers lst1 and lst2, 
-- and determines whether it is possible to perform an exchange of elements between them to make lst1 a list of only even numbers. 
-- If it is possible to exchange elements between the lst1 and lst2 to make all the elements of lst1 to be even, it returns "YES". 
-- Otherwise, it returns "NO".
-- first computes the number of even elements in lst2 and odd elements in lst1 using the filter function and the even and odd predicates. 
-- It then checks if the number of even elements in lst2 is greater than or equal to the number of odd elements in lst1. 
-- If so, it returns "YES". Otherwise, it returns "NO".
exchange :: [Int] -> [Int] -> String
exchange lst1 lst2
  | evenCount >= oddCount = "YES"
  | otherwise = "NO"
  where
    evenCount = length $ filter even lst2
    oddCount = length $ filter odd lst1
