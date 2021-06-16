module Lib
    ( reportUsersCount
    ) where

count :: Int
count = 11

reportUsersCount :: IO ()
reportUsersCount = putStrLn ("We currently have " ++ (show count) ++ " users.")
