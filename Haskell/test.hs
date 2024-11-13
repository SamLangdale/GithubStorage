
n :: Int
n =  a `div`  length xs
    where
        a = 10
        xs = [1,2,3,4,5]



newlast :: [int] -> int
newlast x = head (reverse x)

init1 :: [int] -> [int] 
init1 x = take (length x -1) x

init2 :: [int] -> [int]
init2 x = reverse (tail (reverse x))