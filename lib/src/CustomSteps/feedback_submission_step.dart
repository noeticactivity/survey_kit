import 'package:amorc_survey_kit_local/survey_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedBackSubmissionStepView extends StatelessWidget {
  final Widget title;
  final Widget child;
  final QuestionResult Function() resultFunction;
  final bool isValid;
  final SurveyController? controller;

  const FeedBackSubmissionStepView({
    required this.child,
    required this.title,
    required this.resultFunction,
    this.controller,
    this.isValid = true,
  });

  @override
  Widget build(BuildContext context) {
    final _surveyController = controller ?? context.read<SurveyController>();

    return _content(_surveyController, context);
  }

  Widget _content(SurveyController surveyController, BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: title,
                ),
                child,
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  //padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: OutlinedButton(
                    onPressed: isValid //|| step.isOptional
                        ? () =>
                            surveyController.nextStep(context, resultFunction)
                        : null,
                    child: Text(
                      'Text', //FIXME: LOCALIZE THIS
                      style: TextStyle(
                        color: isValid
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: OutlinedButton(
                    onPressed: isValid //|| step.isOptional
                        ? () =>
                            surveyController.nextStep(context, resultFunction)
                        : null,
                    child: Text(
                      'Voice Note', //FIXME: LOCALIZE THIS
                      style: TextStyle(
                        color: isValid
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: isValid //|| step.isOptional
                      ? () => surveyController.nextStep(context, resultFunction)
                      : null,
                  child: Text(
                    'No, Thank You', //FIXME: LOCALIZE THIS
                    style: TextStyle(
                      color: isValid
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
