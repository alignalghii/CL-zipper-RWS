module Control.Transform where

import Data.Bool
import Data.Tuple.HT (mapFst)
import Control.Monad ((>=>))

type Transform a       = a -> a
type MaybeTransform a  = a -> Maybe a
type FlaggedTransform a = a -> Flagged a

type Flagged a = (Bool, a)


iterateMaybe :: MaybeTransform a -> Transform a
iterateMaybe f a = maybe a (iterateMaybe f) (f a)

-- Example: iterateMaybe (\i -> if i `mod` 2 /= 0 then Nothing else Just (i `div` 2)) 120 ----> 15. @TODO: turn this into a test/spec


tryAndAdjustTill :: MaybeTransform a -> MaybeTransform a -> MaybeTransform a
tryAndAdjustTill try adjust a = maybe (adjust a >>= tryAndAdjustTill try adjust) Just (try a)

(?=>) :: FlaggedTransform a -> MaybeTransform a -> MaybeTransform a
flaggedTr ?=> maybeTr = uncurry id . mapFst (bool maybeTr Just) . flaggedTr

repeatKleisli :: Int -> Transform (MaybeTransform a)  --  Int -> MaybeTransform a -> MaybeTransform a
repeatKleisli n = foldr (>=>) return . replicate n
