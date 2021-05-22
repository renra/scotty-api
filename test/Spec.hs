{-# LANGUAGE OverloadedStrings #-}

import Test.Hspec as Hspec
import Data.ByteString
import Network.HTTP.Simple as HTTP

host :: String
host = "localhost"

port :: String
port = "3000"

sendRequest :: String -> IO (HTTP.Response Data.ByteString.ByteString)
sendRequest endpoint = do
    HTTP.httpBS (HTTP.parseRequest_ $ "GET http://" ++ host ++ ":" ++ port ++ endpoint)

main :: IO ()
main = hspec $ do
  it "responds to GET /" $ do
    response <- sendRequest("/")

    (HTTP.getResponseBody response) `shouldBe` ("{\"message\":\"Hi\"}")
    (HTTP.getResponseStatusCode response) `shouldBe` (200 :: Int)

  it "responds to GET /nonsense" $ do
    response <- sendRequest("/nonsense")

    (HTTP.getResponseBody response) `shouldBe` ("{\"message\":\"Not found\"}")
    (HTTP.getResponseStatusCode response) `shouldBe` (404 :: Int)
