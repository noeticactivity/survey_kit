import 'package:amorc_survey_kit_local/src/CustomSteps/audio_answer_format.dart';
import 'package:amorc_survey_kit_local/src/CustomSteps/audio_question_result.dart';
import 'package:amorc_survey_kit_local/src/CustomSteps/audio_recorder_page.dart';
import 'package:amorc_survey_kit_local/survey_kit.dart'; //TODO: See if the full surver_kit.dart import is superflous or excessive
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter/foundation.dart';

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

  final GlobalKey<AudioRecorderPageState> _recorderPageKey =
      GlobalKey<AudioRecorderPageState>();
  final FlutterSoundRecorder? recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer? player = FlutterSoundPlayer();

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
      resultFunction: () => AudioQuestionResult(
        //FIXME: Replace into AudioQuestionResult
        id: widget.questionStep.stepIdentifier,
        startDate: _startDate,
        endDate: DateTime.now(),
        valueIdentifier: _controller.text,
        result: AudioResult(), //_controller.text,
        mp3Data: Uint8List(1),
        textInput: '' //FIXME: REMOVE
        ,
      ),
      title: widget.questionStep.title.isNotEmpty
          ? Text(
              widget.questionStep.title,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            )
          : widget.questionStep.content,
      //isValid: _isValid || widget.questionStep.isOptional, //FIXME: Make the button valid if user has recording
      isValid: true,
      child: Column(
        children: [
          if (widget.questionStep.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Text(
                widget.questionStep.text,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          AudioRecorderPage(
            //FIXME: Change Color of time from black to primary
            key: _recorderPageKey,
            recorder: recorder,
            player: player,
          ),
        ],
      ),
    );
  }
}
