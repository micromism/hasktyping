import Data.Array
import Data.Time
import System.IO

main = do
    hdl <- openFile "script" ReadMode
    script <- hGetContents hdl
    scores <- mapM testline (lines script)
    mapM_ putStrLn (full scores)
    putStrLn ("Total Score: " ++ (show . sum . map sc $ scores))

sc :: (Int, NominalDiffTime) -> Int
sc (dist, time) = (-1)*((dist+(truncate time))^2)

report :: (Int, NominalDiffTime) -> String
report (dist, time) = "Mistakes: " ++ (show dist) ++ "\nTime Taken: " ++ (show time) ++ "\nScore: " ++ (show (sc (dist, time)))

full :: [(Int, NominalDiffTime)] -> [String]
full = zipWith (++) (map prefixize [1..]) . map report
    where prefixize n = "Line " ++ (show n) ++ ": "

testline :: String -> IO (Int, NominalDiffTime)
testline l = do
    start <- getCurrentTime
    putStrLn l
    inp <- getLine
    end <- getCurrentTime
    return ((editDist l inp, diffUTCTime end start))


--taken from wiki
editDist :: Eq a => [a] -> [a] -> Int
editDist xs ys = table ! (m,n)
    where
    (m,n) = (length xs, length ys)
    x     = array (1,m) (zip [1..] xs)
    y     = array (1,n) (zip [1..] ys)

    table :: Array (Int,Int) Int
    table = array bnds [(ij, dist ij) | ij <- range bnds]
    bnds = ((0,0),(m,n))

    dist (0,j) = j
    dist (i,0) = i
    dist (i,j) = minimum [table ! (i-1,j) + 1, table ! (i,j-1) + 1,
        if x ! i == y ! j then table ! (i-1,j-1) else 1 + table ! (i-1, j-1)]
