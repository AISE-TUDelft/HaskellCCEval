-- Task ID: HumanEval/21
-- Assigned To: Author A

-- Python Implementation:

-- from typing import List
-- 
-- 
-- def rescale_to_unit(numbers: List[float]) -> List[float]:
--     """ Given list of numbers (of at least two elements), apply a linear transform to that list,
--     such that the smallest number will become 0 and the largest will become 1
--     >>> rescale_to_unit([1.0, 2.0, 3.0, 4.0, 5.0])
--     [0.0, 0.25, 0.5, 0.75, 1.0]
--     """
--     min_number = min(numbers)
--     max_number = max(numbers)
--     return [(x - min_number) / (max_number - min_number) for x in numbers]
-- 


-- Haskell Implementation:

-- Given list of numbers (of at least two elements), apply a linear transform to that list,
-- such that the smallest number will become 0 and the largest will become 1
-- >>> rescale_to_unit [1.0, 2.0, 3.0, 4.0, 5.0]
-- [0.0,0.25,0.5,0.75,1.0]
rescale_to_unit :: [Float] -> [Float]
rescale_to_unit numbers = map ⭐ (\x -> ⭐ (x - min_number) / ⭐ (max_number - min_number)) ⭐ numbers
    where min_number = ⭐ minimum numbers
          max_number = ⭐ maximum numbers
