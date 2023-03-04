import 'package:flutter/material.dart';
import 'package:merit_app/models/client.dart';
import 'package:merit_app/utils/dimensions.dart';
import 'package:http/http.dart' as http;
import 'package:merit_app/utils/url.dart';
import 'dart:convert' as convert;


class ClientList extends StatefulWidget {
  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  var clientList = [];

  void FetchData() async {
    var response = await http.get(Uri.parse('$platformUrl/all_clients'));
    if (response.statusCode == 200) {
      setState(() {
        clientList = convert.jsonDecode(response.body);
      });
      print(clientList);
    } else {
      print(clientList);
      setState(() {
        // orderList = [];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: () => setState(() {}), child: Text("press me")),
          TextButton(onPressed: () => setState(() {}), child: Text("Me also")),
        ],
      ),
      body: Container(
          color: Colors.white,
            child: clientList == []
                ? const CircularProgressIndicator(
              color: Colors.blue,
            )
                : ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: clientList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(
                    bottom: 10,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: const Center(
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 200,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight:
                              Radius.circular(Dimensions.radius20),
                              bottomRight:
                              Radius.circular(Dimensions.radius20),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  clientList[index]['name'].toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  clientList[index]['region'].toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
    );
  }
}
