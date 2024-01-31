import 'package:flutter/material.dart';
import 'package:amorc_survey_kit_local/src/answer_format/single_choice_answer_format.dart';
import 'package:amorc_survey_kit_local/src/answer_format/text_choice.dart';
import 'package:amorc_survey_kit_local/src/result/question/single_choice_question_result.dart';
import 'package:amorc_survey_kit_local/src/steps/predefined_steps/question_step.dart';
import 'package:amorc_survey_kit_local/src/views/widget/selection_list_tile.dart';
import 'package:amorc_survey_kit_local/src/views/widget/step_view.dart';

class SingleChoiceAnswerView extends StatefulWidget {
  final QuestionStep questionStep;
  final SingleChoiceQuestionResult? result;

  const SingleChoiceAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _SingleChoiceAnswerViewState createState() => _SingleChoiceAnswerViewState();
}

class _SingleChoiceAnswerViewState extends State<SingleChoiceAnswerView> {
  late final DateTime _startDate;
  late final SingleChoiceAnswerFormat _singleChoiceAnswerFormat;
  TextChoice? _selectedChoice;

  @override
  void initState() {
    super.initState();
    _singleChoiceAnswerFormat =
        widget.questionStep.answerFormat as SingleChoiceAnswerFormat;
    _selectedChoice =
        widget.result?.result ?? _singleChoiceAnswerFormat.defaultSelection;
    _startDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => SingleChoiceQuestionResult(
        id: widget.questionStep.stepIdentifier,
        startDate: _startDate,
        endDate: DateTime.now(),
        valueIdentifier: _selectedChoice?.value ?? '',
        result: _selectedChoice,
      ),
      isValid: widget.questionStep.isOptional || _selectedChoice != null,
      title: widget.questionStep.title.isNotEmpty
          ? Text(
              widget.questionStep.title,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            )
          : widget.questionStep.content,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Text(
                widget.questionStep.text,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: [
                Divider(
                  color: Colors.grey,
                ),
                ..._singleChoiceAnswerFormat.textChoices.map(
                  (TextChoice tc) {
                    return SelectionListTile(
                      text: tc.text,
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

                // Add the "other" option field if enabled
                if (_singleChoiceAnswerFormat.otherField) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: ListTile(
                      title: TextField(
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              _selectedChoice = TextChoice(
                                text: _singleChoiceAnswerFormat
                                    .otherFieldHintText,
                                value: value,
                              );
                            } else {
                              // Clear selection if input is empty
                              if (_selectedChoice?.text ==
                                  _singleChoiceAnswerFormat
                                      .otherFieldHintText) {
                                _selectedChoice = null;
                              }
                            }
                          });
                        },
                        decoration: InputDecoration(
                          labelText: _singleChoiceAnswerFormat
                              .otherFieldLocalizedValue,
                          hintText: _singleChoiceAnswerFormat
                              .otherFieldHintText, //'Write other information here',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey),
                ],

                // Add any extra in-line option field if enabled
                if (_singleChoiceAnswerFormat.inLineTextEntryField) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: ListTile(
                      title: TextField(
                        onChanged: (value) {
                          setState(() {
                            if (value.isNotEmpty) {
                              _selectedChoice = TextChoice(
                                text: _singleChoiceAnswerFormat
                                    .otherFieldHintText,
                                value: value,
                              );
                            } else {
                              // Clear selection if input is empty
                              if (_selectedChoice?.text ==
                                  _singleChoiceAnswerFormat
                                      .otherFieldHintText) {
                                _selectedChoice = null;
                              }
                            }
                          });
                        },
                        decoration: InputDecoration(
                          labelText: _singleChoiceAnswerFormat
                              .inLineTextEntryFieldLocalizedValue,
                          hintText: _singleChoiceAnswerFormat
                              .inLineTextEntryFieldHintText, //'Write other information here',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
