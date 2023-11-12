import 'package:json_annotation/json_annotation.dart';
import 'package:amorc_survey_kit_local/src/answer_format/answer_format.dart';

part 'boolean_answer_format.g.dart';

@JsonSerializable()
class BooleanAnswerFormat implements AnswerFormat {
  final String positiveAnswer;
  final String negativeAnswer;
  final BooleanResult result;
  final String type;

  const BooleanAnswerFormat(
      {required this.positiveAnswer,
      required this.negativeAnswer,
      this.result = BooleanResult.NONE,
      this.type = 'bool'})
      : super();

  factory BooleanAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$BooleanAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$BooleanAnswerFormatToJson(this);
}

enum BooleanResult { NONE, POSITIVE, NEGATIVE }
