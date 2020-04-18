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

module Oom.Entities.School
  ( SchoolId(..)
  , School(..)
  )
where

import Prelude

import Oom.Entities.District (DistrictId)
import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import GHC.Generics (Generic)
import Oom.Json

data School = School
  { schoolId :: SchoolId
  , schoolCreatedAt :: UTCTime
  , schoolDistrictId :: Maybe DistrictId
  , schoolName :: Text
  , schoolStreet :: Text
  , schoolCity :: Text
  , schoolAddress1 :: Maybe Text
  , schoolAddress2 :: Maybe Text
  , schoolPostalCode :: Maybe Text
  , schoolCountryCode :: Text
  }
  deriving (Generic)

newtype SchoolId = SchoolId { unSchoolId :: Int }
  deriving newtype (Eq, Show, ToJSON, FromJSON)
  deriving stock (Generic)

#ifdef USE_DERIVING_VIA

deriving via (ApiOptions ('Just "school") School) instance (ToJSON School)
deriving via (ApiOptions ('Just "school") School) instance (FromJSON School)

#else

instance (ToJSON School) where
  toJSON = genericToJSON $ apiOptions $ Just "school"
  toEncoding = genericToEncoding $ apiOptions $ Just "school"

instance (FromJSON School) where
  parseJSON = genericParseJSON $ apiOptions $ Just "school"

#endif
