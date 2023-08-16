import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

class CusCheckOut extends StatefulWidget {
  const CusCheckOut({Key? key}) : super(key: key);

  @override
  State<CusCheckOut> createState() => _CusCheckOutState();
}

class _CusCheckOutState extends State<CusCheckOut> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CA-M0001 Venersa (M) Sdn Bhd',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              'No 69, Bandar Puteri 2/1, 45722 Bandar Puteri Puchong, Selangor',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '011-12356897',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mr. Danniel',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              Icon(
                CupertinoIcons.right_chevron,
                color: GlobalColors.mainColor,
              )
            ],
          ),
        ],
      ),
    );
  }
}
