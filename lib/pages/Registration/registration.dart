import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:merit_app/utils/url.dart';

import '../../screens/home/main_page.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String message = '';
  bool isVisible = false;
  var usernameController = '';
  var passwordController = '';
  var phoneController = '';
  var statusMessage = '';
  bool _obscureText = true;
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
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
                          .displayLarge
                          ?.copyWith(fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      statusMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 15),
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
                    obscureText: _obscureText,
                    enableSuggestions: false,
                    autocorrect: false,
                    onChanged: (value) {
                      passwordController = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        )),
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
                        onCountryChanged: (country) {},
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Register'),
                      onPressed: () {
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

                            if (response.statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MainPage(name: usernameController)),
                              );
                            } else {
                              var r = json.decode(response.body)['message'];
                              print(r);
                              setState(() {
                                statusMessage = r;
                              });
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
