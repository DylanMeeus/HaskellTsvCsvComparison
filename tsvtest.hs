import Data.List
import System.IO
import System.Environment
import Text.Regex
-- read out a tsv file
-- store the result in a list of strings

tabRegex :: Regex
tabRegex = mkRegex "\t"

commaRegex :: Regex
commaRegex = mkRegex ","


lineToList :: String -> [String]
lineToList input = splitRegex tabRegex input

findUnusedGrids :: String -> String -> [String]
findUnusedGrids grids used = u \\ s
        where u = lineToList grids
              s = lineToList used


process :: [String] -> String
process ["tsv",file1,file2] = "tsv" ++ file1 ++ file2
process ["csv",file1,file2] = "csv "++ file1 ++ file2
process _ = "Use command like: [tsv/csv] file1 file2"


main = do
        delim <- getArgs
        putStrLn (process delim)
        accessed <- readFile "accessed_grids.txt"
        grids <- readFile "all_grids.txt"
        let unused = findUnusedGrids grids accessed
        mapM_ putStrLn unused