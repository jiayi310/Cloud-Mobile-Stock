import 'package:flutter/material.dart';
import 'package:mobilestock/models/Product.dart';
import 'package:mobilestock/size.config.dart';

import '../../../utils/global.colors.dart';
import 'cart.modal.dart';

class ItemBottomBar extends StatelessWidget {
  const ItemBottomBar({Key? key, required this.product}) : super(key: key);

  final Product product;

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
          Text(
            "RM " + product.price.toString(),
            style: TextStyle(
                color: GlobalColors.mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return AddToCartModal(
                      product: product,
                    );
                  });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              decoration: BoxDecoration(
                  color: GlobalColors.mainColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                "Add to Cart",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          )
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
