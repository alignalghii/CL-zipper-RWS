module Data.Tree2_zipper where

import Data.Tree2
import Data.Direction
import Data.Maybe.HT (toMaybe)
import Control.Arrow (first)  -- Data.Tuple.HT (mapFst)
import Control.Monad ((>=>))
import Control.Transform (Transform, MaybeTransform, iterateMaybe)
import Prelude hiding (Left, Right)

type ZipperMovement = Maybe Direction -- `Nothing` means upward

leftward, rightward, upward :: ZipperMovement
leftward  = Just Left
rightward = Just Right
upward    = Nothing 

type Tree2_back a = [(Direction, Tree2 a)]

type Tree2_zipper a = (Tree2 a, Tree2_back a)

startZipper :: Tree2 a -> Tree2_zipper a
startZipper = flip (,) []

forgetZipper :: Tree2_zipper a -> Tree2 a
forgetZipper = fst . topmost

move :: ZipperMovement -> MaybeTransform (Tree2_zipper a)
move Nothing      zipper                                      = fmap snd $ up zipper
move (Just _    ) (Leaf _                        , _        ) = Nothing
move (Just Left ) (Branch leftChild rightChild   , backsteps) = Just (leftChild , (Left , rightChild) : backsteps)
move (Just Right) (Branch leftChild rightChild   , backsteps) = Just (rightChild, (Right, leftChild ) : backsteps)

most :: ZipperMovement -> Transform (Tree2_zipper a)
most = iterateMaybe . move

leftmost, topmost :: Transform (Tree2_zipper a)
leftmost = most leftward
topmost  = most upward

up :: Tree2_zipper a -> Maybe (Direction, Tree2_zipper a)
up z@(_    , []                               ) = Nothing
up   (tree2, (Left , rightSibling) : backsteps) = Just (Left , (Branch tree2 rightSibling, backsteps))
up z@(tree2, (Right, leftSibling ) : backsteps) = Just (Right, (Branch leftSibling  tree2, backsteps))

upWhileDir :: Direction -> Transform (Tree2_zipper a)
upWhileDir = iterateMaybe . upWhenDir

upWhenDir :: Direction -> MaybeTransform (Tree2_zipper a)
upWhenDir dir =  up >=> (uncurry toMaybe . first (== dir))  -- we use `first` here as `mapFst`

toSiblingDir :: Direction -> MaybeTransform (Tree2_zipper a)
toSiblingDir dir = upWhenDir (oppositeDir dir) >=> move (Just dir)

toSibling :: MaybeTransform (Tree2_zipper a)
toSibling zipper = do
    (dir, parent) <- up zipper
    move (Just $ oppositeDir dir) parent
