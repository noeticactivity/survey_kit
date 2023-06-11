// by Antonio Bruno, Giacomo Ignesti and Massimo Martinelli

import 'package:json_annotation/json_annotation.dart';
import 'package:amorc_survey_kit_local/src/answer_format/answer_format.dart';

part 'double_answer_format.g.dart';

@JsonSerializable()
class DoubleAnswerFormat implements AnswerFormat {
  final double? defaultValue;
  final String hint;

  const DoubleAnswerFormat({
    this.defaultValue,
    this.hint = '',
  }) : super();

  factory DoubleAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$DoubleAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$DoubleAnswerFormatToJson(this);
}
