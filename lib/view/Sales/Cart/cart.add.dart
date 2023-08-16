import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class AddCartButtonCart extends StatefulWidget {
  const AddCartButtonCart({Key? key}) : super(key: key);

  @override
  State<AddCartButtonCart> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddCartButtonCart> {
  int quantity = 0;

  Widget showWidget(int qty) {
    if (qty == 0) {
      return Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          child: Text(
            "x1",
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.withOpacity(0.05)),
          onPressed: () {
            setState(() {
              quantity++;
            });
          },
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.remove,
                color: Colors.indigo,
              ),
              onPressed: () {
                setState(() {
                  quantity--;
                });
              },
            ),
            Text(
              quantity.toString(),
              style: TextStyle(color: GlobalColors.mainColor),
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.indigo,
              ),
              onPressed: () {
                setState(() {
                  quantity++;
                });
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 110,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: showWidget(quantity),
      ),
    );
  }
}
