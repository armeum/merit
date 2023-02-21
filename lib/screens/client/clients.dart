import 'package:flutter/material.dart';
import 'package:merit_app/models/client.dart';
import 'package:merit_app/utils/dimensions.dart';

class ClientList extends StatelessWidget {
  final List<Client> clients = [
    Client(id: '1', name: 'Munisa', region: 'Tashkent'),
    Client(id: '2', name: 'Ulugbek', region: 'Fergana'),
    Client(id: '3', name: 'Umida', region: 'Samarkand'),
    Client(id: '4', name: 'Abdulboriy', region: 'Tashkent'),
    Client(id: '5', name: 'Sofiya', region: 'Bukhara'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: clients.length,
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
                          '${clients[index].name}',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${clients[index].region}',
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
    );
  }
}
