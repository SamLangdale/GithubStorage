
euclid :: Int -> Int -> Int

euclid 0 _ = 0
euclid _ 0 = 0
euclid x y | x == y = x
           | x > y = euclid (x-y) y
           | otherwise = euclid (y-x) x

{-ghci> :l C:\Users\samla\Desktop\GithubStorage\Haskell\langdale_hw11.hs
[1 of 2] Compiling Main             ( C:\Users\samla\Desktop\GithubStorage\Haskell\langdale_hw11.hs, interpreted )
Ok, one module loaded.
ghci> euclid 6 27
3
ghci> euclid 6 21
3
ghci> euclid 81 18
9
ghci> euclid 11 40
1
ghci> euclid 0 40
0
-}

merge :: Ord a => [a] -> [a] -> [a]

merge a []  = a
merge [] a = a
merge (a:xa) (b:xb) | a <= b = a : merge xa (b:xb)
                    | a > b = b : merge xb (a:xa)

{-ghci> :l C:\Users\samla\Desktop\GithubStorage\Haskell\langdale_hw11.hs
[1 of 2] Compiling Main             ( C:\Users\samla\Desktop\GithubStorage\Haskell\langdale_hw11.hs, interpreted )
Ok, one module loaded.
ghci> merge [1,3,5] [2,4,6]
[1,2,3,4,5,6]
ghci> merge [1,3,5,9,10] [2,4,6,7,8]
[1,2,3,4,5,6,7,8,9,10]
ghci> merge [1,4,5] [3,6,8]
[1,3,4,5,6,8]
ghci>
-}
halve :: [a] -> ([a],[a])
halve x = splitAt (length x `div` 2) x



msort :: Ord a => [a] -> [a]

msort [] = []
msort [a] = [a]
msort a = merge (msort c) (msort d)
    where
        (c,d) = halve a

{-
ghci> :l C:\Users\samla\Desktop\GithubStorage\Haskell\langdale_hw11.hs
[1 of 2] Compiling Main             ( C:\Users\samla\Desktop\GithubStorage\Haskell\langdale_hw11.hs, interpreted )
Ok, one module loaded.
ghci> msort [1,3,5,2,4,6]
[1,2,3,4,5,6]
ghci> msort [1,3,5,2,4,6,8,5,4]
[1,2,3,4,4,5,5,6,8]
ghci> msort [1,3,5,2,4,6,1,7,6,5]
[1,1,2,3,4,5,5,6,6,7]
ghci>
-}


