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

module Oom.Entities.Assignment
  ( AssignmentId(..)
  , Assignment(..)
  )
where

import Prelude

import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import GHC.Generics (Generic)
import Oom.Entities.Teacher (TeacherId)
import Oom.Json

data Assignment = Assignment
  { assignmentId :: AssignmentId
  , assignmentCreatedAt :: UTCTime
  , assignmentTeacherId :: Maybe TeacherId
  , assignmentScheduledAt :: Maybe UTCTime
  , assignmentStandard :: Text
  }
  deriving (Generic)

newtype AssignmentId = AssignmentId { unAssignmentId :: Int }
  deriving newtype (Eq, Show, ToJSON, FromJSON)
  deriving stock (Generic)

#ifdef USE_DERIVING_VIA

deriving via (ApiOptions ('Just "assignment") Assignment) instance (ToJSON Assignment)
deriving via (ApiOptions ('Just "assignment") Assignment) instance (FromJSON Assignment)

#else

instance (ToJSON Assignment) where
  toJSON = genericToJSON $ apiOptions $ Just "assignment"
  toEncoding = genericToEncoding $ apiOptions $ Just "assignment"

instance (FromJSON Assignment) where
  parseJSON = genericParseJSON $ apiOptions $ Just "assignment"

#endif
