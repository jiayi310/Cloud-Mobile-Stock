import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilestock/models/Sales.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Analysis/Ranking/chip.custom.dart';
import 'package:mobilestock/view/Analysis/Ranking/triade.ranking.dart';

import '../../../api/base.client.dart';
import '../../../models/SalesAgent.dart';

class Ranking_Agent extends StatefulWidget {
  const Ranking_Agent({Key? key}) : super(key: key);

  @override
  State<Ranking_Agent> createState() => _Ranking_AgentState();
}

class _Ranking_AgentState extends State<Ranking_Agent> {
  String companyid = "", userid = "";
  final storage = new FlutterSecureStorage();
  int indexvalue = 1;
  List<SalesAgent> list = [];

  @override
  void initState() {
    // TODO: implement initState
    getTop10Agent(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Top 10 Sales Agent",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CustomChipWidget(
                label: "Today",
                selected: indexvalue == 1,
                onSelect: (selected) {
                  setState(() {
                    indexvalue = 1;
                  });
                  getTop10Agent(1);
                },
              ),
              CustomChipWidget(
                label: "Week",
                selected: indexvalue == 2,
                onSelect: (selected) {
                  setState(() {
                    indexvalue = 2;
                  });
                  getTop10Agent(2);
                },
              ),
              CustomChipWidget(
                label: "Month",
                selected: indexvalue == 3,
                onSelect: (selected) {
                  setState(() {
                    indexvalue = 3;
                  });
                  getTop10Agent(3);
                },
              ),
              CustomChipWidget(
                label: "Total",
                selected: indexvalue == 4,
                onSelect: (selected) {
                  setState(() {
                    indexvalue = 4;
                  });
                  getTop10Agent(4);
                },
              ),
            ],
          ),
        ),
      ),
      body: list.isNotEmpty
          ? ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return TriadeRanking(
                    list: list,
                  );
                }
                if (index < 3) {
                  return Container();
                }
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  leading: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        (index + 1).toString(),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  title: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.2),
                        borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                              // list[index].profileImage != null
                              //     ? MemoryImage(base64Decode(list[index].profileImage!)):
                              AssetImage("assets/images/customer.png")
                                  as ImageProvider,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          list[index].salesAgentDescription.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Spacer(),
                        Text(
                          list[index].amt!.toStringAsFixed(2),
                          style:
                              TextStyle(color: Color(0xff45C9A1), fontSize: 15),
                        )
                      ],
                    ),
                  ),
                );
              })
          : Center(
              child: Text(
                'No Data',
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }

  Future<void> getTop10Agent(int _case) async {
    companyid = (await storage.read(key: "companyid"))!;
    userid = (await storage.read(key: "userid"))!;
    if (companyid != null) {
      String response = await BaseClient().get(
          '/Sales/GetTop10Agent?companyId=' +
              companyid.toString() +
              '&_case=' +
              _case.toString());

      if (response != 0) {
        List<dynamic> jsonList = jsonDecode(response);

        List<SalesAgent> dataList =
            jsonList.map((json) => SalesAgent.fromJson(json)).toList();

        setState(() {
          list = dataList;
        });
      }
    }
  }
}
