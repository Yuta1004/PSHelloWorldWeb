module Component.Counter.Eval (Action(..), eval) where

import Prelude

import Halogen (HalogenM, HalogenQ, mkEval, defaultEval, modify_)

import Component.Counter.Model (incr, decr)
import Component.Counter.State (State)

eval :: forall q i o m a. HalogenQ q Action i a -> HalogenM State Action () o m a
eval = mkEval $ defaultEval { handleAction = handleAction }

data Action = Increment | Decrement

handleAction :: forall o m. Action -> HalogenM State Action () o m Unit
handleAction = case _ of
    Increment -> modify_ \s -> { counter: incr s.counter }
    Decrement -> modify_ \s -> { counter: decr s.counter }
