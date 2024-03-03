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
    required this.promptText,
  }) : super(key: key);
  final String promptText;
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
          autocomplete this chat, ${widget.promptText} :
          ${(allMessages.length > 1) ? "you: " + allMessages[1].text : ""}
          user: ${m.text}
          you: (reply with whatever you want to complete here. dont reply all chats)
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

class AiChatView extends StatelessWidget {
  const AiChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatView(
        firstName: "Rohith",
        lastName: "Kumar",
        user2Name: "Odin",
        promptText: " reply like an old wise norse god");
  }
}

class UserChatView extends StatelessWidget {
  const UserChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatView(
        firstName: "Rohith",
        lastName: "Kumar",
        user2Name: "User1",
        promptText: " reply like you are my friend and we are about to study. only reply in few lines");
  }
}
