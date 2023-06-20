import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:amorc_survey_kit_local/src/result/question_result.dart';
import 'package:amorc_survey_kit_local/src/steps/step.dart';
import 'package:amorc_survey_kit_local/src/steps/identifier/step_identifier.dart';
import 'package:amorc_survey_kit_local/src/views/completion_view.dart';

part 'completion_step.g.dart';

@JsonSerializable()
class CompletionStep extends Step {
  final String title;
  final String text;
  final String assetPath;

  CompletionStep(
      {bool isOptional = false,
      required StepIdentifier stepIdentifier,
      String buttonText = 'End Survey', //FIXME: LOCALIZE THIS
      bool showAppBar = true,
      required this.title,
      required this.text,
      this.assetPath =
          ''}) //FIXME: This url wont work on other machines. Need to find a way to refer to it by the package bundle
      : super(
          stepIdentifier: stepIdentifier,
          isOptional: isOptional,
          buttonText: buttonText,
          showAppBar: showAppBar,
        );

  @override
  Widget createView({required QuestionResult? questionResult}) {
    return CompletionView(completionStep: this, assetPath: assetPath);
  }

  factory CompletionStep.fromJson(Map<String, dynamic> json) =>
      _$CompletionStepFromJson(json);
  Map<String, dynamic> toJson() => _$CompletionStepToJson(this);

  bool operator ==(o) =>
      super == (o) && o is CompletionStep && o.title == title && o.text == text;
  int get hashCode => super.hashCode ^ title.hashCode ^ text.hashCode;
}
