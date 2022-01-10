module Data.Direction where

import Control.Transform (Transform)
import Prelude hiding (Either (Left, Right))

data Direction = Left | Right deriving (Enum, Eq, Show)

oppositeDir :: Transform Direction
oppositeDir = toEnum . (1 -) . fromEnum
