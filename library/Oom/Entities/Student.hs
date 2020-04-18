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

module Oom.Entities.Student
  ( StudentId(..)
  , Student(..)
  )
where

import Prelude

import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import GHC.Generics (Generic)
import Numeric.Natural (Natural)
import Oom.Json

data Student = Student
  { studentId :: StudentId
  , studentCreatedAt :: UTCTime
  , studentFirstName :: Text
  , studentLastName :: Text
  , studentGrade :: Natural
  }
  deriving (Generic)

newtype StudentId = StudentId { unStudentId :: Int }
  deriving newtype (Eq, Show, ToJSON, FromJSON)
  deriving stock (Generic)

#ifdef USE_DERIVING_VIA

deriving via (ApiOptions ('Just "student") Student) instance (ToJSON Student)
deriving via (ApiOptions ('Just "student") Student) instance (FromJSON Student)

#else

instance (ToJSON Student) where
  toJSON = genericToJSON $ apiOptions $ Just "student"
  toEncoding = genericToEncoding $ apiOptions $ Just "student"

instance (FromJSON Student) where
  parseJSON = genericParseJSON $ apiOptions $ Just "student"

#endif
