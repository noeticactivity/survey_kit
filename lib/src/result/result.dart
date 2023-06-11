import 'package:equatable/equatable.dart';
import '/src/steps/identifier/identifier.dart';

abstract class Result extends Equatable {
  final Identifier? id;
  final DateTime startDate;
  final DateTime endDate;

  Result({
    required this.id,
    required this.startDate,
    required this.endDate,
  });
}
