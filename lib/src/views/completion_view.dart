import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:amorc_survey_kit_local/src/result/step/completion_step_result.dart';
import 'package:amorc_survey_kit_local/src/steps/predefined_steps/completion_step.dart';
import 'package:amorc_survey_kit_local/src/views/widget/step_view.dart';

class CompletionView extends StatelessWidget {
  final CompletionStep completionStep;
  final DateTime _startDate = DateTime.now();
  final String assetPath;

  CompletionView({required this.completionStep, this.assetPath = ""});

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: completionStep,
      resultFunction: () => CompletionStepResult(
        completionStep.stepIdentifier,
        _startDate,
        DateTime.now(),
      ),
      title: Text(completionStep.title,
          style: Theme.of(context).textTheme.displayMedium),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        child: Column(
          children: [
            Text(
              completionStep.text,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Container(
                width: 150.0,
                height: 150.0,
                child: assetPath.isNotEmpty
                    ? Lottie.asset(
                        assetPath,
                        repeat: false,
                      )
                    : LottieBuilder.network(
                        'https://assets7.lottiefiles.com/datafiles/qojl0Ru04es0pqq/data.json',
                        width: 150.0,
                        height: 150.0,
                        repeat: false,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
