import 'package:json_annotation/json_annotation.dart';
import 'package:amorc_survey_kit_local/src/answer_format/answer_format.dart';
import 'package:amorc_survey_kit_local/src/answer_format/text_choice.dart';

part 'multiple_choice_answer_format.g.dart';

@JsonSerializable()
class MultipleChoiceAnswerFormat implements AnswerFormat {
  final List<TextChoice> textChoices;
  @JsonKey(defaultValue: const [])
  final List<TextChoice> defaultSelection;
  @JsonKey(defaultValue: false)
  final bool otherField;
  @JsonKey(defaultValue: 100)
  final int maxAnswers;

  @JsonKey(defaultValue: 'Other')
  final String otherFieldHintText;

  final String type;

  const MultipleChoiceAnswerFormat(
      {required this.textChoices,
      this.defaultSelection = const [],
      this.otherField = false,
      this.maxAnswers = 100,
      this.otherFieldHintText = 'Other',
      this.type = 'multiple'})
      : super();

  factory MultipleChoiceAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$MultipleChoiceAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$MultipleChoiceAnswerFormatToJson(this);
}
