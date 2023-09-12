import 'package:flutter/material.dart';
import 'package:mobilestock/view/Customer/add.bottom.dart';
import 'package:mobilestock/view/Customer/textfield.widget.dart';

import '../../utils/global.colors.dart';

class NewCustomer extends StatelessWidget {
  NewCustomer({Key? key}) : super(key: key);
  final TextEditingController customerCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: AddBottomBar(),
        appBar: AppBar(
          foregroundColor: GlobalColors.mainColor,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "New Customer",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          physics: BouncingScrollPhysics(),
          children: [
            Center(
              child: Stack(children: [
                ClipOval(
                  child: Image.asset(
                    "assets/images/agiliti_logo_blue.png",
                    width: 120,
                    height: 120,
                  ),
                ),
                Positioned(
                    bottom: 0, right: 4, child: buildEditIcon(Colors.blue)),
              ]),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Company Name',
              text: "",
              onChanged: (name) {},
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Desc 2',
              text: "",
              onChanged: (name) {},
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Email',
              text: "",
              onChanged: (name) {},
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Phone',
              text: "",
              onChanged: (name) {},
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Address 1',
              text: "",
              onChanged: (name) {},
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Address 2',
              text: "",
              onChanged: (name) {},
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Address 3',
              text: "",
              onChanged: (name) {},
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Address 4',
              text: "",
              onChanged: (name) {},
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldWidget(
              label: 'Agent',
              text: "",
              onChanged: (name) {},
            ),
          ],
        ));
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.add_a_photo,
            size: 20,
            color: Colors.white,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          child: child,
          color: color,
          padding: EdgeInsets.all(all),
        ),
      );
}
