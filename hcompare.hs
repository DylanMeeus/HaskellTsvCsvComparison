import Data.List
import System.IO
import System.Environment
import Text.Regex

-- Reads a combination of TSV, or CSV files, and pushes the output in the chosen file.

tabRegex :: Regex
tabRegex = mkRegex "\t"

commaRegex :: Regex
commaRegex = mkRegex ","


lineToList :: String -> Regex -> [String]
lineToList input regex = splitRegex regex input

findSetTheoreticDifference :: [String] -> [String] -> [String]
findSetTheoreticDifference a b = a \\ b

process :: [String] -> IO()
process ["tsv",file1,file2,outputFile] = do
                                aContent <- readFile file1
                                bContent <- readFile file2
                                let difference = findSetTheoreticDifference (lineToList aContent tabRegex) (lineToList bContent tabRegex)
                                mapM_ (\x -> appendFile outputFile (x++"\n")) difference
                                putStrLn "Done!"

process ["csv",file1,file2, outputFile] = do
                                aContent <- readFile file1
                                bContent <- readFile file2
                                let difference = findSetTheoreticDifference (lineToList aContent commaRegex) (lineToList bContent commaRegex)
                                putStrLn (show $ length difference)
                                mapM_ (\x -> appendFile outputFile (x++"\n")) difference
                                putStrLn "Done!"

process _ = putStrLn "Use command like: [tsv/csv] input1 input2 result"

main =  do
        delim <- getArgs
        process delim