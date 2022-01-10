module CL.CL where

import Data.Tree2
import CL.Base

type CL = Tree2 Base

(<@>) :: CL -> CL -> CL
(<@>) = Branch
infixl 7 <@>

lit :: Base -> CL
lit = Leaf

s, k :: CL
s = Leaf S
k = Leaf K

reduction_rules :: CL -> Maybe CL
reduction_rules (Branch (Branch (Leaf K            ) f) _) = Just f
reduction_rules (Branch (Branch (Branch (Leaf S) k ) f) x) = Just $ Branch (Branch k x) (Branch f x)
reduction_rules _                                          = Nothing
