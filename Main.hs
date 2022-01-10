module Main where

import CmbLogic.Term ((<@>), s, k)
import CmbLogic.Samples (i, b, c)
import CmbLogic.Reduction (reduction_step)
import CmbLogic.Reduction.Strategy (reduction_strategy_step, functionLine, jumpToArgs)
import Data.Tree2_zipper (startZipper, move, leftward)
import Control.Transform ((?=>))
import Control.Monad ((>=>))

main :: IO ()
main = do
    print i
    print b
    print c
    print $ reduction_step (i <@> k)
    print $ (reduction_step >=> reduction_step) (i <@> k)
    print $ (reduction_step >=> reduction_step) (i <@> s)
    print $ (reduction_step >=> reduction_step) (i <@> i)
    putStrLn ""
    putStrLn "B I I K"
    print $ (reduction_step >=> reduction_step) (b <@> i <@> i <@> k)
    print $ (reduction_step >=> reduction_step >=> reduction_step) (b <@> i <@> i <@> k)
    print $ (reduction_step >=> reduction_step >=> reduction_step >=> reduction_step) (b <@> i <@> i <@> k)
    print $ (reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step) (b <@> i <@> i <@> k)
    print $ (reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step) (b <@> i <@> i <@> k)
    print $ (reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step) (b <@> i <@> i <@> k)
    print $ (reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step) (b <@> i <@> i <@> k)
    print $ (reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step) (b <@> i <@> i <@> k)
    putStrLn ""
    print $ (reduction_step >=> reduction_step) (s <@> (i <@> k))
    print $ (reduction_step >=> reduction_step >=> reduction_step)(s <@> (i <@> k))
    print $ (reduction_step >=> reduction_step >=> reduction_step >=> reduction_step)(s <@> (i <@> k))
    print $ (reduction_step >=> reduction_step >=> reduction_step >=> reduction_step >=> reduction_step)(s <@> (i <@> k))
    putStrLn ""
    putStrLn ""
    putStrLn ""
    print $ Just $ startZipper (i <@> k)
    print $ reduction_strategy_step $ startZipper (i <@> k)
    print $ reduction_strategy_step >=> reduction_strategy_step $ startZipper (i <@> k)
    putStrLn ""
    print $ Just $ startZipper (s <@> (i <@> k))
    print $ reduction_strategy_step $ startZipper (s <@> (i <@> k))
    print $ reduction_strategy_step >=> reduction_strategy_step $ startZipper (s <@> (i <@> k))
    putStrLn ""
    print $ move leftward $ startZipper (s <@> (i <@> k))
    print $ functionLine $ startZipper (s <@> (i <@> k))
    print $ functionLine ?=> jumpToArgs $ startZipper (s <@> (i <@> k))
