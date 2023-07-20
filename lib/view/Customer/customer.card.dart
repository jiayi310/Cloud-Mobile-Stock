import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/models/Product.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Customer/customer.details.dart';

import '../../models/Customer.dart';

class CustomerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < demo_customer.length; i++)
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CustomerDetails(customer: demo_customer[i]),
                  ));
            },
            child: Container(
              height: 120,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      demo_customer[i].Name,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: GlobalColors.mainColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    demo_customer[i].AccNo,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      demo_customer[i].Name2,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    demo_customer[i].Email,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      demo_customer[i].Agent,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    demo_customer[i].Phone,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
