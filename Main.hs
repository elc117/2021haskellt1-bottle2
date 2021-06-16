{-# LANGUAGE ForeignFunctionInterface #-}

module Main where

-- Reference: https://hackage.haskell.org/package/base/docs/Foreign-C-Types.html
--            https://hackage.haskell.org/package/base/docs/Foreign-C-String.html

import Foreign.C.Types
import Foreign.C.String

-- Thanks https://stackoverflow.com/a/57495181
main :: IO ()
main = return ()

fibonacci :: Int -> Int
fibonacci n = fibs !! n
    where fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

fibonacci_hs :: CInt -> CInt
fibonacci_hs = fromIntegral . fibonacci . fromIntegral

string_test :: String
string_test = "Hello world, from Haskell inside C"

string_test_hs :: IO CString
string_test_hs = newCString string_test

foreign export ccall fibonacci_hs :: CInt -> CInt
foreign export ccall string_test_hs :: IO CString
