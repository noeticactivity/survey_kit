// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markdown_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkdownContent _$MarkdownContentFromJson(Map<String, dynamic> json) =>
    MarkdownContent(
      text: json['text'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$MarkdownContentToJson(MarkdownContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
    };