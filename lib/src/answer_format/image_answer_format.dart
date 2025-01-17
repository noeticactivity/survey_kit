import 'package:json_annotation/json_annotation.dart';
import 'package:amorc_survey_kit_local/src/answer_format/answer_format.dart';

part 'image_answer_format.g.dart';

@JsonSerializable()
class ImageAnswerFormat implements AnswerFormat {
  final String? defaultValue;
  final String buttonText;

  const ImageAnswerFormat({
    this.defaultValue,
    this.buttonText = 'Image: ',
  }) : super();

  factory ImageAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$ImageAnswerFormatFromJson(json);

  Map<String, dynamic> toJson() => _$ImageAnswerFormatToJson(this);
}
