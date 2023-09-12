import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';

class CusQuotation extends StatefulWidget {
  const CusQuotation({Key? key}) : super(key: key);

  @override
  State<CusQuotation> createState() => _CusQuotation();
}

class _CusQuotation extends State<CusQuotation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      margin: EdgeInsets.all(10),
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
