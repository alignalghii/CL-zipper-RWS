module CmbLogic.Term where

import Data.Tree2
import CmbLogic.Base

type CL = Tree2 Base

(<@>) :: CL -> CL -> CL
(<@>) = Branch
infixl 7 <@>

lit :: Base -> CL
lit = Leaf

s, k :: CL
s = Leaf S
k = Leaf K
