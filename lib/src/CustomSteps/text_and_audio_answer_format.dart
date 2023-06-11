import 'package:json_annotation/json_annotation.dart';
import 'package:amorc_survey_kit_local/survey_kit.dart';

@JsonSerializable()
class TextAndAudioChoiceAnswerFormat implements AnswerFormat {
  late String textInput; // Variable to store user's text input
  late String? audioRecording; // Variable to store user's voice recording

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

  TextAndAudioChoiceAnswerFormat({
    String textInput = '',
    String? audioRecording,
    this.maxLines,
    this.hint = '',
    this.validationRegEx = '^(?!\s*\$).+',
  }) : super() {
    this.textInput = textInput;
    this.audioRecording = audioRecording;
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  // factory TextAndAudioChoiceAnswerFormat.fromJson(Map<String, dynamic> json) =>
  //     _$MultipleChoiceAnswerFormatFromJson(json);
  // Map<String, dynamic> toJson() => _$MultipleChoiceAnswerFormatToJson(this);
}
