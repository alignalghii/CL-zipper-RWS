module Data.Tree2_zipper where

import Data.Tree2
import Data.MaybeExt (iterateMaybe)
import Data.Maybe.HT (toMaybe)
import Data.Tuple.HT (mapFst)
import Control.Monad ((>=>))
import Prelude hiding (Left, Right)

data Direction = Left | Right deriving Eq

type TreeMovementDirection = Maybe Direction -- `Nothing` means upward

leftward, rightward, upward :: TreeMovementDirection
leftward  = Just Left
rightward = Just Right
upward    = Nothing 

type Tree2_back a = [(Direction, Tree2 a)]

type Tree2_zipper a = (Tree2 a, Tree2_back a)

move :: TreeMovementDirection -> Tree2_zipper a -> Maybe (Tree2_zipper a)
move Nothing      zipper                                      = fmap snd $ up zipper
move (Just _    ) (Leaf _                        , _        ) = Nothing
move (Just Left ) (Branch leftChild rightChild   , backsteps) = Just (leftChild, (Left , rightChild) : backsteps)
move (Just Right) (Branch leftChild rightChild   , backsteps) = Just (leftChild, (Right, leftChild ) : backsteps)

most :: TreeMovementDirection -> Tree2_zipper a -> Tree2_zipper a
most = iterateMaybe . move

leftmost, topmost :: Tree2_zipper a -> Tree2_zipper a
leftmost = most leftward
topmost  = most upward

up :: Tree2_zipper a -> Maybe (Direction, Tree2_zipper a)
up z@(_    , []                               ) = Nothing
up   (tree2, (Left , rightSibling) : backsteps) = Just (Left , (Branch tree2 rightSibling, backsteps))
up z@(tree2, (Right, leftSibling ) : backsteps) = Just (Right, (Branch leftSibling  tree2, backsteps))

upWhileDir :: Direction -> Tree2_zipper a -> Tree2_zipper a
upWhileDir = iterateMaybe . upWhenDir

upWhenDir :: Direction -> Tree2_zipper a -> Maybe (Tree2_zipper a)
upWhenDir dir =  up >=> (uncurry toMaybe . mapFst (== dir))
