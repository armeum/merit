import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:merit_app/models/order.dart';
import 'package:merit_app/utils/dimensions.dart';

class OrdersList extends StatefulWidget {
  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  List<Order> orderList = [
    Order(
        id: '1',
        userId: '1',
        clientId: '1',
        productId: '1',
        amount: 100,
        isDelivered: true,
        orderedDate: DateTime.now(),
        deadline: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 50),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: orderList.length,
        itemBuilder: (BuildContext context, index) {
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
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        bottomRight: Radius.circular(Dimensions.radius20),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${orderList[index].amount}',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${orderList[index].deadline}',
                            style: Theme.of(context).textTheme.headline6,
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
    );

    // MaterialApp(
    //     home: Container(
    //         child: Flexible(
    //   child: ListView.builder(
    //       itemCount: orderList.length,
    //       itemBuilder: (_, index) => Card(
    //             child: ListTile(
    //               title: Text(orderList[index].clientId),
    //               subtitle: Text(orderList[index].productId),
    //               trailing: Text(orderList[index].amount.toString()),
    //             ),
    //           )),
    // )));
  }
}

class DynamicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter your username',
        ),
      ),
    );
  }
}
