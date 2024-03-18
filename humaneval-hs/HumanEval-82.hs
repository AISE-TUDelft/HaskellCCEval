-- Task ID: HumanEval/82
-- Assigned To: Author E

-- Python Implementation:

-- 
-- def prime_length(string):
--     """Write a function that takes a string and returns True if the string
--     length is a prime number or False otherwise
--     Examples
--     prime_length('Hello') == True
--     prime_length('abcdcba') == True
--     prime_length('kittens') == True
--     prime_length('orange') == False
--     """
--     l = len(string)
--     if l == 0 or l == 1:
--         return False
--     for i in range(2, l):
--         if l % i == 0:
--             return False
--     return True
-- 


-- Haskell Implementation:

-- Write a function that takes a string and returns True if the string
-- length is a prime number or False otherwise
-- Examples
-- prime_length "Hello" == True
-- prime_length "abcdcba" == True
-- prime_length "kittens" == True
-- prime_length "orange" == False

prime_length :: String -> Bool
prime_length string = let l = ⭐ length string
                      in l /= 0 && l /= 1 && null [i | i <- ⭐ [2..(l-1)], l `mod` i == 0]
