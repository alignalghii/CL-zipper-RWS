module CmbLogic.Reduction.Rules where

import CmbLogic.Term (CL)
import CmbLogic.Base (Base (K, S))
import Data.Tree2 (Tree2 (Leaf, Branch))
import Control.Transform (MaybeTransform)


reduction_rules :: MaybeTransform CL
reduction_rules (Branch (Branch (Leaf K            ) f) _) = Just f
reduction_rules (Branch (Branch (Branch (Leaf S) k ) f) x) = Just $ Branch (Branch k x) (Branch f x)
reduction_rules _                                          = Nothing
