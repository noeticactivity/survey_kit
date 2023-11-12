import 'package:json_annotation/json_annotation.dart';
import 'package:amorc_survey_kit_local/src/answer_format/answer_format.dart';

part 'integer_answer_format.g.dart';

@JsonSerializable()
class IntegerAnswerFormat implements AnswerFormat {
  final int? defaultValue;
  final String hint;
  final String type;

  const IntegerAnswerFormat(
      {this.defaultValue, this.hint = '', this.type = 'integer'})
      : super();

  factory IntegerAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$IntegerAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$IntegerAnswerFormatToJson(this);
}
