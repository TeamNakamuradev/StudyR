import 'dart:convert';
import 'package:studyr/chat/constant.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatView extends StatefulWidget {
  const ChatView({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.user2Name,
    required this.pdfText,
  }) : super(key: key);
  final String pdfText;
  final String firstName;
  final String lastName;
  final String user2Name;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late ChatUser human;
  late ChatUser bot;
  final url = Constant().baseUrl + Constant().apiKey;
  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];

  final header = {'Content-Type': 'application/json'};

  getMessages(ChatMessage m) async {
    allMessages.insert(0, m);
    typing.add(bot);
    setState(() {});
    var promptText = """
          pdf text: `${widget.pdfText}`

          question: `${allMessages[0]}`

          Answer the question based on given pdf text above.
    """;
    var data = {
      "contents": [
        {
          "parts": [
            {"text": promptText}
          ]
        }
      ]
    };
    await http
        .post(Uri.parse(url), headers: header, body: jsonEncode(data))
        .then((value) {
      if (value.statusCode == 200) {
        var response = jsonDecode(value.body);
        ChatMessage m2 = ChatMessage(
          user: bot,
          text: response['candidates'][0]['content']['parts'][0]['text'],
          createdAt: DateTime.now(),
        );
        allMessages.insert(0, m2);
      }
    }).catchError((e) {});
    typing.remove(bot);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    human = ChatUser(
        id: '1', firstName: widget.firstName, lastName: widget.lastName);
    bot = ChatUser(id: '2', firstName: widget.user2Name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashChat(
        scrollToBottomOptions: ScrollToBottomOptions(disabled: false),
        typingUsers: typing,
        currentUser: human,
        onSend: (ChatMessage message) {
          getMessages(message);
        },
        messages: allMessages,
      ),
    );
  }
}
  