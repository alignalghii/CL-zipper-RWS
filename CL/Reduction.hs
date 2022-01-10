module CL.Reduction where

import CL.CL (CL)
import CL.CL_zipper (reduction_step_trace)
import Data.Tree2_zipper (startZipper, forgetZipper)
import Control.Transform (MaybeTransform)

reduction_step :: MaybeTransform CL
reduction_step = fmap forgetZipper . reduction_step_trace . startZipper
