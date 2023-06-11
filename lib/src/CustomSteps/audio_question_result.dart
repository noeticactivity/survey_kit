import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:amorc_survey_kit_local/survey_kit.dart';

class AudioResult {
  final String? textInput;
  final Uint8List? mp3Data;

  AudioResult({
    this.textInput,
    this.mp3Data,
  });
}

class AudioQuestionResult extends QuestionResult<AudioResult> {
  final String textInput;
  final Uint8List? mp3Data;

  AudioQuestionResult({
    required Identifier? id,
    required DateTime startDate,
    required DateTime endDate,
    required String? valueIdentifier,
    required this.textInput,
    required this.mp3Data,
    required AudioResult result,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: result,
        );

  @override
  AudioQuestionResult copyWith({String? valueIdentifier}) {
    return AudioQuestionResult(
      id: id,
      startDate: startDate,
      endDate: endDate,
      valueIdentifier: valueIdentifier ?? this.valueIdentifier,
      textInput: textInput,
      mp3Data: mp3Data,
      result: result ??
          AudioResult(
            textInput:
                'Error', // Provide default values for textInput and mp3Data
            mp3Data: null,
          ),
    );
  }

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
