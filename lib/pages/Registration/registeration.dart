import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:avoid_keyboard/avoid_keyboard.dart';
import 'package:merit_app/utils/url.dart';
import '../../screens/home/mainPage.dart';
import '../Login/login.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String message = '';
  bool isVisible = false;
  final _formKey = GlobalKey<FormState>();
  var usernameController = '';
  var passwordController = '';
  var phoneController = '';
  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      // title: Text("Login", style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 35),),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/merit.png',
                    width: MediaQuery.of(context).size.width * 0.55,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.copyWith(fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (aa) {
                      usernameController = aa;
                    },
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
                    onChanged: (value) {
                      passwordController = value;
                      print(value);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      IntlPhoneField(
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        onChanged: (phone) {
                          phoneController = phone.completeNumber;
                        },
                        initialCountryCode: 'UZ',
                        onCountryChanged: (country) {
                          print('Country changed to: ${country.name}');
                        },
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.all(5),
                //   child: Center(
                //     child: Text(
                //       message,
                //       style: TextStyle(fontSize: 25, color: Colors.red),
                //     ),
                //   ),
                // ),
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Register'),
                      onPressed: () {
                        print(usernameController);
                        print(passwordController);
                        print(phoneController);
                        if (usernameController == '' ||
                            passwordController == "" ||
                            phoneController == '') {
                          setState(() {
                            message = 'Please fill all fields';
                          });
                        } else {
                          Future<http.Response> createAlbum() async {
                            final response = await http.post(
                                Uri.parse('$platformUrl/create_user'),
                                headers: <String, String>{
                                  "Accept": 'application/json',
                                  'Content-Type':
                                  'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(<String, String>{
                                  'name': usernameController,
                                  'password': passwordController,
                                  'phone': phoneController,
                                }));

                            print(response.body);
                            print(response.statusCode);
                            if (response.statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>MainPage(name: usernameController) ),
                              );
                            }
                            return response;
                          }
                          createAlbum();
                        }
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
