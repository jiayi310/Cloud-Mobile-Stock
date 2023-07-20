import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/models/Product.dart';
import 'package:mobilestock/utils/global.colors.dart';

class CartItem extends StatelessWidget {
  CartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < demo_product.length; i++)
          Container(
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
                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 224, 224, 244),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(demo_product[i].image),
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
                          demo_product[i].title,
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
                        Text(
                          "RM " + demo_product[i].price.toString(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.delete, color: Colors.redAccent),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFF7F8FA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              CupertinoIcons.minus,
                              size: 18,
                              color: GlobalColors.mainColor,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "01",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: 10),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFF7F8FA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              CupertinoIcons.add,
                              size: 18,
                              color: GlobalColors.mainColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}
