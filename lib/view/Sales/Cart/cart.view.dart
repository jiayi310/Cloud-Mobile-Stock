import 'package:flutter/material.dart';
import 'package:mobilestock/view/Sales/Cart/cart.bottom.dart';
import 'package:mobilestock/view/Sales/Cart/cart.item.dart';

import '../../../utils/global.colors.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CartBottomBar(),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            //Header
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: GlobalColors.mainColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Cart',
                      style: TextStyle(
                        fontSize: GlobalSize.headerSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 15, color: GlobalColors.mainColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  CartItem(),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
