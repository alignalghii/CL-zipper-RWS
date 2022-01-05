module CL.CL where

import Data.Tree2
import CL.Base

type CL = Tree2 Base

reduction_rules :: CL -> Maybe CL
reduction_rules (Branch (Branch (Leaf K            ) f) _) = Just f
reduction_rules (Branch (Branch (Branch (Leaf S) k ) f) x) = Just $ Branch (Branch k x) (Branch f x)
reduction_rules _                                          = Nothing
