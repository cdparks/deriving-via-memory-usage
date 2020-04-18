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

module Oom.Entities.Question
  ( QuestionId(..)
  , Question(..)
  )
where

import Prelude

import Data.List.NonEmpty (NonEmpty)
import Data.Text (Text)
import GHC.Generics (Generic)
import Numeric.Natural (Natural)
import Oom.Json

data Question = Question
  { questionId :: QuestionId
  , questionText :: Text
  , questionDiagramUrl :: Maybe Text
  , questionOptions :: NonEmpty Text
  , questionCorrectAnswers :: NonEmpty Int
  }
  deriving (Generic)

newtype QuestionId = QuestionId { unQuestionId :: Int }
  deriving newtype (Eq, Show, ToJSON, FromJSON)
  deriving stock (Generic)

#ifdef USE_DERIVING_VIA

deriving via (ApiOptions ('Just "question") Question) instance (ToJSON Question)
deriving via (ApiOptions ('Just "question") Question) instance (FromJSON Question)

#else

instance (ToJSON Question) where
  toJSON = genericToJSON $ apiOptions $ Just "question"
  toEncoding = genericToEncoding $ apiOptions $ Just "question"

instance (FromJSON Question) where
  parseJSON = genericParseJSON $ apiOptions $ Just "question"

#endif
