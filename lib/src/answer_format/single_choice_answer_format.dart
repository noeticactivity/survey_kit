import 'package:json_annotation/json_annotation.dart';
import 'package:amorc_survey_kit_local/src/answer_format/answer_format.dart';
import 'package:amorc_survey_kit_local/src/answer_format/text_choice.dart';

part 'single_choice_answer_format.g.dart';

@JsonSerializable()
class SingleChoiceAnswerFormat implements AnswerFormat {
  final List<TextChoice> textChoices;
  final TextChoice? defaultSelection;

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

  final String type;

  const SingleChoiceAnswerFormat(
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
      this.defaultSelection, // No default value specified, so it's null by default
      this.type = 'single' // Default value set to 'single'
      })
      : super();

  factory SingleChoiceAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$SingleChoiceAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$SingleChoiceAnswerFormatToJson(this);
}
