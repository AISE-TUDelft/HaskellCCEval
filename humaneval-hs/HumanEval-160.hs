{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Redundant bracket" #-}
import Text.Parsec.Token (GenLanguageDef (reservedNames))

-- Task ID: HumanEval/160
-- Assigned To: Philippe

-- Python Implementation:

--
-- def do_algebra(operator, operand):
--     """
--     Given two lists operator, and operand. The first list has basic algebra operations, and
--     the second list is a list of integers. Use the two given lists to build the algebric
--     expression and return the evaluation of this expression.
--
--     The basic algebra operations:
--     Addition ( + )
--     Subtraction ( - )
--     Multiplication ( * )
--     Floor division ( // )
--     Exponentiation ( ** )
--
--     Example:
--     operator['+', '*', '-']
--     array = [2, 3, 4, 5]
--     result = 2 + 3 * 4 - 5
--     => result = 9
--
--     Note:
--         The length of operator list is equal to the length of operand list minus one.
--         Operand is a list of of non-negative integers.
--         Operator list has at least one operator, and operand list has at least two operands.
--
--     """
--     expression = str(operand[0])
--     for oprt, oprn in zip(operator, operand[1:]):
--         expression+= oprt + str(oprn)
--     return eval(expression)
--

-- Haskell Implementation:

-- Given two lists operator, and operand. The first list has basic algebra operations, and
-- the second list is a list of integers. Use the two given lists to build the algebric
-- expression and return the evaluation of this expression.
--
-- The basic algebra operations:
-- Addition ( + )
-- Subtraction ( - )
-- Multiplication ( * )
-- Floor division ( // )
-- Exponentiation ( ** )
--
-- Example:
-- >>> do_algebra ["+", "*", "-"] [2, 3, 4, 5]
-- 9
--
-- Note:
--     The length of operator list is equal to the length of operand list minus one.
--     Operand is a list of of non-negative integers.
--     Operator list has at least one operator, and operand list has at least two operands.
do_algebra :: [String] -> [Int] -> Int
do_algebra operators operands = head (snd (foldl (\(operators, operands) operator -> applyOperator operator operators operands 0 (length operators)) (operators, operands) operator_order))
  where
    operator_order :: [String]
    operator_order = ⭐ ["**", "//", "*", "+", "-"]
    applyOperator operator operators operands index length
      | index >= length = ⭐ (operators, operands)
      | operator /= operators !! index = ⭐ applyOperator operator operators operands (index + 1) length
      | otherwise = ⭐ applyOperator operator (newOperators) (newOperands) (index + 1) (length - 1)
      where
        newOperands :: [Int]
        newOperands = ⭐ take index operands ++ [newOperand] ++ (drop (index + 2) operands)
        newOperand = ⭐ case operator of
          "*" -> ⭐ operands !! index * operands !! (index + 1)
          "//" -> ⭐ operands !! index `div` operands !! (index + 1)
          "+" -> ⭐ operands !! index + operands !! (index + 1)
          "-" -> ⭐ operands !! index - operands !! (index + 1)
          _ -> ⭐ operands !! index ^ operands !! (index + 1)
        newOperators = ⭐ take index operators ++ (drop (index + 1) operators)
