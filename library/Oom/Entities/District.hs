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

module Oom.Entities.District
  ( DistrictId(..)
  , District(..)
  )
where

import Prelude

import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import GHC.Generics (Generic)
import Oom.Json

data District = District
  { districtId :: DistrictId
  , districtCreatedAt :: UTCTime
  , districtName :: Text
  , districtStreet :: Text
  , districtCity :: Text
  , districtAddress1 :: Maybe Text
  , districtAddress2 :: Maybe Text
  , districtPostalCode :: Maybe Text
  , districtCountryCode :: Text
  }
  deriving (Generic)

newtype DistrictId = DistrictId { unDistrictId :: Int }
  deriving newtype (Eq, Show, ToJSON, FromJSON)
  deriving stock (Generic)

#ifdef USE_DERIVING_VIA

deriving via (ApiOptions ('Just "district") District) instance (ToJSON District)
deriving via (ApiOptions ('Just "district") District) instance (FromJSON District)

#else

instance (ToJSON District) where
  toJSON = genericToJSON $ apiOptions $ Just "district"
  toEncoding = genericToEncoding $ apiOptions $ Just "district"

instance (FromJSON District) where
  parseJSON = genericParseJSON $ apiOptions $ Just "district"

#endif
