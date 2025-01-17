import 'package:flutter_test/flutter_test.dart';
import 'package:amorc_survey_kit_local/survey_kit.dart';

void main() {
  final tResult = InstructionStepResult(
    Identifier(id: 'example1'),
    DateTime(2022, 8, 12, 16, 4),
    DateTime(2022, 8, 12, 16, 14),
  );

  group('serialisation', () {
    test(
      'should work with valid example',
      () async {
        final encodedResult = tResult.toJson();
        final decodedResult = InstructionStepResult.fromJson(encodedResult);
        expect(tResult, decodedResult);
      },
    );
  });
}
