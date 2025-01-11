module UI.Component.Counter.View (render) where

import Prelude

import Halogen (ClassName(..))
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP

import UI.Component.Counter.Eval (Action(..))
import UI.Component.Counter.State (State)

render :: forall w. State -> HH.HTML w Action
render s =
    HH.div
        [ HP.class_ verticalBox ]
        [ HH.div
            [ HP.class_ titleText ]
            [ HH.text "Counter" ]
        , HH.div
            [ HP.class_ horozontalBox ]
            [ HH.button
                [ HP.class_ primaryButton
                , HE.onClick \_ -> Increment
                ]
                [ HH.text "+" ]
            , HH.div
                [ HP.class_ bodyText ]
                [ HH.text $ show s.counter.value ]
            , HH.button
                [ HP.class_ primaryButton
                , HE.onClick \_ -> Decrement
                ]
                [ HH.text "-" ]
            ]
        ]
    where
        verticalBox = ClassName "w-screen h-screen flex flex-col justify-center items-center gap-5"
        horozontalBox = ClassName "flex justify-center items-center gap-5"
        primaryButton = ClassName "text-blue-700 px-4 py-2 border border-blue-500 rounded"
        titleText = ClassName "text-4xl"
        bodyText = ClassName "text-xl"
