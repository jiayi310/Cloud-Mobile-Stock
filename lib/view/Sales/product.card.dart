import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobilestock/models/Sales.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'SalesDetails/add.cartbutton.dart';
import 'SalesProvider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.stockid,
    required this.stockcode,
    required this.uom,
    required this.price,
    required this.press,
    required this.bgColor,
    required this.sales,
  }) : super(key: key);

  final String title, stockcode, uom, stockid;
  final Uint8List image;
  final VoidCallback press;
  final double price;
  final Color bgColor;
  final Sales sales;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        width: 170,
        height: 220,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 132,
              decoration: BoxDecoration(
                color: widget.bgColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Stack(
                children: [
                  if (widget.image != null && widget.image.isNotEmpty)
                    Center(
                      child: Image.memory(
                        widget.image!,
                        height: 132,
                      ),
                    ),
                  if (widget.image == null || widget.image.isEmpty)
                    Center(
                      child: Image.asset(
                        "assets/images/no-image.png",
                        width: 100,
                      ),
                    ),
                  Positioned(
                    top: 5,
                    right: -5,
                    child: AddCartButton(
                      onQuantityChanged: (newQuantity) {
                        setState(() {
                          // Add the item to the sales object
                          final salesProvider = SalesProvider.of(context);
                          if (salesProvider != null) {
                            salesProvider.sales.addItem(
                              stockID: widget.stockid,
                              stockCode: widget.stockcode,
                              description: widget.title,
                              uom: widget.uom,
                              quantity: 1,
                              discount: 0,
                              taxrate: 0,
                              total: 0,
                              taxAmt: 0,
                              taxableAmount: 0,
                              price: widget.price,
                              image: widget.image,
                            );
                          }
                        });
                      },
                    ),
                  ),
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
                            widget.stockcode,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.title,
                            style: TextStyle(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.uom,
                              style: TextStyle(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "RM " + widget.price.toString(),
                              style: TextStyle(
                                color: GlobalColors.mainColor,
                                fontWeight: FontWeight.bold,
                              ),
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
