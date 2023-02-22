import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:merit_app/screens/client/clients.dart';

class CreateClient extends StatefulWidget {
  @override
  State<CreateClient> createState() => _CreateClientState();
}

class _CreateClientState extends State<CreateClient> {
  var clientNameController = '';
  var phoneController = '';

  var regionController = "";

  var items = [
    "Tashkent",
    "Ferghana",
    "Samarqand",
    "Qashqadaryo",
    "Andijon",
    "Namangan",
    "Buxoro",
    "Navoiy",
    "Jizzax",
    "Sirdaryo",
    "Surxondaryo",
    "Xorazm",
  ];

  String? value;

  @override
  Widget build(BuildContext context) {
    DropdownMenuItem<String> buildMenuItem(String item) =>
        DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: Theme.of(context).textTheme.bodyText1),
        );

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 45,
                  bottom: 15,
                ),
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Asr Kimya',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      onChanged: (value) => {
                        clientNameController = value,
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Client Name',
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: Column(
                        children: [
                          IntlPhoneField(
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            onChanged: (value) => {
                              phoneController = value as String,
                            },
                            initialCountryCode: 'UZ',
                            onCountryChanged: (country) {
                              print('Country changed to: ${country.name}');
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            isExpanded: true,
                            value: value,
                            iconSize: 36,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            items: items.map(buildMenuItem).toList(),
                            onChanged: (value) {
                              setState(() {
                                this.value = value;

                                regionController = value as String;
                              });
                            }),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        if (clientNameController.isEmpty ||
                            clientNameController.isEmpty ||
                            phoneController == '') {
                          print("tanlang");
                        } else {
                          Future<http.Response> createClient() async {
                            final response = await http.post(
                                Uri.parse(
                                    'http://127.0.0.1:8000/create_client'),
                                headers: <String, String>{
                                  'Accept': 'application/json',
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(<String, String>{
                                  'name': clientNameController,
                                  'region': regionController,
                                  'phone': phoneController
                                }));

                            print(response.body);
                            if (response.statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientList(),
                                ),
                              );
                            }

                            return response;
                          }

                          createClient();
                        }
                      },
                      child: Text(
                        'Create Client',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
