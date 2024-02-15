import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobilestock/view/Sales/Cart/cart.add.dart';

import '../../../models/Stock.dart';
import '../../../utils/global.colors.dart';

class ItemQuotation extends StatefulWidget {
  const ItemQuotation({Key? key}) : super(key: key);

  @override
  State<ItemQuotation> createState() => _ItemQuotationState();
}

class _ItemQuotationState extends State<ItemQuotation> {
  _ItemQuotationState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: demo_product.length,
          itemBuilder: (BuildContext context, int i) {
            final item = demo_product[i].desc2;
            return Slidable(
              key: Key(item.toString()),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          demo_product.removeAt(i);
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
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 224, 224, 244),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // child: Image.asset(demo_product[i].image.toString()),
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
                              demo_product[i].desc2.toString(),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              "Descriptionnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn",
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              "UOM",
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.7),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "RM " + demo_product[i].desc2.toString(),
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: GlobalColors.mainColor,
                            ),
                          ),
                          AddCartButtonCart(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
