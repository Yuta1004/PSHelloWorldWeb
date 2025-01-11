module Counter
    ( Counter
    , mkCounter
    , incr
    , decr
    ) where

import Prelude

type Counter = { value :: Int }

mkCounter :: Int -> Counter
mkCounter value = { value }

incr :: Counter -> Counter
incr counter = counter { value = counter.value + 1 }

decr :: Counter -> Counter
decr counter = counter { value = counter.value - 1 }
