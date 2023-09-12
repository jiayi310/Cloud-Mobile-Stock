import 'package:flutter/material.dart';
import 'package:mobilestock/size.config.dart';
import 'package:mobilestock/view/Sales/CheckOut/checkout.view.dart';

import '../../../utils/global.colors.dart';

class CartBottomBar extends StatelessWidget {
  const CartBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(
          left: defaultPadding, right: defaultPadding, bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                  activeColor: GlobalColors.mainColor,
                  value: true,
                  onChanged: (value) {}),
              Text(
                "ALL",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),

          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "RM 10.00",
                    style: TextStyle(
                        color: GlobalColors.mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  Text(
                    "8 Selected",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CheckOutPage()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                      color: GlobalColors.mainColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Check Out",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              )
            ],
          ),

          // ElevatedButton(
          //   onPressed: () {
          //     showModalBottomSheet(
          //         backgroundColor: Colors.transparent,
          //         context: context,
          //         builder: (context) {
          //           return AddToCartModal();
          //         });
          //   },
          //   style: ElevatedButton.styleFrom(primary: GlobalColors.mainColor),
          //   child: const Text("Add to Cart"),
          // ),
        ],
      ),
    );
  }
}
