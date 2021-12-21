module Generators where

import Hedgehog
import qualified Hedgehog.Gen as Gen
import qualified Hedgehog.Range as Range

-- | Simple example of range linear int generator
intGen :: MonadGen m => m Int
intGen = Gen.int (Range.linear 1 1000)
