module Main where

import Test.Hspec

import CmbLogic.Term ((<@>), s, k)
import CmbLogic.Samples (i, b, c)
import CmbLogic.Reduction (reduction_step)
import CmbLogic.Reduction.Strategy (reduction_strategy_step, functionLine, jumpToArgs)
import Data.Tree2_zipper (startZipper, move, leftward)
import Data.Direction (left, right)
import Control.Transform (repeatKleisli, (?=>))
import Control.Monad ((>=>))

main :: IO ()
main = hspec $ do
    describe "reduction_step" $ do
        it "should feature I as an identity combinator" $ do
            let withCombinator x = do
                repeatKleisli 1 reduction_step (i <@> x) `shouldBe` Just (k <@> x <@> (k <@> x))
                repeatKleisli 2 reduction_step (i <@> x) `shouldBe` Just x
                repeatKleisli 3 reduction_step (i <@> x) `shouldBe` Nothing
            mapM_ withCombinator [k, s, i, b, c]
        it "should feature B as a composition combinator" $ do
            let withCombinator x = do
                repeatKleisli 8 reduction_step (b <@> i <@> i <@> x) `shouldBe` Just x
                repeatKleisli 9 reduction_step (b <@> i <@> i <@> x) `shouldBe` Nothing
            mapM_ withCombinator [k, s, i, b, c]
        it "should keep S's first argument strict if it is its only arg" $ do
            let withCombinator x = do
                repeatKleisli 2 reduction_step (s <@> (i <@> x)) `shouldBe` Just (s <@> x)
            mapM_ withCombinator [s, k, i, b, c]
    describe "reduction_strategy_step" $ do
        it "should follow the function line" $ do
            let withCombinator x = do
                repeatKleisli 0 reduction_strategy_step (i <@> x, []) `shouldBe` Just (s <@> k <@> k <@> x, [])
                repeatKleisli 1 reduction_strategy_step (i <@> x, []) `shouldBe` Just (k <@> x <@> (k <@> x), [])
                repeatKleisli 2 reduction_strategy_step (i <@> x, []) `shouldBe` Just (x, [])
                repeatKleisli 3 reduction_strategy_step (i <@> x, []) `shouldBe` Nothing
            mapM_ withCombinator [s, k, i, b, c]
        it "should follow the arguments line" $ do
            let withCombinator x = do
                repeatKleisli 0 reduction_strategy_step (s <@> (i <@> x), []) `shouldBe` Just (s <@> (i <@> x), [])
                repeatKleisli 1 reduction_strategy_step (s <@> (i <@> x), []) `shouldBe` Just (k <@> x <@> (k <@> x), [(right, s)])
                repeatKleisli 2 reduction_strategy_step (s <@> (i <@> x), []) `shouldBe` Just (x, [(right, s)])
                repeatKleisli 3 reduction_strategy_step (s <@> (i <@> x), []) `shouldBe` Nothing
            mapM_ withCombinator [s, k, i, b, c]
        it "should move consistently when jumping to the arguments line" $ do
            let withCombinator x = do
                move leftward                 (s <@> (i <@> x), []) `shouldBe` Just    (s      , [(left , i <@> x)])
                functionLine                  (s <@> (i <@> x), []) `shouldBe` (False, (s      , [(left , i <@> x)]))
                (functionLine ?=> jumpToArgs) (s <@> (i <@> x), []) `shouldBe` Just    (i <@> x, [(right, s)])
            mapM_ withCombinator [s, k, i, b, c]
