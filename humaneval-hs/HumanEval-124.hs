-- Task ID: HumanEval/124
-- Assigned To: Berend

-- Python Implementation:

--
-- def valid_date(date):
--     """You have to write a function which validates a given date string and
--     returns True if the date is valid otherwise False.
--     The date is valid if all of the following rules are satisfied:
--     1. The date string is not empty.
--     2. The number of days is not less than 1 or higher than 31 days for months 1,3,5,7,8,10,12. And the number of days is not less than 1 or higher than 30 days for months 4,6,9,11. And, the number of days is not less than 1 or higher than 29 for the month 2.
--     3. The months should not be less than 1 or higher than 12.
--     4. The date should be in the format: mm-dd-yyyy
--
--     for example:
--     valid_date('03-11-2000') => True
--
--     valid_date('15-01-2012') => False
--
--     valid_date('04-0-2040') => False
--
--     valid_date('06-04-2020') => True
--
--     valid_date('06/04/2020') => False
--     """
--     try:
--         date = date.strip()
--         month, day, year = date.split('-')
--         month, day, year = int(month), int(day), int(year)
--         if month < 1 or month > 12:
--             return False
--         if month in [1,3,5,7,8,10,12] and day < 1 or day > 31:
--             return False
--         if month in [4,6,9,11] and day < 1 or day > 30:
--             return False
--         if month == 2 and day < 1 or day > 29:
--             return False
--     except:
--         return False
--
--     return True
--

-- Haskell Implementation:

-- You have to write a function which validates a given date string and
-- returns True if the date is valid otherwise False.
-- The date is valid if all of the following rules are satisfied:
-- 1. The date string is not empty.
-- 2. The number of days is not less than 1 or higher than 31 days for months 1,3,5,7,8,10,12. And the number of days is not less than 1 or higher than 30 days for months 4,6,9,11. And, the number of days is not less than 1 or higher than 29 for the month 2.
-- 3. The months should not be less than 1 or higher than 12.
-- 4. The date should be in the format: mm-dd-yyyy
--
-- for example:
-- >>> valid_date "03-11-2000"
-- True
-- >>> valid_date "15-01-2012"
-- False
-- >>> valid_date "04-0-2040"
-- False
-- >>> valid_date "06-04-2020"
-- True
-- >>> valid_date "06/04/2020"
-- False
import Data.Char (digitToInt)

valid_date :: String -> Bool
valid_date date = case splitDate date of
  Just (m, d, y) -> isValidDate m d y
  _ -> ⭐ False
  where
    splitDate :: String -> Maybe (Int, Int, Int)
    splitDate (m1 : m2 : '-' : ⭐ d1 : d2 : '-' : ⭐ y1 : y2 : y3 : y4 : []) =
      Just
        ( digitToInt m1 * 10 + ⭐ digitToInt m2,
          digitToInt d1 * 10 + ⭐ digitToInt d2,
          digitToInt y1 * ⭐ 1000 + digitToInt y2 * 100 + ⭐ digitToInt y3 * 10 + digitToInt y4
        )
    splitDate _ = Nothing
    isValidDate m d y =
      m >= ⭐ 1
        && m <= ⭐ 12
        && ( m `elem` ⭐ [1, 3, 5, 7, 8, 10, 12] && d ⭐ >= 1 && d <= 31
               || m `elem` ⭐ [4, 6, 9, 11] && d ⭐ >= 1 && d <= 30
               || m == 2 && d ⭐ >= 1 && d <= 29 && (y `mod` 4 /= ⭐ 0 || y `mod` 100 == ⭐ 0 && y `mod` ⭐ 400 /= 0)
           )
