import 'dart:convert';

import 'package:http/http.dart' as http;

class AiHelper {
  final String _chatGptUrl = "https://api.openai.com/v1/completions";
  final String _apiKey = "";

  final _header = {
    "Content-Type": "application/json",
    "Authorization":
        "Bearer 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",
  };

  Future<dynamic> generate(String skills, String module) async {
    final body = jsonEncode({
      "model": "text-davinci-003",
      "prompt": "$skills generate a $module section for CV based on the information given",
      "max_tokens": 4000,
      "temperature": 1.2,
      "n": 1
    });
    var response =
    await http.post(Uri.parse(_chatGptUrl), headers: _header, body: body);

    // print(response.body);
    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      return decodedResponse['choices'][0]['text'];
    }
  }

}
