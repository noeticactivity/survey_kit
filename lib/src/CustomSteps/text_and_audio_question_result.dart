import 'package:flutter/foundation.dart';
import 'package:amorc_survey_kit_local/src/steps/identifier/identifier.dart';
import 'package:amorc_survey_kit_local/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable(explicitToJson: true)
// class TextAndAudioQuestionResult extends QuestionResult<List<TextChoice>?> {
//   TextAndAudioQuestionResult({
//     required Identifier id,
//     required DateTime startDate,
//     required DateTime endDate,
//     required String valueIdentifier,
//     required List<TextChoice>? result,
//   }) : super(
//           id: id,
//           startDate: startDate,
//           endDate: endDate,
//           valueIdentifier: valueIdentifier,
//           result: result,
//         );

//   // factory TextAndAudioQuestionResult.fromJson(Map<String, dynamic> json) =>
//   //     _$MultipleChoiceQuestionResultFromJson(json);

//   // Map<String, dynamic> toJson() => _$MultipleChoiceQuestionResultToJson(this);

//   @override
//   List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
// }

//TODO: JSON SERIALIZATION
class TextAndAudioResult {
  final String textInput;
  final Uint8List? mp3Data;

  TextAndAudioResult({
    required this.textInput,
    this.mp3Data,
  });
}

class TextAndAudioQuestionResult extends QuestionResult<TextAndAudioResult> {
  final String textInput;
  final Uint8List? mp3Data;

  TextAndAudioQuestionResult({
    required Identifier? id,
    required DateTime startDate,
    required DateTime endDate,
    required String? valueIdentifier,
    required this.textInput,
    required this.mp3Data,
    required TextAndAudioResult result,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: result,
        );

  @override
  TextAndAudioQuestionResult copyWith({String? valueIdentifier}) {
    return TextAndAudioQuestionResult(
      id: id,
      startDate: startDate,
      endDate: endDate,
      valueIdentifier: valueIdentifier ?? this.valueIdentifier,
      textInput: textInput,
      mp3Data: mp3Data,
      result: result ??
          TextAndAudioResult(
            textInput:
                'Error', // Provide default values for textInput and mp3Data
            mp3Data: null,
          ),
    );
  }

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
