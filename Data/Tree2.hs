module Data.Tree2 where

data Tree2 a = Leaf a | Branch (Tree2 a) (Tree2 a)
