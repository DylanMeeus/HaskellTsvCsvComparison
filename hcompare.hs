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
                                mapM_ (\x -> appendFile outputFile (x++"\n")) difference
                                putStrLn "Done: set A: " ++ length (lineToList aContent commaRegex) ++ "Lines"

process _ = putStrLn "Use command like: [tsv/csv] file1 file2"


main = do
        delim <- getArgs
        process delim