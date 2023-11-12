import 'package:json_annotation/json_annotation.dart';
import 'package:amorc_survey_kit_local/src/answer_format/answer_format.dart';
import 'package:amorc_survey_kit_local/src/answer_format/text_choice.dart';

part 'multiple_choice_auto_complete_answer_format.g.dart';

@JsonSerializable()
class MultipleChoiceAutoCompleteAnswerFormat implements AnswerFormat {
  final List<TextChoice> textChoices;
  @JsonKey(defaultValue: const [])
  final List<TextChoice> defaultSelection;
  @JsonKey(defaultValue: const [])
  final List<TextChoice> suggestions;
  @JsonKey(defaultValue: false)
  final bool otherField;
  final String type;

  const MultipleChoiceAutoCompleteAnswerFormat(
      {required this.textChoices,
      this.defaultSelection = const [],
      this.suggestions = const [],
      this.otherField = false,
      this.type = 'multiple_auto_complete'})
      : super();

  factory MultipleChoiceAutoCompleteAnswerFormat.fromJson(
          Map<String, dynamic> json) =>
      _$MultipleChoiceAutoCompleteAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() =>
      _$MultipleChoiceAutoCompleteAnswerFormatToJson(this);
}
