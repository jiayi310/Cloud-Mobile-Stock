import 'package:flutter/material.dart';
import 'package:mobilestock/size.config.dart';

class AddBottomBar extends StatelessWidget {
  const AddBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(
          left: defaultPadding, right: defaultPadding, bottom: 30, top: 20),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - 110,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "SAVE",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
