module CL.CL_zipper where

import CL.Base (Base)
import CL.CL (reduction_rules)
import Data.MaybeExt (tryAndAdjustTill)
import Data.Tree2_zipper (Tree2_zipper, move, rightward, upWhenDir, leftmost, Direction(Left))
import Data.Tuple.HT (mapFst)
import Prelude hiding (Left)

type CL_zipper = Tree2_zipper Base

reduction_step, left_path_reduction_step, local_reduction_step  :: CL_zipper -> Maybe CL_zipper
reduction_step = tryAndAdjustTill left_path_reduction_step $ move rightward
left_path_reduction_step = tryAndAdjustTill local_reduction_step (upWhenDir Left) . leftmost
local_reduction_step (cl, cl_back) = do
    cl' <- reduction_rules cl
    return (cl', cl_back)
