// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_double.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiDouble _$MultiDoubleFromJson(Map<String, dynamic> json) => MultiDouble(
      text: json['text'] as String,
      value: (json['value'] as num).toDouble(),
      type: json['type'] as String? ?? 'multi_double',
    );

Map<String, dynamic> _$MultiDoubleToJson(MultiDouble instance) =>
    <String, dynamic>{
      'text': instance.text,
      'value': instance.value,
      'type': instance.type,
    };
