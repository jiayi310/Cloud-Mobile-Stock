import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobilestock/models/Stock.dart';
import 'package:mobilestock/view/Stock/add.details.dart';

import '../../utils/global.colors.dart';
import '../../utils/utils.dart';

class AddStock extends StatefulWidget {
  const AddStock({Key? key}) : super(key: key);

  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  Stock stock = new Stock();
  List<String> itemGroups = ['Group A', 'Group B', 'Group C'];
  String selectedGroup = 'Group A';
  List<String> itemTypes = ['Type A', 'Type B', 'Type C'];
  String selectedType = 'Type A';
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Add Stock",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {},
                child: Text(
                  "Publish",
                  style: TextStyle(color: GlobalColors.mainColor, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _image != null
                  ? Center(
                      child: Container(
                        child: Image.memory(
                          _image!,
                          width: 200,
                          height: 200,
                        ),
                      ),
                    )
                  : Center(
                      child: InkWell(
                        onTap: selectImage,
                        child: Container(
                          child: Image.asset(
                            "assets/images/imageupload.png",
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                    ),
              TextField(
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Item Code',
                  labelStyle: TextStyle(color: GlobalColors.mainColor),
                ),
              ),
              TextField(
                style: TextStyle(fontSize: 17),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Description',
                  labelStyle: TextStyle(color: GlobalColors.mainColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
              TextField(
                style: TextStyle(fontSize: 17),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Description 2',
                  labelStyle: TextStyle(color: GlobalColors.mainColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
              Row(
                children: [
                  Text(
                    "Item Group",
                    style:
                        TextStyle(fontSize: 17, color: GlobalColors.mainColor),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedGroup,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGroup = newValue!;
                        });
                      },
                      isExpanded: true,
                      items: itemGroups
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Item Type",
                    style:
                        TextStyle(fontSize: 17, color: GlobalColors.mainColor),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedType,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedType = newValue!;
                        });
                      },
                      isExpanded: true,
                      items: itemTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Item Category",
                    style:
                        TextStyle(fontSize: 17, color: GlobalColors.mainColor),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedType,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedType = newValue!;
                        });
                      },
                      isExpanded: true,
                      items: itemTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Tax Type",
                    style:
                        TextStyle(fontSize: 17, color: GlobalColors.mainColor),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedType,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedType = newValue!;
                        });
                      },
                      isExpanded: true,
                      items: itemTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  //  Get.to(()=> AddStockDetails(stock: stock), transition: Transition.fade);
                  Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => AddStockDetails(stock: stock),
                  ));
                },
                child: Row(
                  children: [
                    Text(
                      "  Add More Details",
                      style:
                          const TextStyle(fontSize: 17, color: Colors.black54),
                    ),
                    const Spacer(),
                    Icon(
                      CupertinoIcons.chevron_forward,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
              // Row(
              //   children: [
              //     Container(
              //       height: 50,
              //       width: 50,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //       child: Icon(
              //         Icons.money,
              //         color: Colors.black54,
              //       ),
              //     ),
              //     const SizedBox(width: 20),
              //     Text(
              //       "Add Price",
              //       style: const TextStyle(fontSize: 17, color: Colors.black54),
              //     ),
              //     const Spacer(),
              //     Icon(
              //       CupertinoIcons.chevron_forward,
              //       color: Colors.black54,
              //     ),
              //   ],
              // ),
              // Divider(
              //   thickness: 2,
              // ),
              // Row(
              //   children: [
              //     Container(
              //       height: 50,
              //       width: 50,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //       child: Icon(
              //         CupertinoIcons.cube_box_fill,
              //         color: Colors.black54,
              //       ),
              //     ),
              //     const SizedBox(width: 20),
              //     Text(
              //       "Inventory",
              //       style: const TextStyle(fontSize: 17, color: Colors.black54),
              //     ),
              //     const Spacer(),
              //     Icon(
              //       CupertinoIcons.chevron_forward,
              //       color: Colors.black54,
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
}
