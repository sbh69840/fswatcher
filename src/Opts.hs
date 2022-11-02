module Opts where

import Options.Applicative
  ( Alternative (some),
    Parser,
    auto,
    help,
    long,
    metavar,
    option,
    strArgument,
    strOption,
    value,
  )

data WatchOpt = WatchOpt
  { watchPaths :: [String],
    -- | a regex to include particular files when watching dir
    includePath :: String,
    -- | a regex to exclude particular files when watching dir
    excludePath :: String,
    -- | milliseconds to wait for duplicate events
    throttlingDelay :: Int,
    actionCmd :: [String]
  }
  deriving (Show)

watchOpt :: Parser WatchOpt
watchOpt =
  WatchOpt
    <$> some
      ( strOption
          ( long "path"
              <> metavar "PATH"
              <> help "directory / file to watch"
          )
      )
    <*> strOption
      ( long "include"
          <> value []
          <> metavar "INCLUDE"
          <> help "pattern for including files"
      )
    <*> strOption
      ( long "exclude"
          <> value []
          <> metavar "EXCLUDE"
          <> help "pattern for excluding files"
      )
    <*> option
      auto
      ( long "throttle"
          <> value 0
          <> metavar "MILLIS"
          <> help "milliseconds to wait for duplicate events"
      )
    <*> (some . strArgument)
      ( metavar "COMMAND"
          <> help "command to run"
      )
