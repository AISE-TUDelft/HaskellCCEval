-- Task ID: HumanEval/17
-- Assigned To: Tim

-- Python Implementation:

-- from typing import List
-- 
-- 
-- def parse_music(music_string: str) -> List[int]:
--     """ Input to this function is a string representing musical notes in a special ASCII format.
--     Your task is to parse this string and return list of integers corresponding to how many beats does each
--     not last.
-- 
--     Here is a legend:
--     'o' - whole note, lasts four beats
--     'o|' - half note, lasts two beats
--     '.|' - quater note, lasts one beat
-- 
--     >>> parse_music('o o| .| o| o| .| .| .| .| o o')
--     [4, 2, 1, 2, 2, 1, 1, 1, 1, 4, 4]
--     """
--     note_map = {'o': 4, 'o|': 2, '.|': 1}
--     return [note_map[x] for x in music_string.split(' ') if x]
-- 


-- Haskell Implementation:

-- Input to this function is a string representing musical notes in a special ASCII format.
-- Your task is to parse this string and return list of integers corresponding to how many beats does each
-- not last.
--
-- Here is a legend:
-- 'o' - whole note, lasts four beats
-- 'o|' - half note, lasts two beats
-- '.|' - quater note, lasts one beat
--
-- >>> parse_music "o o| .| o| o| .| .| .| .| o o"
-- [4, 2, 1, 2, 2, 1, 1, 1, 1, 4, 4]
parse_music :: String -> [Int]
parse_music music_string = [note_map x | x <- words music_string]
    where note_map "o" = 4
          note_map "o|" = 2
          note_map ".|" = 1
