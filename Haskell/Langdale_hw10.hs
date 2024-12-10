pyths :: Int -> [(Int,Int,Int)]

pyths n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x*x + y*y == z*z]

{-ghci> :l C:\Users\samla\Desktop\GithubStorage\Haskell\Langdalehw10.hs
[1 of 2] Compiling Main             ( C:\Users\samla\Desktop\GithubStorage\Haskell\Langdalehw10.hs, interpreted )
Ok, one module loaded.
ghci> pyths 10
[(3,4,5),(4,3,5),(6,8,10),(8,6,10)]
ghci> pyths 15
[(3,4,5),(4,3,5),(5,12,13),(6,8,10),(8,6,10),(9,12,15),(12,5,13),(12,9,15)]
ghci>
-}
factors n = [x | x <- [1..n], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (factors x)-x == x]

{-ghci> :l C:\Users\samla\Desktop\GithubStorage\Haskell\Langdalehw10.hs
[1 of 2] Compiling Main             ( C:\Users\samla\Desktop\GithubStorage\Haskell\Langdalehw10.hs, interpreted )
Ok, one module loaded.
ghci> perfects 500
[6,28,496]
ghci> perfects 10000
[6,28,496,8128]
-}

-- permutaion of 3s (leetcode problem)
permu :: Eq a => [a] -> [[a]]
permu [x,y,z] = [[a,b,c] | a <- [x, y, z], b <- [x, y, z], c <- [x, y, z], a/=b,b/=c,c/=a]

square :: Int -> Int
square x = x * x
result = map square [1, 2, 3, 4, 5]



