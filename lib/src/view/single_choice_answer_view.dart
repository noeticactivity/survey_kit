import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/option.dart';
import 'package:survey_kit/src/model/answer/single_select_answer.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/content/content_widget.dart';
import 'package:survey_kit/src/view/selection_list_tile.dart';
import 'package:survey_kit/src/view/step_view.dart';

class SingleChoiceAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const SingleChoiceAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _SingleChoiceAnswerViewState createState() => _SingleChoiceAnswerViewState();
}

class _SingleChoiceAnswerViewState extends State<SingleChoiceAnswerView>
    with MeasureDateStateMixin {
  late final SingleSelectAnswer _singleChoiceAnswerFormat;
  Option? _selectedChoice;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answer;
    if (answer == null) {
      throw Exception('SingleSelectAnswer is null');
    }
    _singleChoiceAnswerFormat = answer as SingleSelectAnswer;
    _selectedChoice = widget.result?.result as Option? ??
        _singleChoiceAnswerFormat.defaultSelection;
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => StepResult<Option>(
        id: widget.questionStep.id,
        startTime: startDate,
        endTime: DateTime.now(),
        valueIdentifier: _selectedChoice?.value ?? '',
        result: _selectedChoice,
      ),
      isValid: !widget.questionStep.isMandatory || _selectedChoice != null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: ContentWidget(
                content: widget.questionStep.content,
              ),
            ),
            Column(
              children: [
                const Divider(
                  color: Colors.grey,
                ),
                ..._singleChoiceAnswerFormat.options.map(
                  (Option tc) {
                    return SelectionListTile(
                      text: tc.value,
                      onTap: () {
                        if (_selectedChoice == tc) {
                          _selectedChoice = null;
                        } else {
                          _selectedChoice = tc;
                        }
                        setState(() {});
                      },
                      isSelected: _selectedChoice == tc,
                    );
                  },
                ).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}