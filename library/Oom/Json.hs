{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE NoStarIsType #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE UndecidableInstances #-}

module Oom.Json
  ( Codec(..)
  , Drop
  , apiOptions

  -- Re-exports
  , genericToEncoding
  , genericToJSON
  , genericParseJSON
  , FromJSON(..)
  , ToJSON(..)
  )
where

import Prelude

import Data.Aeson
import Data.Aeson.Types
import qualified Data.Char as C
import Data.Kind (Type)
import Data.List (isPrefixOf)
import Data.Proxy
import GHC.Generics (Generic, Rep)
import GHC.TypeLits (KnownSymbol, Symbol, symbolVal)


-- | Aeson @'Options'@ that match our API's conventions
--
-- - All object keys are @camelCase@
-- - Sum types are encoded as an object containing tag/contents with constructors
--   represented in @snake_case@
--
-- This is @'defaultOptions'@ with a prefix-drop and re-casing on both
-- constructors (for sum types) and field labels (for product types).
--
apiOptions :: Maybe String -> Options
apiOptions mPrefix = defaultOptions
  { constructorTagModifier = snakeCaseify . unCapitalize . modify
  , fieldLabelModifier = unCapitalize . modify
  }
  where modify = maybe id dropPrefix mPrefix

-- | Use with -XDerivingVia to generate instances matching our API's conventions
--
-- e.g.
--
--   data Person = Person
--     { personName :: Text
--     , personAge :: Natural
--     }
--     deriving stock (Generic)
--     deriving via (Codec (Drop "person") Person) (ToJSON, FromJSON)
--
newtype Codec (tag :: k) (value :: Type) = Codec { unCodec :: value }

-- | Used to specify field prefix to drop
data Drop something

instance (GToEncoding Zero (Rep a), GToJSON Zero (Rep a), Generic a, ModifyOptions tag) => ToJSON (Codec tag a) where
  toJSON = genericToJSON (modifyOptions @tag defaultOptions) . unCodec
  toEncoding = genericToEncoding (modifyOptions @tag defaultOptions) . unCodec

instance (GFromJSON Zero (Rep a), Generic a, ModifyOptions tag) => FromJSON (Codec tag a) where
  parseJSON =
    (Codec <$>) . genericParseJSON (modifyOptions @tag defaultOptions)

class ModifyOptions tag where
  modifyOptions :: Options -> Options

instance (KnownSymbol symbol) => ModifyOptions (Drop symbol) where
  modifyOptions options = options
    { fieldLabelModifier =
      snakeCaseify
      . unCapitalize
      . dropPrefix prefix
      . fieldLabelModifier options
    , constructorTagModifier =
      unCapitalize . dropPrefix prefix . constructorTagModifier options
    }
    where prefix = symbolVal $ Proxy @symbol
-- | Lower-case leading character
--
-- >>> unCapitalize "Capped"
-- "capped"
--
unCapitalize :: String -> String
unCapitalize [] = []
unCapitalize (c : cs) = C.toLower c : cs

-- | Drop string prefix or throw if prefix is not present
dropPrefix :: String -> String -> String
dropPrefix prefix x
  | prefix `isPrefixOf` x
  = drop (length prefix) x
  | otherwise
  = error $ "dropPrefix: " <> show prefix <> " is not a prefix of " <> show x

-- | Lower-case and insert an underscore before upper-case letters
--
-- >>> snakeCaseify "levelSubtraction"
-- "level_subtraction"
--
snakeCaseify :: String -> String
snakeCaseify [] = []
snakeCaseify (c : cs)
  | C.isLower c = c : snakeCaseify cs
  | otherwise = '_' : C.toLower c : snakeCaseify cs
