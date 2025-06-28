// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_number_facts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNumberFactsModel _$GetNumberFactsModelFromJson(Map<String, dynamic> json) =>
    GetNumberFactsModel(
      text: json['text'] as String?,
      number: (json['number'] as num?)?.toInt(),
      found: json['found'] as bool?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$GetNumberFactsModelToJson(
  GetNumberFactsModel instance,
) => <String, dynamic>{
  'text': instance.text,
  'number': instance.number,
  'found': instance.found,
  'type': instance.type,
};
