import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobilestock/models/Stock.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Sales/Cart/cart.add.dart';

import '../../../models/Sales.dart';
import '../SalesProvider.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  List<SalesItem> salesItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access context and salesProvider here
    final salesProvider = SalesProvider.of(context);
    salesItems = salesProvider?.sales.items ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: salesItems.length,
          itemBuilder: (BuildContext context, int i) {
            final item = salesItems[i].description;
            return Slidable(
                key: Key(item.toString()),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            salesItems.removeAt(i);
                          });
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: Icon(
                          Icons.delete,
                        ))
                  ],
                ),
                child: Container(
                  height: 110,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: GlobalColors.mainColor,
                        value: true,
                        onChanged: (value) {},
                      ),
                      if (salesItems[i].image!.length > 0)
                        Container(
                          height: 70,
                          width: 70,
                          margin: EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 224, 224, 244),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:
                              Image.memory(salesItems[i].image ?? Uint8List(0)),
                        ),
                      if (salesItems[i].image!.length <= 0)
                        Container(
                          height: 70,
                          width: 70,
                          margin: EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            "assets/images/no-image.png",
                            width: 100,
                          ),
                        ),
                      Expanded(
                        child: Container(
                          width: 200,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                salesItems[i].stockCode.toString(),
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                salesItems[i].description.toString(),
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                salesItems[i].uom.toString(),
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 13,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                "RM " + salesItems[i].price.toString(),
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: GlobalColors.mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AddCartButtonCart(
                              quantity: salesItems[i].quantity,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
        )
      ],
    );
  }
}
