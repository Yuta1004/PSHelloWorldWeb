module UI.Component.Counter.State (State, initialState) where

import Counter.Counter (Counter, mkCounter)

type State = { counter :: Counter }

initialState :: forall a. a -> State
initialState _ = { counter: mkCounter 0 }
