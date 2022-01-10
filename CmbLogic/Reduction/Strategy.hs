module CmbLogic.Reduction.Strategy where

import CmbLogic.Reduction.Rules (reduction_rules)
import CmbLogic.Zipper (CL_zipper)
import Data.Direction (left, right)
import Control.Transform (FlaggedTransform, MaybeTransform, (?=>))
import Control.Monad ((>=>))
import Control.Applicative ((<|>))
import Data.Tree2_zipper (Tree2_zipper, move, leftward, rightward, upWhenDir, toSiblingDir)
import Prelude hiding (Left, Right)


reduction_strategy_step :: MaybeTransform CL_zipper
reduction_strategy_step = functionLine ?=> (jumpToArgs >=> argumentsLine)

functionLine :: FlaggedTransform CL_zipper
functionLine zipper@(cl, backsteps) = case reduction_rules cl of
    Just cl' -> (True, (cl', backsteps))
    Nothing  -> case move leftward zipper of
        Nothing      -> (False, zipper)
        Just zipper' -> functionLine zipper'

argumentsLine :: MaybeTransform CL_zipper
argumentsLine zipper = reduction_strategy_step zipper <|> (nextArg >=> argumentsLine) zipper

jumpToArgs, nextArg :: MaybeTransform CL_zipper
jumpToArgs = toSiblingDir right
nextArg    = upWhenDir right >=> upWhenDir left >=> move rightward
