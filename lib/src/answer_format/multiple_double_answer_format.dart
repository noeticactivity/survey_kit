import 'package:json_annotation/json_annotation.dart';
import 'package:amorc_survey_kit_local/src/answer_format/answer_format.dart';
import 'package:amorc_survey_kit_local/src/answer_format/multi_double.dart';

part 'multiple_double_answer_format.g.dart';

@JsonSerializable()
class MultipleDoubleAnswerFormat implements AnswerFormat {
  final List<MultiDouble>? defaultValues;
  @JsonKey(defaultValue: const [])
  final List<String> hints;
  final String type;

  const MultipleDoubleAnswerFormat(
      {this.defaultValues, required this.hints, this.type = 'multiple_double'})
      : super();

  factory MultipleDoubleAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$MultipleDoubleAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$MultipleDoubleAnswerFormatToJson(this);
}
