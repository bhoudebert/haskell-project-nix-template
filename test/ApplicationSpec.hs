module ApplicationSpec where

import qualified Application as SUT
import Generators
import Hedgehog
import Test.Tasty.HUnit hiding (assert)
import Test.Tasty.Hedgehog

-- | Basic property test, SUT = System Under Test.
test_runApplicationCorrectSum =
  testProperty "When calling runApplication with any int it should return the int value plus 42"
    . property
    $ do
      someIntValue <- forAll intGen
      let result = SUT.runApplication someIntValue
          expectedResult = 45 + someIntValue
      assert (result == expectedResult)

-- | Simple unit test
test_runApplicationWithZero =
  testCase "When calling runApplication with zero as a value it should return 42" $
    (SUT.runApplication 0) @?= 42
