import 'package:amorc_survey_kit_local/survey_kit.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

class FeedbackSubmissionStep extends InstructionStep {
  String title = 'title';
  String text = 'text';
  //final InstructionStep feedbackStep;

  FeedbackSubmissionStep({
    required this.title,
    required this.text,
    //required this.feedbackStep,
    required StepIdentifier id,
  }) : super(title: "feedbackStep.title", text: "feedbackStep.text");

  @override
  List<Object?> get props => [title, text];

  @override
  material.Widget createView(
      {required QuestionResult<dynamic>? questionResult}) {
    return FeedbackSubmission();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class FeedbackSubmission extends material.StatelessWidget {
  final DateTime _startDate = DateTime.now();

  //FeedbackSubmission();

  @override
  material.Widget build(material.BuildContext context) {
    return material.Container(
      child: material.Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          material.Expanded(
            child: FeedBackSubmissionStepView(
              title: material.Text(
                "Would you like to provide additional feedback based on the previous section?", //FIXME: Replace with variable
                style: material.Theme.of(context).textTheme.displayMedium,
                textAlign: material.TextAlign.center,
              ),
              resultFunction: () => InstructionStepResult(
                Identifier(
                    id: "feedbackSubmissionStep.stepIdentifier"), //FIXME: Replace with variable
                _startDate,
                DateTime.now(),
              ),
              child: material.Padding(
                padding: const material.EdgeInsets.symmetric(horizontal: 14.0),
                child: material.Text(
                  "You can enter text or submit a voice note", //FIXME: Replace with variable
                  style: material.Theme.of(context).textTheme.bodyMedium,
                  textAlign: material.TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
