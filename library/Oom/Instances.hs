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

module Oom.Instances
  ( DistrictId(..)
  , District(..)
  , SchoolId(..)
  , School(..)
  , TeacherId(..)
  , Teacher(..)
  , CourseId(..)
  , Course(..)
  , MembershipId(..)
  , Membership(..)
  , StudentId(..)
  , Student(..)
  , AssignmentId(..)
  , Assignment(..)
  , SessionId(..)
  , Session(..)
  , AnswerId(..)
  , Answer(..)
  , QuestionId(..)
  , Question(..)
  )
where

import Prelude

import Data.List.NonEmpty (NonEmpty)
import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import GHC.Generics (Generic)
import Numeric.Natural (Natural)
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

data Answer = Answer
  { answerId :: AnswerId
  , answerCreatedAt :: UTCTime
  , answerSessionId :: SessionId
  , answerQuestionId :: QuestionId
  , answerInput :: Text
  , answerDurationSeconds :: Natural
  , answerAccuracy :: Double
  }
  deriving (Generic)

newtype AnswerId = AnswerId { unAnswerId :: Int }
  deriving newtype (Eq, Show, ToJSON, FromJSON)
  deriving stock (Generic)

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

deriving via (ApiOptions ('Just "district") District) instance (ToJSON District)
deriving via (ApiOptions ('Just "district") District) instance (FromJSON District)

deriving via (ApiOptions ('Just "school") School) instance (ToJSON School)
deriving via (ApiOptions ('Just "school") School) instance (FromJSON School)

deriving via (ApiOptions ('Just "teacher") Teacher) instance (ToJSON Teacher)
deriving via (ApiOptions ('Just "teacher") Teacher) instance (FromJSON Teacher)

deriving via (ApiOptions ('Just "course") Course) instance (ToJSON Course)
deriving via (ApiOptions ('Just "course") Course) instance (FromJSON Course)

deriving via (ApiOptions ('Just "membership") Membership) instance (ToJSON Membership)
deriving via (ApiOptions ('Just "membership") Membership) instance (FromJSON Membership)

deriving via (ApiOptions ('Just "student") Student) instance (ToJSON Student)
deriving via (ApiOptions ('Just "student") Student) instance (FromJSON Student)

deriving via (ApiOptions ('Just "assignment") Assignment) instance (ToJSON Assignment)
deriving via (ApiOptions ('Just "assignment") Assignment) instance (FromJSON Assignment)

deriving via (ApiOptions ('Just "session") Session) instance (ToJSON Session)
deriving via (ApiOptions ('Just "session") Session) instance (FromJSON Session)

deriving via (ApiOptions ('Just "answer") Answer) instance (ToJSON Answer)
deriving via (ApiOptions ('Just "answer") Answer) instance (FromJSON Answer)

deriving via (ApiOptions ('Just "question") Question) instance (ToJSON Question)
deriving via (ApiOptions ('Just "question") Question) instance (FromJSON Question)

#else

instance (ToJSON District) where
  toJSON = genericToJSON $ apiOptions $ Just "district"
  toEncoding = genericToEncoding $ apiOptions $ Just "district"

instance (FromJSON District) where
  parseJSON = genericParseJSON $ apiOptions $ Just "district"

instance (ToJSON School) where
  toJSON = genericToJSON $ apiOptions $ Just "school"
  toEncoding = genericToEncoding $ apiOptions $ Just "school"

instance (FromJSON School) where
  parseJSON = genericParseJSON $ apiOptions $ Just "school"

instance (ToJSON Teacher) where
  toJSON = genericToJSON $ apiOptions $ Just "teacher"
  toEncoding = genericToEncoding $ apiOptions $ Just "teacher"

instance (FromJSON Teacher) where
  parseJSON = genericParseJSON $ apiOptions $ Just "teacher"

instance (ToJSON Course) where
  toJSON = genericToJSON $ apiOptions $ Just "course"
  toEncoding = genericToEncoding $ apiOptions $ Just "course"

instance (FromJSON Course) where
  parseJSON = genericParseJSON $ apiOptions $ Just "course"

instance (ToJSON Membership) where
  toJSON = genericToJSON $ apiOptions $ Just "membership"
  toEncoding = genericToEncoding $ apiOptions $ Just "membership"

instance (FromJSON Membership) where
  parseJSON = genericParseJSON $ apiOptions $ Just "membership"

instance (ToJSON Student) where
  toJSON = genericToJSON $ apiOptions $ Just "student"
  toEncoding = genericToEncoding $ apiOptions $ Just "student"

instance (FromJSON Student) where
  parseJSON = genericParseJSON $ apiOptions $ Just "student"

instance (ToJSON Assignment) where
  toJSON = genericToJSON $ apiOptions $ Just "assignment"
  toEncoding = genericToEncoding $ apiOptions $ Just "assignment"

instance (FromJSON Assignment) where
  parseJSON = genericParseJSON $ apiOptions $ Just "assignment"

instance (ToJSON Session) where
  toJSON = genericToJSON $ apiOptions $ Just "session"
  toEncoding = genericToEncoding $ apiOptions $ Just "session"

instance (FromJSON Session) where
  parseJSON = genericParseJSON $ apiOptions $ Just "session"

instance (ToJSON Answer) where
  toJSON = genericToJSON $ apiOptions $ Just "answer"
  toEncoding = genericToEncoding $ apiOptions $ Just "answer"

instance (FromJSON Answer) where
  parseJSON = genericParseJSON $ apiOptions $ Just "answer"

instance (ToJSON Question) where
  toJSON = genericToJSON $ apiOptions $ Just "question"
  toEncoding = genericToEncoding $ apiOptions $ Just "question"

instance (FromJSON Question) where
  parseJSON = genericParseJSON $ apiOptions $ Just "question"

#endif
