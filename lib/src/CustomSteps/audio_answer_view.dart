import 'package:amorc_survey_kit_local/src/CustomSteps/audio_answer_format.dart';
import 'package:amorc_survey_kit_local/src/CustomSteps/audio_question_result.dart';
import 'package:amorc_survey_kit_local/survey_kit.dart'; //TODO: See if the full surver_kit.dart import is superflous or excessive
import 'package:flutter/material.dart';

class AudioAnswerView extends StatefulWidget {
  final QuestionStep questionStep;
  final AudioQuestionResult? result;

  const AudioAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _AudioAnswerViewState createState() => _AudioAnswerViewState();
}

class _AudioAnswerViewState extends State<AudioAnswerView> {
  late final AudioChoiceAnswerFormat _textAnswerFormat;
  late final DateTime _startDate;
  late QuestionStep modifiedStep;

  late final TextEditingController _controller;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.result?.result?.toString() ?? '';
    _textAnswerFormat =
        widget.questionStep.answerFormat as AudioChoiceAnswerFormat;
    _checkValidation(_controller.text);
    _startDate = DateTime.now();
  }

  void _checkValidation(String text) {
    setState(() {
      if (_textAnswerFormat.validationRegEx != null) {
        RegExp regExp = new RegExp(_textAnswerFormat.validationRegEx!);
        _isValid = regExp.hasMatch(text);
      } else {
        _isValid = true;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => TextQuestionResult(
        id: widget.questionStep.stepIdentifier,
        startDate: _startDate,
        endDate: DateTime.now(),
        valueIdentifier: _controller.text,
        result: _controller.text,
      ),
      title: widget.questionStep.title.isNotEmpty
          ? Text(
              widget.questionStep.title,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            )
          : widget.questionStep.content,
      isValid: _isValid || widget.questionStep.isOptional,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 32.0, left: 14.0, right: 14.0),
            child: Text(
              widget.questionStep.text,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            child: TextField(
              textInputAction: TextInputAction.next,
              autofocus: true,
              decoration: textFieldInputDecoration(
                hint: _textAnswerFormat.hint,
              ),
              controller: _controller,
              textAlign: TextAlign.center,
              onChanged: (String text) {
                _checkValidation(text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
