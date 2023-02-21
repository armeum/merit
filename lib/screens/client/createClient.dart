import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class CreateClient extends StatefulWidget {
  @override
  State<CreateClient> createState() => _CreateClientState();
}

class _CreateClientState extends State<CreateClient> {
  final _nameController = TextEditingController();
  final _regionController = TextEditingController();

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

  void _submitData() {
    final enteredName = _nameController.text;
    final selectedRegion = double.parse(_regionController.text);
  }

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
                            color: Theme.of(context).accentColor,
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
                      controller: _nameController,
                      onSubmitted: (_) => _submitData(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Client Name',
                      ),
                    ),
                    SizedBox(height: 30),
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
                          onChanged: (value) =>
                              setState(() => this.value = value),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: _submitData,
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
