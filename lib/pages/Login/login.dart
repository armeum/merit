import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merit_app/screens/home/main_Page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var message = '';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SizedBox(
        height: (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top),
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
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(message),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password',
                  ),
                ),
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        Future<http.Response> createAlbum() async {
                          final response = await http.post(
                              Uri.parse('http://localhost:8080/sign_in'),
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, String>{
                                'username': usernameController.text,
                                'password': passwordController.text,
                              }));

                          String name =
                              jsonDecode(response.body)[0]['username'];
                          if (response.statusCode == 200) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage(
                                        name: name,
                                      )),
                            );
                          } else {
                            setState(() {
                              message = 'User does not exist';
                            });
                          }

                          return response;
                        }

                        createAlbum();
                      },
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
