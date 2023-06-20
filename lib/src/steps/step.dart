import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:amorc_survey_kit_local/src/result/question_result.dart';
import 'package:amorc_survey_kit_local/src/steps/identifier/step_identifier.dart';
import 'package:amorc_survey_kit_local/src/steps/predefined_steps/completion_step.dart';
import 'package:amorc_survey_kit_local/src/steps/predefined_steps/instruction_step.dart';
import 'package:amorc_survey_kit_local/src/steps/predefined_steps/question_step.dart';
import 'package:amorc_survey_kit_local/src/steps/step_not_defined_exception.dart';

abstract class Step {
  final StepIdentifier stepIdentifier;
  @JsonKey(defaultValue: false)
  final bool isOptional;
  @JsonKey(defaultValue: 'Next')
  String? buttonText;
  final bool canGoBack;
  final bool showProgress;
  final bool showAppBar;

  Step({
    StepIdentifier? stepIdentifier,
    this.isOptional = false,
    String? buttonText = 'Next',
    this.canGoBack = true,
    this.showProgress = true,
    this.showAppBar = true,
  }) : stepIdentifier = stepIdentifier ?? StepIdentifier();

  Widget createView({required QuestionResult? questionResult});

  factory Step.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    if (type == 'intro') {
      return InstructionStep.fromJson(json);
    } else if (type == 'question') {
      return QuestionStep.fromJson(json);
    } else if (type == 'completion') {
      return CompletionStep.fromJson(json);
    }
    throw StepNotDefinedException();
  }

  Map<String, dynamic> toJson();

  bool operator ==(o) =>
      o is Step &&
      o.stepIdentifier == stepIdentifier &&
      o.isOptional == isOptional &&
      o.buttonText == buttonText;
  int get hashCode =>
      stepIdentifier.hashCode ^ isOptional.hashCode ^ buttonText.hashCode;
}
