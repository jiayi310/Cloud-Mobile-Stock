import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class AddCartButton extends StatefulWidget {
  final ValueChanged<int> onQuantityChanged;

  const AddCartButton({Key? key, required this.onQuantityChanged})
      : super(key: key);

  @override
  State<AddCartButton> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddCartButton> {
  int quantity = 0;
  bool isRectangle = false;

  Widget showWidget(int qty) {
    if (!isRectangle || qty == 0) {
      return Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          child: Icon(Icons.add),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(0),
            backgroundColor: GlobalColors.mainColor,
          ),
          onPressed: () {
            setState(() {
              quantity++;
              widget.onQuantityChanged(
                  quantity); // Notify parent about the change
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Item added to cart')),
              );
              // Switch to the rectangle widget
              isRectangle = true;
              // Delayed switch back to the circle button after 3 seconds
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  isRectangle = false;
                  quantity = 0;
                });
              });
            });
          },
        ),
      );
    } else {
      return Container(
        width: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            // IconButton(
            //   icon: const Icon(
            //     Icons.remove,
            //     color: Colors.indigo,
            //   ),
            //   onPressed: () {
            //     setState(() {
            //       quantity--;
            //       widget.onQuantityChanged(
            //           quantity); // Notify parent about the change
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text('Item quantity changed')),
            //       );
            //     });
            //   },
            // ),
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
                  widget.onQuantityChanged(
                      quantity); // Notify parent about the change
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Item added to cart')),
                  );
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
