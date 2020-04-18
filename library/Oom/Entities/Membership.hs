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

module Oom.Entities.Membership
  ( MembershipId(..)
  , Membership(..)
  )
where

import Prelude

import Data.Time.Clock (UTCTime)
import GHC.Generics (Generic)
import Oom.Entities.Course (CourseId)
import Oom.Entities.Student (StudentId)
import Oom.Json

data Membership = Membership
  { membershipId :: MembershipId
  , membershipCreatedAt :: UTCTime
  , membershipCourseId :: CourseId
  , membershipStudentId :: StudentId
  }
  deriving (Generic)

newtype MembershipId = MembershipId { unMembershipId :: Int }
  deriving newtype (Eq, Show, ToJSON, FromJSON)
  deriving stock (Generic)

#ifdef USE_DERIVING_VIA

deriving via (ApiOptions ('Just "membership") Membership) instance (ToJSON Membership)
deriving via (ApiOptions ('Just "membership") Membership) instance (FromJSON Membership)

#else

instance (ToJSON Membership) where
  toJSON = genericToJSON $ apiOptions $ Just "membership"
  toEncoding = genericToEncoding $ apiOptions $ Just "membership"

instance (FromJSON Membership) where
  parseJSON = genericParseJSON $ apiOptions $ Just "membership"

#endif
