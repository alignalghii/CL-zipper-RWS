module CL.Samples where

import CL.CL
import Control.Transform

k_, dly :: Transform CL
k_  = (<@>) k
dly = (<@>) b

i, b, c :: CL
i = s <@> k <@> k
b = s <@> k_ s <@> k
c = s <@> (s <@> k_ b <@> s) <@> (k_ k)
