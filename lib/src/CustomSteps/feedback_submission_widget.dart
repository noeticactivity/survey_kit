import 'package:amorc_survey_kit_local/survey_kit.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

class FeedbackSubmissionStep extends InstructionStep {
  String title = 'title';
  String text = 'text';
  StepIdentifier id;
  //final InstructionStep feedbackStep;

  FeedbackSubmissionStep({
    required this.title,
    required this.text,
    required this.id,
  }) : super(
            title: "feedbackStep.title",
            text: "feedbackStep.text",
            stepIdentifier: id);

  @override
  List<Object?> get props => [title, text];

  @override
  material.Widget createView(
      {required QuestionResult<dynamic>? questionResult}) {
    return FeedbackSubmission(feedbackSubmissionId: id);
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class FeedbackSubmission extends material.StatelessWidget {
  StepIdentifier feedbackSubmissionId;
  DateTime _startDate;

  //FeedbackSubmission();
  FeedbackSubmission({required this.feedbackSubmissionId})
      : _startDate = DateTime.now();

  @override
  material.Widget build(material.BuildContext context) {
    return material.Container(
      child: material.Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          material.Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FeedBackSubmissionStepView(
              title: material.Text(
                "Would you like to provide additional feedback based on the previous section?", //FIXME: Replace with variable
                style: material.Theme.of(context).textTheme.displayMedium,
                textAlign: material.TextAlign.center,
              ),
              resultFunction: () => InstructionStepResult(
                Identifier(
                    id: feedbackSubmissionId.id), //FIXME: Replace with variable
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
          )),
        ],
      ),
    );
  }
}
