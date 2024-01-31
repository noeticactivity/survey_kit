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

  final String otherFieldLocalizedValue;

  @JsonKey()
  final String otherFieldHintText;

  @JsonKey(defaultValue: false)
  final bool inLineTextEntryField;

  final String inLineTextEntryFieldLocalizedValue;

  @JsonKey()
  final String inLineTextEntryFieldHintText;

  @JsonKey(defaultValue: 100)
  final int maxAnswers;

  final String type;

  const MultipleChoiceAnswerFormat(
      {this.otherField = false, // Default value set to false
      this.otherFieldLocalizedValue =
          '', // Default value set to an empty string
      this.otherFieldHintText = '', // Default value set to an empty string
      this.inLineTextEntryField = false, // Default value set to false
      this.inLineTextEntryFieldLocalizedValue =
          '', // Default value set to an empty string
      this.inLineTextEntryFieldHintText =
          '', // Default value set to an empty string
      required this.textChoices,
      this.defaultSelection =
          const [], // No default value specified, so it's null by default
      this.type = 'multiple', // Default value set to 'single'
      this.maxAnswers = 100})
      : super();

  factory MultipleChoiceAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$MultipleChoiceAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$MultipleChoiceAnswerFormatToJson(this);
}
