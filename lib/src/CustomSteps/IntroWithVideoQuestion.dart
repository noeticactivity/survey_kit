import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:amorc_survey_kit_local/survey_kit.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

abstract class QuestionResultNew<T> extends Result {
  final T? result;
  final String? valueIdentifier;
  QuestionResultNew({
    required Identifier? id,
    required DateTime startDate,
    required DateTime endDate,
    required this.valueIdentifier,
    required this.result,
  }) : super(id: id, startDate: startDate, endDate: endDate);
}

class CustomResult extends QuestionResult<String> {
  final String valueIdentifier;
  final Identifier identifier;
  final String value;

  CustomResult(
    this.valueIdentifier,
    this.identifier,
    this.value,
    DateTime startDate,
    DateTime endDate,
  ) : super(
            id: identifier,
            valueIdentifier: valueIdentifier,
            result: value,
            startDate: startDate,
            endDate: endDate); //Custom value

  @override
  List<Object?> get props => [identifier, valueIdentifier, value];
}

class IntroWithVideoStep extends InstructionStep {
  final String title = 'title';
  final String text = 'text';
  final InstructionStep introStep; // Assuming this is a property

  IntroWithVideoStep({required StepIdentifier id, required this.introStep})
      : super(title: introStep.title, text: introStep.text);

  @override
  List<Object?> get props => [title, text, introStep];

  @override
  material.Widget createView(
      {required QuestionResult<dynamic>? questionResult}) {
    return InstructionViewWithVideo(
      instructionStep: introStep,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class InstructionViewWithVideo extends material.StatelessWidget {
  final InstructionStep instructionStep;
  final DateTime _startDate = DateTime.now();

  final _controller = YoutubePlayerController.fromVideoId(
    videoId: 'TRG1GzkFiB0',
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  InstructionViewWithVideo({required this.instructionStep});

  @override
  material.Widget build(material.BuildContext context) {
    return material.Container(
      child: material.Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //FIXME: TEMP Removing the video
          // YoutubePlayer(
          //   controller: _controller,
          //   aspectRatio: 16 / 9,
          // ),
          material.Image.asset(
            'assets/AMORC_Symbol.png',
            width: 200,
            height: 300,
            //fit: BoxFit.cover,
          ),
          material.Expanded(
            child: StepView(
              step: instructionStep,
              title: material.Text(
                instructionStep.title,
                style: material.Theme.of(context).textTheme.displayMedium,
                textAlign: material.TextAlign.center,
              ),
              resultFunction: () => InstructionStepResult(
                instructionStep.stepIdentifier,
                _startDate,
                DateTime.now(),
              ),
              child: material.Padding(
                padding: const material.EdgeInsets.symmetric(horizontal: 14.0),
                child: material.Text(
                  instructionStep.text,
                  style: material.Theme.of(context).textTheme.bodyMedium,
                  textAlign: material.TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
