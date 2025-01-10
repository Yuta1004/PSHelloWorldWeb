module Component.Counter (counter) where

import Prelude

import Halogen (HalogenM, Component, defaultEval, mkComponent, mkEval, modify_)
import Halogen.HTML as HH
import Halogen.HTML.Events as HE

type State = { value :: Int }

data Action = Increment | Decrement

counter :: forall q i o m. Component q i o m
counter = mkComponent
    { initialState: init
    , render: render
    , eval: mkEval $ defaultEval { handleAction = handleAction }
    }

init :: forall a. a -> State
init _  = { value: 0 }

render :: forall w. State -> HH.HTML w Action
render s = HH.div_
    [ HH.p_ [ HH.text "Counter" ]
    , HH.p_
        [ HH.text $ "value: " <> show s.value
        , HH.button
            [ HE.onClick \_ -> Increment ]
            [ HH.text "+" ]
        , HH.button
            [ HE.onClick \_ -> Decrement ]
            [ HH.text "-" ]
        ]
    ]

handleAction :: forall o m. Action -> HalogenM State Action () o m Unit
handleAction = case _ of
    Increment -> modify_ \s -> s { value = s.value + 1 }
    Decrement -> modify_ \s -> s { value = s.value - 1 }
