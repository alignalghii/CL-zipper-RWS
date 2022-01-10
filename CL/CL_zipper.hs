module CL.CL_zipper where

import CL.Base (Base)
import CL.CL (reduction_rules)
import Data.Direction (Direction (..))
import Control.Transform (FlaggedTransform, MaybeTransform, (?=>))
import Control.Monad ((>=>))
import Control.Applicative ((<|>))
import Data.Tree2_zipper (Tree2_zipper, move, leftward, rightward, upWhenDir, leftmost, toSiblingDir)
import Data.Tuple.HT (mapFst)
import Prelude hiding (Left, Right)

type CL_zipper = Tree2_zipper Base

reduction_step_trace :: MaybeTransform CL_zipper
reduction_step_trace = functionLine ?=> (jumpToArgs >=> argumentsLine)

functionLine :: FlaggedTransform CL_zipper
functionLine zipper@(cl, backsteps) = case reduction_rules cl of
    Just cl' -> (True, (cl', backsteps))
    Nothing  -> case move leftward zipper of
        Nothing      -> (False, zipper)
        Just zipper' -> functionLine zipper'

argumentsLine :: MaybeTransform CL_zipper
argumentsLine zipper = reduction_step_trace zipper <|> (nextArg >=> argumentsLine) zipper

jumpToArgs, nextArg :: MaybeTransform CL_zipper
jumpToArgs = toSiblingDir Right
nextArg    = upWhenDir Right >=> upWhenDir Left >=> move rightward
