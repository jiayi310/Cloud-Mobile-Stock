import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/SalesAgent.dart';

class TriadeRanking extends StatefulWidget {
  TriadeRanking({Key? key, required this.list}) : super(key: key);
  List<SalesAgent> list;

  @override
  State<TriadeRanking> createState() => _TriadeRankingState();
}

class _TriadeRankingState extends State<TriadeRanking> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: MediaQuery.of(context).size.height * .4,
          ),
        ),

        //2
        if (widget.list.length > 1)
          Positioned(
            left: MediaQuery.of(context).size.width / 3 - 80,
            top: 70,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "2",
                  style: TextStyle(color: Colors.white),
                ),
                Image.asset(
                  "assets/images/crown.png",
                  height: 40,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomCircleAvatar(
                  size: 110,
                  noGlow: true,
                  salesAgent:
                      widget.list.isNotEmpty ? widget.list[1] : SalesAgent(),
                ),
              ],
            ),
          ),
        //3
        if (widget.list.length > 2)
          Positioned(
            left: MediaQuery.of(context).size.width / 3 + 110,
            top: 70,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "3",
                  style: TextStyle(color: Colors.white),
                ),
                Image.asset(
                  "assets/images/crown.png",
                  height: 40,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomCircleAvatar(
                  size: 110,
                  noGlow: true,
                  salesAgent:
                      widget.list.isNotEmpty ? widget.list[2] : SalesAgent(),
                ),
              ],
            ),
          ),
        //1
        Positioned(
          left: MediaQuery.of(context).size.width / 3,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "1",
                style: TextStyle(color: Colors.white),
              ),
              Image.asset(
                "assets/images/king.png",
                height: 40,
              ),
              SizedBox(
                height: 10,
              ),
              CustomCircleAvatar(
                size: 140,
                noGlow: false,
                salesAgent:
                    widget.list.isNotEmpty ? widget.list[0] : SalesAgent(),
              ),
            ],
          ),
        ),
        if (widget.list.length == 0)
          Text(
            "No data",
            style: TextStyle(color: Colors.white),
          ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}

class CustomCircleAvatar extends StatelessWidget {
  CustomCircleAvatar(
      {Key? key,
      required this.size,
      required this.noGlow,
      required this.salesAgent})
      : super(key: key);
  double size;
  final bool noGlow;
  final SalesAgent salesAgent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              border:
                  Border.all(width: noGlow ? 3 : 5, color: Color(0xff17FAC3)),
              boxShadow: noGlow
                  ? []
                  : [
                      BoxShadow(
                          color: Colors.blue,
                          blurRadius: 20,
                          offset: Offset(0, 0))
                    ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/customer.png"),
              )),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          salesAgent.salesAgentDescription.toString().length <= 10
              ? salesAgent.salesAgentDescription.toString()
              : salesAgent.salesAgentDescription.toString() + "...",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Text(
          salesAgent.amt.toString(),
          style: TextStyle(
              color: Color(0xff43A783),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        )
      ],
    );
  }
}
