import 'package:json_annotation/json_annotation.dart';
import 'package:amorc_survey_kit_local/src/answer_format/answer_format.dart';

part 'text_answer_format.g.dart';

@JsonSerializable()
class TextAnswerFormat implements AnswerFormat {
  final int? maxLines;
  @JsonKey(defaultValue: '')
  final String hint;

  /// Regular expression by which the text gets validated
  /// default: '^(?!\s*$).+' that checks if the entered text is empty
  /// to allow any type of an answer including an empty one;
  /// set it explicitly to null.
  ///
  @JsonKey(defaultValue: '^(?!\s*\$).+')
  final String? validationRegEx;

  const TextAnswerFormat({
    this.maxLines,
    this.hint = '',
    this.validationRegEx = '^(?!\s*\$).+',
  }) : super();

  factory TextAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$TextAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$TextAnswerFormatToJson(this);
}
