import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:avoid_keyboard/avoid_keyboard.dart';
import '../../screens/home/mainPage.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String message = '';
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      // title: Text("Login", style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 35),),
    );
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
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
                      controller: phoneController,
                      onChanged: (phone) {
                        print(phone.completeNumber);
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
                      if (usernameController.text == '' ||
                          passwordController.text == "" ||
                          phoneController.text == '') {
                        setState(() {
                          message = 'Please fill all fields';
                        });
                      } else {
                        Future<http.Response> createAlbum() async {
                          final response = await http.post(
                              Uri.parse('http://localhost:8080/create_user'),
                              headers: <String, String>{
                                'Content-Type':
                                'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, String>{
                                'username': usernameController.text,
                                'password': passwordController.text,
                                'phone': phoneController.text,
                              }));

                          String name = jsonDecode(response.body)['username'];

                          print(response.body);
                          if (response.statusCode == 200) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage(
                                    name: name,
                                  )),
                            );
                          }

                          return response;
                          // var res =  http.post(
                          //   Uri.parse('http://localhost:8080/create_user'),
                          //   headers: <String, String>{
                          //     'Content-Type': 'application/json; charset=UTF-8',
                          //   },
                          //   body: jsonEncode(<String, String>{
                          //     'username': usernameController.text,
                          //     'password': passwordController.text,
                          //     'phone': phoneController.text,
                          //   }),
                          // );

                          //  print(await res);
                          // return res;
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
