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

module Oom.Entities.Teacher
  ( TeacherId(..)
  , Teacher(..)
  )
where

import Prelude

import Oom.Entities.School (SchoolId)
import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import GHC.Generics (Generic)
import Oom.Json

data Teacher = Teacher
  { teacherId :: TeacherId
  , teacherCreatedAt :: UTCTime
  , teacherSchoolId :: Maybe SchoolId
  , teacherFirstName :: Text
  , teacherLastName :: Text
  , teacherEmail :: Text
  }
  deriving (Generic)

newtype TeacherId = TeacherId { unTeacherId :: Int }
  deriving newtype (Eq, Show, ToJSON, FromJSON)
  deriving stock (Generic)

#ifdef USE_DERIVING_VIA

deriving via (ApiOptions ('Just "teacher") Teacher) instance (ToJSON Teacher)
deriving via (ApiOptions ('Just "teacher") Teacher) instance (FromJSON Teacher)

#else

instance (ToJSON Teacher) where
  toJSON = genericToJSON $ apiOptions $ Just "teacher"
  toEncoding = genericToEncoding $ apiOptions $ Just "teacher"

instance (FromJSON Teacher) where
  parseJSON = genericParseJSON $ apiOptions $ Just "teacher"

#endif
