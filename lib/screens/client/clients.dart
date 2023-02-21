import 'package:flutter/material.dart';
import 'package:merit_app/models/client.dart';
import 'package:merit_app/utils/dimensions.dart';

class ClientList extends StatelessWidget {
  final List<Client> clients;

  ClientList(this.clients);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
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
                    color: Theme.of(context).accentColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Celluloza',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Q-000001',
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
