import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'dart:core';

class AIHandler {
  final _openAI = OpenAI.instance.build(
    token: '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',
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
    ),
  );

  Future<String> getResponse(String message) async {
    try {
      final request = ChatCompleteText(
        messages: [
          //Messages(role:'user'),
          Messages(role: Role.user, content: message),
        ],
        maxToken: 200,
        model: GptTurbo0631Model(),
      );

      final response = await _openAI.onChatCompletion(request: request);
      if (response != null) {
        return response.choices[0].message!.content.trim();
      }

      return 'Some thing went wrong';
    } catch (e) {
      return e.toString();
    }
  }

  void dispose() {
    //_openAI.close();
  }
}
