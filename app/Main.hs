module Main where

import Application (runApplication)

-- | Dummy main calling the dummy function from our library module.
main :: IO ()
main = do
  putStrLn $ "A fake application ran with the following output result: " <> show (runApplication 101)
