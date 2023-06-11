import 'package:amorc_survey_kit_local/src/result/question_result.dart';

abstract class SurveyEvent {
  const SurveyEvent();
}

class StartSurvey extends SurveyEvent {}

class NextStep extends SurveyEvent {
  final QuestionResult questionResult;

  NextStep(this.questionResult);
}

class StepBack extends SurveyEvent {
  final QuestionResult? questionResult;

  StepBack(this.questionResult);
}

class CloseSurvey extends SurveyEvent {
  final QuestionResult? questionResult;

  CloseSurvey(this.questionResult);
}
