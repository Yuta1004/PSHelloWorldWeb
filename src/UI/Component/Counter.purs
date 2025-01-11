module UI.Component.Counter (counter) where

import Halogen (Component, mkComponent)

import UI.Component.Counter.Eval (eval)
import UI.Component.Counter.View (render)
import UI.Component.Counter.State (initialState)

counter ∷ forall q i o m. Component q i o m
counter = mkComponent { initialState, eval, render }
