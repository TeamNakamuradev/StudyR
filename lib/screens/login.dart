// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:studyr/secrets.dart';
import 'package:studyr/utils/utlis.dart';

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

class LoginPage extends StatefulWidget {
  static String routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController =
      TextEditingController(); // Create a controller for the username
  final pwdController =
      TextEditingController(); // Create a controller for the password

  bool isError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isError = false;
  }

  @override
  void dispose() {
    idController.dispose();
    pwdController.dispose();
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
          Color.fromRGBO(248, 243, 243, 1),
          Color.fromARGB(255, 242, 239, 239)
        ])),
        child: SafeArea(
          child: Center(
            child: ListView(
              children: [
                const SizedBox(
                  height: 88,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Study Buddy !",
                    style: TextStyle(
                      color: Color.fromARGB(255, 12, 11, 11),
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text("Connect, Colloborate, Compete !!!",
                      style: TextStyle(
                        color: Color.fromARGB(255, 17, 8, 8),
                        fontSize: 20,
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
                        controller: pwdController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 69, 128, 215),
                          ),
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 103, 101, 101),
                          ),
                        ),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 2, 2, 2)),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 30,
                    child: isError
                        ? Text(
                            'Invalid Credentials',
                            style: TextStyle(color: Colors.red),
                          )
                        : SizedBox(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: HexColor("#295DDC"),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        setState(() {
                            isError = false;
                          });
                        var response = await http.post(
                          Uri.parse(
                            "$server_url/login",
                          ),
                          headers: {"Content-Type": "application/json"},
                          body : jsonEncode(<String, String>{
                            'username': idController.text,
                            'password': pwdController.text,
                          }),
                        );
                        
                        if (response.statusCode == 200) {
                          
                          var responseBody = jsonDecode(response.body);
                          print('Token: ${responseBody['token']}');
                          // print('UserID: ${responseBody['ID']}');

                          saveLoginDetails(
                            idController.text,
                            pwdController.text,
                            responseBody['token'],
                          );

                          Navigator.pushNamed(context, "/community");
                        } else {
                          print("Login Failed");
                          setState(() {
                            isError = true;
                          });
                        }
                      },
                      child: const Center(
                        child: Text(
                          'Sign In',
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
                    const Text("Don't have an account?",
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
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color.fromARGB(255, 41, 93, 220),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

