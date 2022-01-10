module Main where

import CmbLogic.CL
import CmbLogic.CL_zipper
import CmbLogic.Samples
import CmbLogic.Reduction
import Data.Tree2_zipper
import Control.Transform ((?=>))
import Control.Monad ((>=>))

import Data.Tree2_zipper (startZipper)

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
    print $ reduction_step_trace $ startZipper (i <@> k)
    print $ reduction_step_trace >=> reduction_step_trace $ startZipper (i <@> k)
    putStrLn ""
    print $ Just $ startZipper (s <@> (i <@> k))
    print $ reduction_step_trace $ startZipper (s <@> (i <@> k))
    print $ reduction_step_trace >=> reduction_step_trace $ startZipper (s <@> (i <@> k))
    putStrLn ""
    print $ move leftward $ startZipper (s <@> (i <@> k))
    print $ functionLine $ startZipper (s <@> (i <@> k))
    print $ functionLine ?=> jumpToArgs $ startZipper (s <@> (i <@> k))
