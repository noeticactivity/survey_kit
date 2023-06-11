import 'package:amorc_survey_kit_local/src/result/question_result.dart';
import 'package:amorc_survey_kit_local/src/steps/identifier/identifier.dart';

part 'image_question_result.g.dart';

class ImageQuestionResult extends QuestionResult<String?> {
  ImageQuestionResult({
    required Identifier id,
    required DateTime startDate,
    required DateTime endDate,
    required String valueIdentifier,
    required String? result,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: result,
        );

  factory ImageQuestionResult.fromJson(Map<String, dynamic> json) =>
      _$ImageQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$ImageQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
