import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/io_client.dart';
import 'package:studyr/screens/dashboard.dart';
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
          Color.fromRGBO(21, 21, 21, 1),
          Color.fromARGB(255, 18, 21, 16)
        ])),
        child: SafeArea(
          child: Center(
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Icon(
                //   Icons.account_circle,
                //   color: Colors.white,
                //   size: 100,
                // ),

                const SizedBox(
                  height: 88,
                ),
                Align(
                  alignment: Alignment.center,
                  child: const Text("Hello Again!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: const Text("Nice Seeing you back !!!",
                      style: TextStyle(
                        color: Color.fromARGB(255, 191, 187, 187),
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
                      padding: const EdgeInsets.only(left: 30.0),
                      child: TextField(
                        controller: idController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: const Icon(
                            Icons.person,
                            color: Colors.green,
                          ),
                          hintText: "User ID",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 101, 101),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
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
                      padding: const EdgeInsets.only(left: 30.0),
                      child: TextField(
                        controller: pwdController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 110, 130, 105),
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 103, 101, 101),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: HexColor("#295DDC"),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        // var url = Uri.https('192.168.0.101:3000',
                        //     '/auth/signin'); //If you want to check in android emulator, use your machine's IP address instead of localhost
                        // var httpClient =
                        //     new HttpClient(); // Create an HTTP client
                        // httpClient.badCertificateCallback =
                        //     (X509Certificate cert, String host, int port) {
                        //   return true; // Accept all certificates
                        // }; // remove this line in production!!!!!!!!!!!!!!!!!!!
                        // var ioClient = new IOClient(
                        //     httpClient); // Create an IOClient with the previously defined HttpClient

                        // var response = await ioClient.post(
                        //   url,
                        //   headers: {"Content-Type": "application/json"},
                        //   body: jsonEncode({
                        //     'UserID': idController.text,
                        //     'password': pwdController.text,
                        //   }),
                        // ); // Make the HTTP request

                        // var statusCode = response.statusCode;
                        // ioClient
                        //     .close(); // Close the IOClient after the request but use this only in development!!!!!!!!!!!!!!!!!!!

                        //Make the HTTP request
                        var response = await http.post(
                          Uri.parse(
                              'http://localhost:3000' + '/auth/signin'),
                          headers: {"Content-Type": "application/json"},
                          body: jsonEncode({
                            'UserID': idController.text,
                            'password': pwdController.text,
                          }),
                        );

                        print('Status Code: ${response.statusCode}');
                        print('Response Body: ${response.body}');

                        if (response.statusCode == 200) {
                          var responseBody = jsonDecode(response.body);
                          print('Token: ${responseBody['token']}');
                          print('UserID: ${responseBody['ID']}');

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('token', responseBody['token']);
                          prefs.setString('userId', responseBody['ID']);
                          prefs.setString('userName', responseBody['UserID']);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DashboardPage(userName: 'userName')));
                          // Rest of your code for handling success
                        } else {
                          // Handle failure
                          print("Login Failed");
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
                      child: const Text("Sign Up",
                          style: TextStyle(
                            color: Color.fromARGB(255, 41, 93, 220),
                            fontSize: 15,
                          )),
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
