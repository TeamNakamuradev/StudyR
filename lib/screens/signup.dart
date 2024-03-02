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
          Color.fromRGBO(21, 21, 21, 1),
          Color.fromARGB(255, 18, 21, 16)
        ])),
        child: SafeArea(
          child: Center(
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Icon(
                //   Image(image: ),
                //   color: Colors.white,
                //   size: 100,
                // ),
//******************change size if a problem occurs ****************
                const SizedBox(
                  height: 78,
                ),
                Align(
                  alignment: Alignment.center,
                  child: const Text("Hello There!",
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
                  child: const Text("Our connection will last a lifetime !!!",
                      style: TextStyle(
                        color: Color.fromARGB(255, 191, 187, 187),
                        fontSize: 15,
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
                        controller: uidController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: const Icon(
                            LineIcons.globe,
                            color: Colors.green,
                          ),
                          hintText: "Org ID",
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
                        controller: rmnController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: const Icon(
                            Icons.phone,
                            color: Colors.green,
                          ),
                          hintText: "Regestered Moblie Number",
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

                        var url = Uri.https('localhost:3000', '/signup'); //If you want to check in android emulator, use your machine's IP address instead of localhost
                        var httpClient =
                            new HttpClient(); // Create an HTTP client
                        httpClient.badCertificateCallback =
                            (X509Certificate cert, String host, int port) {
                          return true; // Accept all certificates
                        }; // remove this line in production!!!!!!!!!!!!!!!!!!!
                        var ioClient = new IOClient(
                            httpClient); // Create an IOClient with the previously defined HttpClient

                        var response = await ioClient.post(
                          url,
                          headers: {"Content-Type": "application/json"},
                          body: jsonEncode({
                            'username': idController.text,
                            'org': uidController.text,
                            'rmn': rmnController.text,
                            'password': pwdController.text,
                          }),

                        ); // Make the HTTP request
                        var statusCode = response.statusCode;
                        ioClient.close();

                        // Handle the response status code or other logic here
                        if (statusCode == 200) {
                          Navigator.pushNamed(context, '/login');
                          // var token = jsonDecode(response.body)['token'];
                        } else {
                          print("Signup Failed");//*******************make this a pop up message *************
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
