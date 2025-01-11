module Component.Counter (counter) where

import Prelude

import Halogen
    ( HalogenM
    , HalogenQ
    , ClassName(..)
    , Component
    , mkComponent
    , mkEval
    , defaultEval
    , modify_)
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP

import Model.Counter (Counter, mkCounter, incr, decr)

type State = { counter :: Counter }

data Action = Increment | Decrement

counter :: forall q i o m. Component q i o m
counter = mkComponent { initialState, eval, render }

initialState :: forall a. a -> State
initialState _  = { counter: mkCounter 0 }

eval :: forall q i o m a. HalogenQ q Action i a -> HalogenM State Action () o m a
eval = mkEval $ defaultEval { handleAction = handleAction }

handleAction :: forall o m. Action -> HalogenM State Action () o m Unit
handleAction = case _ of
    Increment -> modify_ \s -> { counter: incr s.counter }
    Decrement -> modify_ \s -> { counter: decr s.counter }

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
