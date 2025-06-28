import 'dart:convert';

import 'package:api_integration_app/Model/get_number_facts_model/get_number_facts_model.dart';
import 'package:http/http.dart' as http;

Future<GetNumberFactsModel> getNumberFact(int number) async {
  final response = await http.get(
    Uri.parse('http://numbersapi.com/$number?json'),
  );

  final result = jsonDecode(response.body) as Map<String, dynamic>;

  return GetNumberFactsModel.fromJson(result);
}
