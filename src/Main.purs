module Main where

import Prelude

import Effect (Effect)

import Halogen (Component, defaultEval, mkComponent, mkEval)
import Halogen.Aff (awaitBody, runHalogenAff)
import Halogen.HTML as HH
import Halogen.VDom.Driver (runUI)

main :: Effect Unit
main = runHalogenAff do
    body <- awaitBody
    runUI component unit body

component :: forall q i o m. Component q i o m
component = mkComponent
    { initialState: \_ -> unit
    , render: \_ -> HH.div_ [ HH.text "Hello Halogen!" ]
    , eval: mkEval $ defaultEval
    }
