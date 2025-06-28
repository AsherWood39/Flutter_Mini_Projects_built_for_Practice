import 'package:api_integration_app/API/api.dart';
import 'package:flutter/material.dart';

class ScreenApiHome extends StatefulWidget {
  const ScreenApiHome({super.key});

  @override
  State<ScreenApiHome> createState() => _ScreenApiHomeState();
}

class _ScreenApiHomeState extends State<ScreenApiHome> {
  final apiNumberController = TextEditingController();

  String? text;

  int? number;

  bool? found;

  String? trivia;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: apiNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter a number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final result = await getNumberFact(
                    int.parse(apiNumberController.text),
                  );
                  setState(() {
                    text = result.text;
                    number = result.number;
                    found = result.found;
                    trivia = result.type;
                  });
                },
                child: Text('Get the Number Facts'),
              ),
              Divider(),
              Text('Text Data:${text ?? ''}'),
              SizedBox(height: 20),
              Text('Number Data:${number ?? ''}'.toString()),
              SizedBox(height: 20),
              Text('Boolean Data:${found ?? ''}'.toString()),
              SizedBox(height: 20),
              Text('Trivia Data:${trivia ?? ''}'),
            ],
          ),
        ),
      ),
    );
  }
}
