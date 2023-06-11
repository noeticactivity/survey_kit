import 'package:flutter/material.dart';
import 'package:amorc_survey_kit_local/src/answer_format/double_answer_format.dart';
import 'package:amorc_survey_kit_local/src/result/question/double_question_result.dart';
import 'package:amorc_survey_kit_local/src/steps/predefined_steps/question_step.dart';
import 'package:amorc_survey_kit_local/src/views/decoration/input_decoration.dart';
import 'package:amorc_survey_kit_local/src/views/widget/step_view.dart';

class DoubleAnswerView extends StatefulWidget {
  final QuestionStep questionStep;
  final DoubleQuestionResult? result;

  const DoubleAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _DoubleAnswerViewState createState() => _DoubleAnswerViewState();
}

class _DoubleAnswerViewState extends State<DoubleAnswerView> {
  late final DoubleAnswerFormat _doubleAnswerFormat;
  late final TextEditingController _controller;
  late final DateTime _startDate;

  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _doubleAnswerFormat =
        widget.questionStep.answerFormat as DoubleAnswerFormat;
    _controller = TextEditingController();
    _controller.text = widget.result?.result?.toString() ?? '';
    _checkValidation(_controller.text);
    _startDate = DateTime.now();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkValidation(String text) {
    setState(() {
      _isValid = text.isNotEmpty && double.tryParse(text) != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => DoubleQuestionResult(
        id: widget.questionStep.stepIdentifier,
        startDate: _startDate,
        endDate: DateTime.now(),
        valueIdentifier: _controller.text,
        result: double.tryParse(_controller.text) ??
            _doubleAnswerFormat.defaultValue ??
            null,
      ),
      isValid: _isValid || widget.questionStep.isOptional,
      title: widget.questionStep.title.isNotEmpty
          ? Text(
              widget.questionStep.title,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            )
          : widget.questionStep.content,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            autofocus: true,
            decoration: textFieldInputDecoration(
              hint: _doubleAnswerFormat.hint,
            ),
            controller: _controller,
            onChanged: (String value) {
              _checkValidation(value);
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
