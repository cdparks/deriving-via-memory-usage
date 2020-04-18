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

module Oom.Entities.Course
  ( CourseId(..)
  , Course(..)
  )
where

import Prelude

import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import GHC.Generics (Generic)
import Numeric.Natural (Natural)
import Oom.Entities.Teacher (TeacherId)
import Oom.Json

data Course = Course
  { courseId :: CourseId
  , courseCreatedAt :: UTCTime
  , courseTeacherId :: TeacherId
  , courseName :: Text
  , courseCode :: Text
  }
  deriving (Generic)

newtype CourseId = CourseId { unCourseId :: Int }
  deriving newtype (Eq, Show, ToJSON, FromJSON)
  deriving stock (Generic)

#ifdef USE_DERIVING_VIA

deriving via (ApiOptions ('Just "course") Course) instance (ToJSON Course)
deriving via (ApiOptions ('Just "course") Course) instance (FromJSON Course)

#else

instance (ToJSON Course) where
  toJSON = genericToJSON $ apiOptions $ Just "course"
  toEncoding = genericToEncoding $ apiOptions $ Just "course"

instance (FromJSON Course) where
  parseJSON = genericParseJSON $ apiOptions $ Just "course"

#endif
