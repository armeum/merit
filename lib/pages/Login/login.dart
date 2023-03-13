import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:merit_app/screens/home/main_Page.dart';
import 'package:merit_app/utils/url.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var message = '';
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
                Text(
                  message,
                  style: TextStyle(color: Colors.red, fontSize: 13),
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
                    obscureText: _obscureText,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                // Container(
                //   padding:
                //       const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                //   child: Column(
                //     children: [
                //       IntlPhoneField(
                //         decoration: const InputDecoration(
                //           labelText: 'Phone Number',
                //           border: OutlineInputBorder(
                //             borderSide: BorderSide(),
                //           ),
                //         ),
                //         onChanged: (phone) {
                //           phoneController = phone.completeNumber;
                //         },
                //         initialCountryCode: 'UZ',
                //         onCountryChanged: (country) {},
                //       ),
                //     ],
                //   ),
                // ),
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
                        Future<http.Response> Login() async {
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
                          String name = "hhh";
                          // jsonDecode(response.body)[0]['username'];
                          String token = json.decode(response.body)['token'];
                          print(response.body);
                          await saveToken(token);
                          // print(getToken());
                          if (response.statusCode == 200) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage(
                                        name: name,
                                      )),
                            );
                          } else {
                            var r = json.decode(response.body)['message'];
                            setState(() {
                              message = r;
                            });
                          }

                          return response;
                        }

                        Login();
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
