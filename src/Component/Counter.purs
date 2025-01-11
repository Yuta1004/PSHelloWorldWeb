module Component.Counter (counter) where

import Prelude

import Halogen (HalogenM, ClassName(..), Component, defaultEval, mkComponent, mkEval, modify_)
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP

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
render s =
    HH.div
        [ HP.class_ $ ClassName "w-screen h-screen flex flex-col justify-center items-center gap-5" ]
        [ HH.div
            [ (HP.class_ $ ClassName "text-4xl") ]
            [ HH.text "Counter" ]
        , HH.div
            [ HP.class_ $ ClassName "flex justify-center items-center gap-10" ]
            [ HH.button
                [ HP.class_ $ ClassName "text-blue-700 px-4 py-2 border border-blue-500 rounded"
                , HE.onClick \_ -> Increment
                ]
                [ HH.text "+" ]
            , HH.div
                [ HP.class_ $ ClassName "text-xl" ]
                [ HH.text $ show s.value ]
            , HH.button
                [ HP.class_ $ ClassName "text-blue-700 px-4 py-2 border border-blue-500 rounded"
                , HE.onClick \_ -> Decrement
                ]
                [ HH.text "-" ]
            ]
        ]

handleAction :: forall o m. Action -> HalogenM State Action () o m Unit
handleAction = case _ of
    Increment -> modify_ \s -> s { value = s.value + 1 }
    Decrement -> modify_ \s -> s { value = s.value - 1 }
