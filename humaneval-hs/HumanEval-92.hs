-- Task ID: HumanEval/92
-- Assigned To: Marc

-- Python Implementation:

-- 
-- def any_int(x, y, z):
--     '''
--     Create a function that takes 3 numbers.
--     Returns true if one of the numbers is equal to the sum of the other two, and all numbers are integers.
--     Returns false in any other cases.
--     
--     Examples
--     any_int(5, 2, 7) ➞ True
--     
--     any_int(3, 2, 2) ➞ False
-- 
--     any_int(3, -2, 1) ➞ True
--     
--     any_int(3.6, -2.2, 2) ➞ False
--   
-- 
--     
--     '''
--     
--     if isinstance(x,int) and isinstance(y,int) and isinstance(z,int):
--         if (x+y==z) or (x+z==y) or (y+z==x):
--             return True
--         return False
--     return False
-- 


-- Haskell Implementation:
import Data.Typeable

-- Create a function that takes 3 numbers.
-- Returns true if one of the numbers is equal to the sum of the other two, and all numbers are integers.
-- Returns false in any other cases.
--
-- Examples
-- any_int 5 2 7 => True
--
-- any_int 3 2 2 => False
--
-- any_int 3 (-2) 1 => True
--
-- any_int 3.6 (-2.2) 2 => False

any_int :: Float -> Float -> Float -> Bool
any_int x y z = isInt x && isInt y && isInt z && (x + y == z || x + z == y || y + z == x)
    where
        isInt a = a == fromInteger (round a)
