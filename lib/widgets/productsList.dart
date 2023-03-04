import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:merit_app/utils/dimensions.dart';

class ProductList extends StatefulWidget {
  const ProductList(
      {super.key,
      required this.name,
      required this.code,
      required this.length,
      required this.data});

  final String name;
  final String code;
  final int length;
  final List data;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.length,
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
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.science,
                      color: Colors.white,
                      size: 39.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
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
                            widget.data[index]['name'],
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          FittedBox(
                            child: Text(
                              widget.data[index]['code'],
                              style: Theme.of(context).textTheme.headline6,
                            ),
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
  }
}
