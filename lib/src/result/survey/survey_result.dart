import 'package:amorc_survey_kit_local/src/result/result.dart';
import 'package:amorc_survey_kit_local/src/result/step_result.dart';
import 'package:amorc_survey_kit_local/src/steps/identifier/identifier.dart';

import 'package:json_annotation/json_annotation.dart';

part 'survey_result.g.dart';

@JsonSerializable(explicitToJson: true)
class SurveyResult extends Result {
  final FinishReason finishReason;
  final List<StepResult> results;

  SurveyResult({
    required Identifier? id,
    required DateTime startDate,
    required DateTime endDate,
    required this.finishReason,
    required this.results,
  }) : super(id: id, startDate: startDate, endDate: endDate);

  factory SurveyResult.fromJson(Map<String, dynamic> json) =>
      _$SurveyResultFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, finishReason];
}

enum FinishReason { SAVED, DISCARDED, COMPLETED, FAILED }
