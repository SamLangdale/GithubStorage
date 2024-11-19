

luhnDouble :: Int -> Int
luhnDouble x | 2*x < 9     = 2 * x
             | otherwise   = (2*x)-9


{-
ghci> :l C:\Users\samla\Desktop\GithubStorage\Haskell\Langdale_hw9.hs
[1 of 2] Compiling Main             ( C:\Users\samla\Desktop\GithubStorage\Haskell\Langdale_hw9.hs, interpreted )
Ok, one module loaded.
ghci> luhnDouble 4
8
ghci> luhnDouble 5
1
ghci> luhnDouble 9
9
ghci> luhnDouble 3
6
ghci> luhnDouble 6
3
ghci>
-}

luhn :: Int ->Int -> Int -> Int -> Bool
luhn a b c d = mod (luhnDouble a + b + luhnDouble c + d) 10 == 0

{-
[1 of 2] Compiling Main             ( C:\Users\samla\Desktop\GithubStorage\Haskell\Langdale_hw9.hs, interpreted )
Ok, one module loaded.
ghci> luhn 1 2 3 4
False
ghci> luhn 1 7 8 4
True
ghci> luhn 2 7 8 3
False
ghci> luhn 1 9 3 2
False
ghci> luhn 1 9 3 3
True
 -}




