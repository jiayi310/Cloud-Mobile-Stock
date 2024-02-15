import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

import 'SalesDetails/add.cartbutton.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.stockcode,
    required this.uom,
    required this.price,
    required this.press,
    required this.bgColor,
  }) : super(key: key);
  final String title, stockcode, uom;
  final Uint8List image;
  final VoidCallback press;
  final double price;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: 170,
        height: 220,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 132,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Stack(
                children: [
                  if (image != null && image.isNotEmpty)
                    Center(
                      child: Image.memory(
                        image!,
                        height: 132,
                      ),
                    ),
                  if (image == null || image.isEmpty)
                    Center(
                      child: Image.asset(
                        "assets/images/no-image.png",
                        width: 100,
                      ),
                    ),
                  Positioned(top: 5, right: -5, child: AddCartButton()),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            stockcode,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: const TextStyle(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              uom,
                              style: const TextStyle(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "RM " + price.toString(),
                              style: TextStyle(
                                  color: GlobalColors.mainColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
