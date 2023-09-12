import 'package:flutter/material.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/Customer/customer.add.dart';
import 'package:mobilestock/view/Customer/customer.card.dart';
import 'package:mobilestock/view/Customer/customer.search.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreen();
}

class _CustomerHomeScreen extends State<CustomerHomeScreen> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewCustomer()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
      ),
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Customer",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                _toggle();
              },
              child: Icon(
                Icons.search,
                size: 25,
                color: GlobalColors.mainColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Visibility(visible: _visible, child: SearchWidget()),
            CustomerCard(),
          ],
        )),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }
}
