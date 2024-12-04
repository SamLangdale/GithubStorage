

add (x,y) = x+y
add2 x y = x+y
newcurry :: ((a,b) -> c) -> (a -> b -> c)
newcurry f = \x y -> f (x,y)

newuncurry :: (a -> b -> c) -> ((a,b) -> c)
newuncurry f = \(x,y) -> f x y
  {-[1 of 2] Compiling Main             ( C:\Users\samla\Desktop\GithubStorage\Haskell\Langdale_hw12.hs, interpreted )
Ok, one module loaded.
ghci> (newuncurry add2) (5,4)
9
ghci> (newcurry add) 5 4
9
ghci>
-}


altMap :: (a -> b) -> (a -> b) -> [a] -> [b] 
altMap _ _ [] = []
altMap f g (x:xs) = f x : altMap g f xs
{-ghci> 
altMap (+20) (+1) [1,2,3,4,5]
[21,3,23,5,25]
ghci> altMap (+20) (+40) [1,2,3,4,5,4,5,6]
[21,42,23,44,25,44,25,46]
ghci>-}