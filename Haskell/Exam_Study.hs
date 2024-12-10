fact n = product [1..n]

fact' 0 = 1
fact' n = n * fact' (n-1)
fact2 n | n > 0  = n * fact2 (n-1)
        | otherwise = 1

length' [] = 0
length'(_:xs) = 1 + length' xs

length'' :: [a] -> Int
length'' = foldr (\_ n -> 1 + n) 0


lengthnew :: [a] -> Int
lengthnew = foldr (\_ n -> 1 + n) 0

len2 :: (Foldable t1, Foldable t2, Num a1, Num (t1 a1),  Num (t1 a1 -> t1 a1)) => t2 a2 -> a1
len2 x = sum (foldr (\x -> 1) 0 x)