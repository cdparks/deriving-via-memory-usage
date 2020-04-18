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

module Oom.Entities.Session
  ( SessionId(..)
  , Session(..)
  )
where

import Prelude

import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import GHC.Generics (Generic)
import Numeric.Natural (Natural)
import Oom.Entities.Assignment (AssignmentId)
import Oom.Entities.Student (StudentId)
import Oom.Json

data Session = Session
  { sessionId :: SessionId
  , sessionCreatedAt :: UTCTime
  , sessionAssignmentId :: AssignmentId
  , sessionStudentId :: StudentId
  , sessionAccuracy :: Maybe Double
  , sessionCompletedAt :: Maybe UTCTime
  , sessionDurationSeconds :: Maybe Natural
  , sessionNumQuestionsAnswered :: Maybe Natural
  }
  deriving (Generic)

newtype SessionId = SessionId { unSessionId :: Int }
  deriving newtype (Eq, Show, ToJSON, FromJSON)
  deriving stock (Generic)

#ifdef USE_DERIVING_VIA

deriving via (ApiOptions ('Just "session") Session) instance (ToJSON Session)
deriving via (ApiOptions ('Just "session") Session) instance (FromJSON Session)

#else

instance (ToJSON Session) where
  toJSON = genericToJSON $ apiOptions $ Just "session"
  toEncoding = genericToEncoding $ apiOptions $ Just "session"

instance (FromJSON Session) where
  parseJSON = genericParseJSON $ apiOptions $ Just "session"

#endif
