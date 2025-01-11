module Component.Counter (counter) where

import Halogen (Component, mkComponent)

import Component.Counter.Eval (eval)
import Component.Counter.View (render)
import Component.Counter.State (initialState)

counter ∷ forall q i o m. Component q i o m
counter = mkComponent { initialState, eval, render }
