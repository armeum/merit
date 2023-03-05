import 'dart:convert' as convert;

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:merit_app/order/ordersList.dart';
import 'package:merit_app/utils/url.dart';
import 'package:merit_app/widgets/constants.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  TextEditingController amountInput = TextEditingController();
  TextEditingController dateInput = TextEditingController();

  var clientList = [];

  late List<dynamic> items = [];
  late List<dynamic> products = [];
  String? selectedValue;
  String? productValue;

  void fetchData() async {
    var response = await http.get(Uri.parse('$platformUrl/all_clients'));
    var arr = convert.jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (var i = 0; i < arr.length; i++) {
        items.add(arr[i]['name']);
      }
    }
  }

  void getProducts() {
    var productList = elements;
    for (var i = 0; i < productList.length; i++) {
      products.add(productList[i]['name']);
    }
  }

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
    fetchData();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Create Order"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: dateInput,
                  //editing controller of this TextField
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Date", //label text of field
                    suffixIcon: Icon(Icons.calendar_today), //icon of text field
                  ),
                  readOnly: true,

                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      //pickedDate output format => 2021-03-10 00:00:00.000
                      String? formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                      //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dateInput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: amountInput,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.scale),
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Icon(
                            Icons.list,
                            size: 18,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Clients',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 55,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.white,
                        ),
                        elevation: 1,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.black54,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        // width: 200,
                        padding: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        elevation: 8,
                        // offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility:
                              MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Icon(
                            Icons.list,
                            size: 18,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              'Products',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: products
                          .map((product) => DropdownMenuItem<String>(
                                value: product,
                                child: Text(
                                  product,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: productValue,
                      onChanged: (value) {
                        setState(() {
                          productValue = value as String;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 55,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.white,
                        ),
                        elevation: 1,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Colors.black54,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        // width: 200,
                        padding: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        elevation: 8,
                        // offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility:
                              MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: () {
                    if (amountInput.text.isEmpty || dateInput.text.isEmpty) {
                    } else {
                      Future<http.Response> createOrder() async {
                        final response =
                            await http.post(Uri.parse('$platformUrl/add_order'),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: convert.jsonEncode(<String, String>{
                                  'amount': amountInput.text,
                                  'deadline': dateInput.text,
                                  'productCode': productValue as String,
                                  'clientName': selectedValue as String,
                                }));

                        if (response.statusCode == 200 ||
                            response.statusCode == 201) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrdersList()),
                          );
                        }
                        return response;
                      }

                      createOrder();
                    }
                  },
                  child: Text(
                    'Order',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
