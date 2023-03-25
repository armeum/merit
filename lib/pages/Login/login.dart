import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:merit_app/pages/Registration/registration.dart';
import 'package:merit_app/pages/admin/adminPage.dart';
import 'package:merit_app/screens/home/main_Page.dart';
import 'package:merit_app/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var animLoading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var phoneController = '';
  bool _obscureText = true;

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 10),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/merit.png',
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                animLoading == true
                    ? SizedBox(
                        width: 450,
                        height: 450,
                        child: Center(
                          child: Lottie.asset(
                            'assets/animation/loading2.json',
                            repeat: true,
                            reverse: true,
                            animate: true,
                          ),
                        ),
                      )
                    : Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              controller: usernameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Ismingiz',
                              ),
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            obscureText: _obscureText,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Parol',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(
                                        () {
                                      _obscureText = !_obscureText;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff1C6EAB)),
                            ),
                            child: const Text('Login'),
                            onPressed: () {
                              setState(() {
                                animLoading = true;
                              });
                              Future<http.Response> login() async {
                                final response =
                                await http.post(Uri.parse('$platformUrl/sign_in'),
                                    headers: <String, String>{
                                      'Content-Type':
                                      'application/json; charset=UTF-8',
                                    },
                                    body: jsonEncode(<String, String>{
                                      'username': usernameController.text,
                                      'password': passwordController.text,
                                    }));
                                if (kDebugMode) {
                                  print(response.body);
                                }
                                // jsonDecode(response.body)[0]['username'];
                                String token = json.decode(response.body)['token'];
                                await saveToken(token);
                                // print(getToken());
                                print(response.body);
                                if (response.statusCode == 200 && token == 'armeum') {
                                  setState(() {
                                    animLoading = false;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminPage(
                                        name: usernameController.text,
                                      ),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    animLoading = false;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainPage(
                                        name: usernameController.text,
                                      ),
                                    ),
                                  );
                                }
                                // else {
                                //   var r = json.decode(response.body)['message'];
                                //   setState(() {
                                //     message = r;
                                //   });
                                // }
                                return response;
                              }

                              login();
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Registration()),
                                );
                              },
                              child: const Text(
                                "Akauntingiz yo'qmi?",
                                style: TextStyle(
                                  color: Color(0xff1C6EAB),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
