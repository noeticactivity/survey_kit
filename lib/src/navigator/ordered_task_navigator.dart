import 'package:amorc_survey_kit_local/src/navigator/task_navigator.dart';
import 'package:amorc_survey_kit_local/src/result/question_result.dart';
import 'package:amorc_survey_kit_local/src/steps/step.dart';
import 'package:amorc_survey_kit_local/src/task/task.dart';

class OrderedTaskNavigator extends TaskNavigator {
  OrderedTaskNavigator(Task task) : super(task);

  @override
  Step? nextStep({required Step step, QuestionResult? questionResult}) {
    record(step);
    return nextInList(step);
  }

  @override
  Step? previousInList(Step step) {
    final currentIndex = task.steps
        .indexWhere((element) => element.stepIdentifier == step.stepIdentifier);
    return (currentIndex - 1 < 0) ? null : task.steps[currentIndex - 1];
  }

  @override
  Step? firstStep() {
    final previousStep = peekHistory();
    return previousStep == null
        ? task.initalStep ?? task.steps.first
        : nextInList(previousStep);
  }
}
