module CmbLogic.Samples where

import CmbLogic.Term
import Control.Transform

k_, dly :: Transform CL
k_  = (<@>) k
dly = (<@>) b

i, b, c :: CL
i = s <@> k <@> k
b = s <@> k_ s <@> k
c = s <@> (s <@> k_ b <@> s) <@> (k_ k)
