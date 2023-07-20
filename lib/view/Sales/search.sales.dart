import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: GlobalColors.mainColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 50,
            width: MediaQuery.of(context).size.width - 118,
            child: TextFormField(
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: "Search"),
            ),
          ),
          Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 20),
              child: Icon(Icons.camera_alt)),
        ],
      ),
    );
  }
}
