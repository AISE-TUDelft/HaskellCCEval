-- Task ID: HumanEval/157
-- Assigned To: Author B

-- Python Implementation:

--
-- def right_angle_triangle(a, b, c):
--     '''
--     Given the lengths of the three sides of a triangle. Return True if the three
--     sides form a right-angled triangle, False otherwise.
--     A right-angled triangle is a triangle in which one angle is right angle or
--     90 degree.
--     Example:
--     right_angle_triangle(3, 4, 5) == True
--     right_angle_triangle(1, 2, 3) == False
--     '''
--     return a*a == b*b + c*c or b*b == a*a + c*c or c*c == a*a + b*b
--

-- Haskell Implementation:

-- Given the lengths of the three sides of a triangle. Return True if the three
-- sides form a right-angled triangle, False otherwise.
-- A right-angled triangle is a triangle in which one angle is right angle or
-- 90 degree.
-- Example:
-- >>> right_angle_triangle 3 4 5
-- True
-- >>> right_angle_triangle 1 2 3
-- False
right_angle_triangle :: Int -> Int -> Int -> Bool
right_angle_triangle a b c = ⭐ a * a == b * b + c * c || ⭐ b * b == a * a + c * c || ⭐ c * c == a * a + b * b
