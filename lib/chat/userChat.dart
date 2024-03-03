import 'dart:convert';
import 'package:studyr/chat/constant.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';

Future<void> _launchInWebView(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
    throw Exception('Could not launch $url');
  }
}

_launchURL() async {
  final Uri url = Uri.parse('https://flutter.dev');
  if (await canLaunch(url.toString())) {
    await launch(url.toString());
  } else {
    throw Exception('Could not launch ${url}');
  }
}

class UserChatView extends StatefulWidget {
  const UserChatView({Key? key}) : super(key: key);

  @override
  State<UserChatView> createState() => _UserChatViewState();
}

class _UserChatViewState extends State<UserChatView> {
  ChatUser human = ChatUser(id: '1', firstName: 'Rohith', lastName: 'Kumar');
  ChatUser bot = ChatUser(id: '2', firstName: 'User');
  final url = Constant().baseUrl + Constant().apiKey;
  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];

  final header = {'Content-Type': 'application/json'};

  getMessages(ChatMessage m) async {
    allMessages.insert(0, m);
    typing.add(bot);
    setState(() {});
    var promptText = """
          autocomplete this chat reply like you are my friend and we are about to study. only reply in few lines :
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.video_call,
              color: Colors.green,
            ),
            onPressed: () {
              // do something
              launchUrl(
                Uri.parse('https://meet.google.com/new'),
              );
            },
          )
        ],
      ),
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
