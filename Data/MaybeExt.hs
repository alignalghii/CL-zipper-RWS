module Data.MaybeExt where

-- Example: iterateMaybe (\i -> if i `mod` 2 /= 0 then Nothing else Just (i `div` 2)) 120 ----> 15

iterateMaybe :: (a -> Maybe a) -> a -> a
iterateMaybe f a = maybe a (iterateMaybe f) (f a)

tryAndAdjustTill :: (a -> Maybe a) -> (a -> Maybe a) -> a -> Maybe a
tryAndAdjustTill try adjust a = maybe (adjust a >>= tryAndAdjustTill try adjust) Just (try a)
