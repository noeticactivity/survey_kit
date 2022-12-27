import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/_new/model/answer/multi_select_answer.dart';
import 'package:survey_kit/src/_new/model/answer/option.dart';
import 'package:survey_kit/src/_new/model/result/step_result.dart';
import 'package:survey_kit/src/_new/model/step.dart';
import 'package:survey_kit/src/_new/view/content/content_widget.dart';
import 'package:survey_kit/src/_new/view/selection_list_tile.dart';
import 'package:survey_kit/src/_new/view/step_view.dart';

class MultipleChoiceAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult<List<Option>>? result;

  const MultipleChoiceAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _MultipleChoiceAnswerView createState() => _MultipleChoiceAnswerView();
}

class _MultipleChoiceAnswerView extends State<MultipleChoiceAnswerView> {
  late final DateTime _startDateTime;
  late final MultiSelectAnswer _multipleChoiceAnswer;

  List<Option> _selectedChoices = [];

  @override
  void initState() {
    super.initState();
    _multipleChoiceAnswer = widget.questionStep as MultiSelectAnswer;
    _selectedChoices = (widget.result?.result ??
        _multipleChoiceAnswer.defaultSelection) as List<Option>;
    _startDateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => StepResult<List<Option>>(
        id: widget.questionStep.id,
        startTime: _startDateTime,
        endTime: DateTime.now(),
        valueIdentifier:
            _selectedChoices.map((choices) => choices.value).join(','),
        result: _selectedChoices,
      ),
      isValid: !widget.questionStep.isMandatory || _selectedChoices.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            ContentWidget(
              content: widget.questionStep.content,
            ),
            Column(
              children: [
                const Divider(
                  color: Colors.grey,
                ),
                ..._multipleChoiceAnswer.options
                    .map(
                      (Option tc) => SelectionListTile(
                        text: tc.value,
                        onTap: () {
                          setState(
                            () {
                              if (_selectedChoices.contains(tc)) {
                                _selectedChoices.remove(tc);
                              } else {
                                _selectedChoices = [..._selectedChoices, tc];
                              }
                            },
                          );
                        },
                        isSelected: _selectedChoices.contains(tc),
                      ),
                    )
                    .toList(),
                if (_multipleChoiceAnswer.otherField) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: ListTile(
                      title: TextField(
                        onChanged: (v) {
                          int? currentIndex;
                          final otherTextChoice = _selectedChoices
                              .firstWhereIndexedOrNull((index, element) {
                            final isOtherField = element.value == 'Other';

                            if (isOtherField) {
                              currentIndex = index;
                            }

                            return isOtherField;
                          });

                          setState(() {
                            if (v.isEmpty && otherTextChoice != null) {
                              _selectedChoices.remove(otherTextChoice);
                            } else if (v.isNotEmpty) {
                              final updatedTextChoice =
                                  Option(id: 'Other', value: v);
                              if (otherTextChoice == null) {
                                _selectedChoices.add(updatedTextChoice);
                              } else if (currentIndex != null) {
                                _selectedChoices[currentIndex!] =
                                    updatedTextChoice;
                              }
                            }
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Other',
                          labelStyle: Theme.of(context).textTheme.headlineSmall,
                          hintText: 'Write other information here',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}