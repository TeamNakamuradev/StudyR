import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studyr/secrets.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class SignupPage extends StatefulWidget {
  static String routeName = '/signup';
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final idController =
      TextEditingController(); // Create a controller for the username
  final pwdController =
      TextEditingController(); // Create a controller for the password
  final fnameController = TextEditingController();

  void showSignupFailedPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Signup Failed'),
          content: Text('There was an error during signup.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    idController.dispose();
    pwdController.dispose();
    fnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#191919"),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(238, 235, 235, 1),
          Color.fromARGB(255, 234, 239, 231)
        ])),
        child: SafeArea(
          child: Center(
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              scrollDirection: Axis.vertical,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 78,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text("StudyR",
                      style: TextStyle(
                        color: Color.fromARGB(255, 8, 7, 7),
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                      "Match Academic Spirits and unlock the power of wisdom !!!",
                      style: TextStyle(
                        color: Color.fromARGB(255, 8, 4, 4),
                        fontSize: 12,
                      )),
                ),
                const SizedBox(
                  height: 28,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("#2B2B2B"),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: TextField(
                        controller: idController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 87, 76, 207),
                          ),
                          hintText: "User ID",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 101, 101),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("#2B2B2B"),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: TextField(
                        controller: fnameController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Color.fromARGB(255, 83, 76, 175),
                          ),
                          hintText: "Name",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 101, 101),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor("#2B2B2B"),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: TextField(
                        controller: pwdController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 82, 77, 207),
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 101, 101),
                          ),
                        ),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 9, 9, 9)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 27,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: HexColor("#295DDC"),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        // prefs.setString('username', idController.text);
                        // prefs.setString('fullname', fnameController.text);
                        // prefs.setString('password', pwdController.text);

                        var url = Uri.parse("$server_url/register");
                        // var httpClient = HttpClient();
                        // httpClient.badCertificateCallback =
                        //     (X509Certificate cert, String host, int port) {
                        //   return true;
                        // };
                        // var ioClient = IOClient(httpClient);

                        var response = await http.post(
                          url,
                          headers: {"Content-Type": "application/json"},
                          body: jsonEncode({
                            'username': idController.text,
                            'name': fnameController.text,
                            'password': pwdController.text,
                          }),
                        );
                        var statusCode = response.statusCode;

                        if (statusCode == 200) {
                          Navigator.pushNamed(context, '/login');
                        } else {
                          print("Signup Failed");
                          showSignupFailedPopup(context);
                          
                        }
                      },
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already with us?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 191, 187, 187),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Color.fromARGB(255, 41, 93, 220),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
