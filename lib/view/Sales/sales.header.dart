import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Sales/OrderHistory/history.view.dart';
import 'package:mobilestock/view/Sales/sales.filter.dart';

import '../../models/Sales.dart';
import 'Cart/cart.view.dart';
import 'SalesProvider.dart';

class SalesAppBar extends StatefulWidget {
  const SalesAppBar({Key? key}) : super(key: key);

  @override
  State<SalesAppBar> createState() => _SalesAppBarState();
}

class _SalesAppBarState extends State<SalesAppBar> {
  int numOfitem = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access context and salesProvider here
    final salesProvider = SalesProvider.of(context);
    numOfitem = salesProvider!.sales.items.length;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 30,
                  color: GlobalColors.mainColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Sales',
                  style: TextStyle(
                    fontSize: GlobalSize.headerSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
            );
          },
          borderRadius: BorderRadius.circular(50),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 50,
                width: 50,
                child: Icon(
                  Icons.history,
                  color: GlobalColors.mainColor,
                ),
                decoration: BoxDecoration(
                  color: GlobalColors.mainColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => SalesFilters());
          },
          borderRadius: BorderRadius.circular(50),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 50,
                width: 50,
                child: Icon(
                  Icons.filter_list_alt,
                  color: GlobalColors.mainColor,
                ),
                decoration: BoxDecoration(
                  color: GlobalColors.mainColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartList()),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 50,
                width: 50,
                child: Icon(
                  Icons.shopping_cart,
                  color: GlobalColors.mainColor,
                ),
                decoration: BoxDecoration(
                  color: GlobalColors.mainColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
              if (numOfitem != 0)
                Positioned(
                  top: -3,
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF4848),
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.5, color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        "$numOfitem",
                        style: TextStyle(
                          fontSize: 10,
                          height: 1,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
