{-# LANGUAGE OverloadedStrings, PatternGuards #-}

module Main where

import           Network.Linklater
import           Network.Wai.Handler.Warp (run)
import           Data.Text.IO (readFile, writeFile)
import           Data.Text (Text)
import qualified Data.Text as T

type Token = Text

sayHi :: Config -> Command -> IO Text
sayHi config (Command { commandName = "sayHi" }) = return "Hi!"

main :: IO ()
main = do
    putStrLn ("+ Listening on port " <> show port)
    run port (slashSimple $ sayHi configIO)
    where
        configIO :: IO Config
        configIO =
            (Config . T.filter (/= '\n')) <$> readFile "token"
        port = 3335
