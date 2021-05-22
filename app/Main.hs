{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.Aeson
import qualified Control.Monad
import qualified Data.Maybe
import qualified Web.Scotty as Scotty
import qualified Network.Wai.Middleware.RequestLogger
import qualified Text.Read
import qualified GHC.Generics
import qualified System.Environment
--import qualified Network.HTTP.Types.Status as HTTPStatus

data Message = Message
  { message    :: String } deriving GHC.Generics.Generic

instance Data.Aeson.ToJSON Message

rootEndpoint :: Scotty.ScottyM()
rootEndpoint =
  Scotty.get "/" $ Scotty.json $ Message "Hi"

unknownEndpoint :: Scotty.ScottyM()
unknownEndpoint =
  Scotty.notFound $ Scotty.json $ Message "Not found"

main :: IO ()
main = do
  port <- Data.Maybe.fromMaybe 3000
        . Control.Monad.join
        . fmap Text.Read.readMaybe <$> System.Environment.lookupEnv "PORT"

  Scotty.scotty port $ do
         Scotty.middleware Network.Wai.Middleware.RequestLogger.logStdoutDev
         rootEndpoint >> unknownEndpoint
