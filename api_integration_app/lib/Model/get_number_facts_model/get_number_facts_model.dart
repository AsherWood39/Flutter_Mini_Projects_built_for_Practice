import 'package:json_annotation/json_annotation.dart';

part 'get_number_facts_model.g.dart';

@JsonSerializable()
class GetNumberFactsModel {
  @JsonKey(name: 'text')
  String? text;
  @JsonKey(name: 'number')
  int? number;
  @JsonKey(name: 'found')
  bool? found;
  @JsonKey(name: 'type')
  String? type;

  GetNumberFactsModel({this.text, this.number, this.found, this.type});

  factory GetNumberFactsModel.fromJson(Map<String, dynamic> json) {
    return _$GetNumberFactsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetNumberFactsModelToJson(this);
}
