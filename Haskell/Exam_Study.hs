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


len2 x = foldr (\_ n -> n+1) 0 x

reverse :: [a] -> [a]
reverse = foldr (\ x xs -> xs ++ [x]) [] 

reverse2 x = foldr(\a as -> as ++ [a]) [] x

