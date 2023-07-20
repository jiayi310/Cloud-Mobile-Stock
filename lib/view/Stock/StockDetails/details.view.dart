import 'package:flutter/material.dart';
import 'package:mobilestock/models/Product.dart';

import '../../../utils/global.colors.dart';

class StockDetails extends StatelessWidget {
  const StockDetails({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          product.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.edit,
                size: 25,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Stack(children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/images/avatar.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 4,
                            child: buildEditIcon(Colors.blue)),
                      ]),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam pharetra laoreet orci eu molestie. Etiam gravida hendrerit mauris eget ultrices. Cras eleifend massa enim, id cursus felis pharetra a. In sagittis mollis faucibus. ",
                        ),
                        Text("uom"),
                        Text("rate"),
                        Text("shelf"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            size: 15,
            color: Colors.white,
          ),
        ),
      );
}

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        child: child,
        color: color,
        padding: EdgeInsets.all(all),
      ),
    );
