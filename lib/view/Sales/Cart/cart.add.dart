import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class AddCartButtonCart extends StatefulWidget {
  AddCartButtonCart({Key? key, required this.quantity}) : super(key: key);

  int quantity;

  @override
  State<AddCartButtonCart> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddCartButtonCart> {
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
              widget.quantity++;
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
                  widget.quantity--;
                });
              },
            ),
            Text(
              widget.quantity.toString(),
              style: TextStyle(color: GlobalColors.mainColor),
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.indigo,
              ),
              onPressed: () {
                setState(() {
                  widget.quantity++;
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
      width: 120,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: showWidget(widget.quantity),
      ),
    );
  }
}
