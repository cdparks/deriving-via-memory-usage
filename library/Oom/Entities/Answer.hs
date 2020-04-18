{-# LANGUAGE CPP #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StrictData #-}
#ifdef USE_DERIVING_VIA
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE StandaloneDeriving #-}
#endif

module Oom.Entities.Answer
  ( AnswerId(..)
  , Answer(..)
  )
where

import Prelude

import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import GHC.Generics (Generic)
import Numeric.Natural (Natural)
import Oom.Entities.Question (QuestionId)
import Oom.Entities.Session (SessionId)
import Oom.Json

data Answer = Answer
  { answerId :: AnswerId
  , answerCreatedAt :: UTCTime
  , answerSessionId :: SessionId
  , answerQuestionId :: QuestionId
  , answerInput :: Text
  , answerDurationSeconds :: Natural
  , answerAccuracy :: Double
  }
  deriving (Generic)

newtype AnswerId = AnswerId { unAnswerId :: Int }
  deriving newtype (Eq, Show, ToJSON, FromJSON)
  deriving stock (Generic)

#ifdef USE_DERIVING_VIA

deriving via (ApiOptions ('Just "answer") Answer) instance (ToJSON Answer)
deriving via (ApiOptions ('Just "answer") Answer) instance (FromJSON Answer)

#else

instance (ToJSON Answer) where
  toJSON = genericToJSON $ apiOptions $ Just "answer"
  toEncoding = genericToEncoding $ apiOptions $ Just "answer"

instance (FromJSON Answer) where
  parseJSON = genericParseJSON $ apiOptions $ Just "answer"

#endif
