import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/io_client.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final rmnController =
      TextEditingController(); // Create a controller for the mobileNumber
  final uidController =
      TextEditingController(); // Create a controller for the identificationNumber
  final pwdController =
      TextEditingController(); // Create a controller for the password
  @override
  void dispose() {
    idController.dispose();
    pwdController.dispose();
    rmnController.dispose();
    uidController.dispose();
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
              children: [
                const SizedBox(
                  height: 78,
                ),
                Align(
                  alignment: Alignment.center,
                  child: const Text("StudyR",
                      style: TextStyle(
                        color: Color.fromARGB(255, 8, 7, 7),
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: const Text(
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
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 87, 76, 207),
                          ),
                          hintText: "User ID",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 101, 101),
                          ),
                        ),
                        style: TextStyle(color: Colors.black),
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
                        controller: rmnController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Color.fromARGB(255, 83, 76, 175),
                          ),
                          hintText: "Registered Moblie Number",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 101, 101),
                          ),
                        ),
                        style: TextStyle(color: Colors.black),
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
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 82, 77, 207),
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 101, 101),
                          ),
                        ),
                        style: TextStyle(color: const Color.fromARGB(255, 9, 9, 9)),
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
                        prefs.setString('username', idController.text);
                        prefs.setString('org', uidController.text);
                        prefs.setString('rmn', rmnController.text);
                        prefs.setString('password', pwdController.text);

                        var url = Uri.https('localhost:3000', '/signup');
                        var httpClient = new HttpClient();
                        httpClient.badCertificateCallback =
                            (X509Certificate cert, String host, int port) {
                          return true;
                        };
                        var ioClient = new IOClient(httpClient);

                        var response = await ioClient.post(
                          url,
                          headers: {"Content-Type": "application/json"},
                          body: jsonEncode({
                            'username': idController.text,
                            'org': uidController.text,
                            'rmn': rmnController.text,
                            'password': pwdController.text,
                          }),
                        );
                        var statusCode = response.statusCode;
                        ioClient.close();

                        if (statusCode == 200) {
                          Navigator.pushNamed(context, '/login');
                        } else {
                          print("Signup Failed");
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
                      child: const Text("Sign In",
                          style: TextStyle(
                            color: Color.fromARGB(255, 41, 93, 220),
                            fontSize: 15,
                          )),
                    ),
                  ],
                )
              ],
              scrollDirection: Axis.vertical,
            ),
          ),
        ),
      ),
    );
  }
}
