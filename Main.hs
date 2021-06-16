{-# LANGUAGE ForeignFunctionInterface #-}

module Main where

-- Reference: https://hackage.haskell.org/package/base/docs/Foreign.html

import Foreign.C.Types
import Foreign.C.String
import Foreign.Marshal.Array
import Foreign.Ptr

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

float_tuple_list :: [(Float, Float)]
float_tuple_list = [(0.0, 0.0), (3.0, 4.0)]

float_tuple_list_hs :: IO (Ptr Float)
float_tuple_list_hs = newArray (map (fst) float_tuple_list)

foreign export ccall fibonacci_hs :: CInt -> CInt
foreign export ccall string_test_hs :: IO CString
foreign export ccall float_tuple_list_hs :: IO (Ptr Float)
