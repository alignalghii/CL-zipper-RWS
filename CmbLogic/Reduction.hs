module CmbLogic.Reduction where

import CmbLogic.Term (CL)
import CmbLogic.Reduction.Strategy (reduction_strategy_step)
import Data.Tree2_zipper (startZipper, forgetZipper)
import Control.Transform (MaybeTransform)

reduction_step :: MaybeTransform CL
reduction_step = fmap forgetZipper . reduction_strategy_step . startZipper
