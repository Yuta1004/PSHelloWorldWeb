module Main where

import Prelude

import Effect (Effect)
import Halogen (HalogenM, Component, defaultEval, mkComponent, mkEval, modify_)
import Halogen.Aff (awaitBody, runHalogenAff)
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.VDom.Driver (runUI)

main :: Effect Unit
main = runHalogenAff do
    body <- awaitBody
    runUI component unit body

component :: forall q i o m. Component q i o m
component = mkComponent
    { initialState: \_ -> mkCounter 0
    , render: renderCounter
    , eval: mkEval $ defaultEval { handleAction = handleAction }
    }

type CounterState = { value :: Int }

data CounterAction = Increment | Decrement

mkCounter :: Int -> CounterState
mkCounter value = { value }

renderCounter :: forall w. CounterState -> HH.HTML w CounterAction
renderCounter state = HH.div_
    [ HH.p_ [ HH.text "Counter" ]
    , HH.p_
        [ HH.text $ "value: " <> show state.value
        , HH.button
            [ HE.onClick \_ -> Increment ]
            [ HH.text "+" ]
        , HH.button
            [ HE.onClick \_ -> Decrement ]
            [ HH.text "-" ]
        ]
    ]

handleAction :: forall o m. CounterAction -> HalogenM CounterState CounterAction () o m Unit
handleAction = case _ of
    Increment -> modify_ \counter -> counter { value = counter.value + 1 }
    Decrement -> modify_ \counter -> counter { value = counter.value - 1 }
