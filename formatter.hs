-- file to format splunk data





filterGrid :: [String] -> [String]
filterGrid input = [takeWhile(\y -> y /= ',') x | x <- input]
main = do
        aContent <- readFile "used_grids_3m.csv"
        let res = filterGrid $ lines aContent
        mapM_ (\x -> appendFile "test.csv" (x++"\n")) res
        putStrLn "Done"
