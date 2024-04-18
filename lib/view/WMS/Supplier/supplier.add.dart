import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../api/base.client.dart';
import '../../../models/Supplier.dart';
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';
import '../../../utils/utils.dart';
import '../../Customer/textfield.widget.dart';

class NewSupplier extends StatefulWidget {
  NewSupplier({Key? key, required this.isEdit, required this.supplier})
      : super(key: key);
  bool isEdit;
  Supplier supplier;

  @override
  State<NewSupplier> createState() => _NewSupplierState();
}

class _NewSupplierState extends State<NewSupplier> {
  final storage = new FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  int userid = 0, companyid = 0;
  bool value = false;
  final TextEditingController SupplierCode = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController name2 = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone1 = TextEditingController();
  final TextEditingController phone2 = TextEditingController();
  final TextEditingController address1 = TextEditingController();
  final TextEditingController address2 = TextEditingController();
  final TextEditingController address3 = TextEditingController();
  final TextEditingController address4 = TextEditingController();
  final TextEditingController postcode = TextEditingController();
  final TextEditingController attention = TextEditingController();
  final TextEditingController fax1 = TextEditingController();
  final TextEditingController fax2 = TextEditingController();
  Uint8List? _image;

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
    if (widget.isEdit) {
      // If editing, populate the text fields with Supplier data
      SupplierCode.text = widget.supplier.supplierCode ?? '';
      name.text = widget.supplier.name ?? '';
      name2.text = widget.supplier.name2 ?? '';
      email.text = widget.supplier.email ?? '';
      phone1.text = widget.supplier.phone1 ?? '';
      phone2.text = widget.supplier.phone2 ?? '';
      address1.text = widget.supplier.address1 ?? '';
      address2.text = widget.supplier.address2 ?? '';
      address3.text = widget.supplier.address3 ?? '';
      address4.text = widget.supplier.address4 ?? '';
      postcode.text = widget.supplier.postCode ?? '';
      attention.text = widget.supplier.attention ?? '';
      fax1.text = widget.supplier.fax1 ?? '';
      fax2.text = widget.supplier.fax2 ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
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
                onTap: () {
                  !widget.isEdit ? postData() : updateData();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 110,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    !widget.isEdit ? "SAVE" : "UPDATE",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          foregroundColor: GlobalColors.mainColor,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "New Supplier",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Center(
                  //   child: Stack(children: [
                  //     _image != null
                  //         ? ClipOval(
                  //             child: Image.memory(
                  //               _image!,
                  //               width: 120,
                  //               height: 120,
                  //             ),
                  //           )
                  //         : ClipOval(
                  //             child: Image.asset(
                  //               "assets/images/avatar.png",
                  //               width: 120,
                  //               height: 120,
                  //             ),
                  //           ),
                  //     Positioned(
                  //       bottom: 0,
                  //       right: 5,
                  //       child: buildCircle(
                  //         color: Colors.white,
                  //         all: 3,
                  //         child: buildCircle(
                  //           color: GlobalColors.mainColor,
                  //           all: 1,
                  //           child: IconButton(
                  //             color: Colors.white,
                  //             onPressed: selectImage,
                  //             icon: Icon(
                  //               Icons.add_a_photo,
                  //               size: 20,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ]),
                  // ),
                  // const SizedBox(
                  //   height: 24,
                  // ),
                  TextFieldWidget(
                    label: 'Supplier Code',
                    controller: SupplierCode,
                    icon: Icon(
                      Icons.code,
                      color: GlobalColors.mainColor,
                    ),
                    onChanged: (name) {},
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldWidget(
                    label: 'Name',
                    controller: name,
                    icon: Icon(
                      Icons.people,
                      color: GlobalColors.mainColor,
                    ),
                    onChanged: (name) {},
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldWidget(
                    label: 'Name 2',
                    controller: name2,
                    icon: Icon(
                      Icons.people,
                      color: GlobalColors.mainColor,
                    ),
                    onChanged: (name) {},
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldWidget(
                    label: 'Email',
                    controller: email,
                    icon: Icon(
                      Icons.email,
                      color: GlobalColors.mainColor,
                    ),
                    onChanged: (name) {},
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Phone 1',
                          controller: phone1,
                          icon: Icon(
                            Icons.phone,
                            color: GlobalColors.mainColor,
                          ),
                          onChanged: (name) {},
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Phone 2',
                          controller: phone2,
                          icon: Icon(
                            Icons.phone,
                            color: GlobalColors.mainColor,
                          ),
                          onChanged: (name) {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Fax 1',
                          controller: fax1,
                          icon: Icon(
                            Icons.fax,
                            color: GlobalColors.mainColor,
                          ),
                          onChanged: (name) {},
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Fax 2',
                          controller: fax2,
                          icon: Icon(
                            Icons.fax,
                            color: GlobalColors.mainColor,
                          ),
                          onChanged: (name) {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldWidget(
                    label: 'Attention',
                    controller: attention,
                    icon: Icon(
                      Icons.attach_file,
                      color: GlobalColors.mainColor,
                    ),
                    onChanged: (name) {},
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldWidget(
                    label: 'Address 1',
                    controller: address1,
                    icon: Icon(
                      Icons.home,
                      color: GlobalColors.mainColor,
                    ),
                    onChanged: (name) {},
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldWidget(
                    label: 'Address 2',
                    controller: address2,
                    icon: Icon(
                      Icons.home,
                      color: GlobalColors.mainColor,
                    ),
                    onChanged: (name) {},
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldWidget(
                    label: 'Address 3',
                    controller: address3,
                    icon: Icon(
                      Icons.home,
                      color: GlobalColors.mainColor,
                    ),
                    onChanged: (name) {},
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Address 4',
                          controller: address4,
                          icon: Icon(
                            Icons.home,
                            color: GlobalColors.mainColor,
                          ),
                          onChanged: (name) {},
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFieldWidget(
                          label: 'Post Code',
                          controller: postcode,
                          icon: Icon(
                            Icons.local_post_office,
                            color: GlobalColors.mainColor,
                          ),
                          onChanged: (name) {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

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

  postData() async {
    if (_formKey.currentState!.validate()) {
      String response = await BaseClient().post(
          '/Supplier/CreateSupplier',
          jsonEncode({
            "SupplierCode":
                SupplierCode.text.isNotEmpty ? SupplierCode.text : null,
            "name": name.text.isNotEmpty ? name.text : null,
            "name2": name2.text.isNotEmpty ? name2.text : null,
            "address1": address1.text.isNotEmpty ? address1.text : null,
            "address2": address2.text.isNotEmpty ? address2.text : null,
            "address3": address3.text.isNotEmpty ? address3.text : null,
            "address4": address4.text.isNotEmpty ? address4.text : null,
            "postCode": postcode.text.isNotEmpty ? postcode.text : null,
            "attention": attention.text.isNotEmpty ? attention.text : null,
            "phone1": phone1.text.isNotEmpty ? phone1.text : null,
            "phone2": phone2.text.isNotEmpty ? phone2.text : null,
            "attention": attention.text.isNotEmpty ? attention.text : null,
            "fax1": fax1.text.isNotEmpty ? fax1.text : null,
            "fax2": fax2.text.isNotEmpty ? fax2.text : null,
            "email": email.text.isNotEmpty ? email.text : null,
            "lastModifiedDateTime": getCurrentDateTime(),
            "lastModifiedUserID": userid,
            "createdDateTime": getCurrentDateTime(),
            "createdUserID": userid,
            "companyID": companyid
          }));

      if (response != null) {
        Navigator.pop(context, "Done");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Save')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Duplicated Supplier Code')),
        );
      }
    }
  }

  getUserData() async {
    String? _userid = await storage.read(key: "userid");
    String? _companyid = await storage.read(key: "companyid");

    userid = int.parse(_userid.toString());
    companyid = int.parse(_companyid.toString());
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  updateData() async {
    if (_formKey.currentState!.validate()) {
      String response = await BaseClient().post(
          '/Supplier/UpdateSupplier?Supplierid=' +
              widget.supplier.supplierID.toString(),
          jsonEncode({
            "supplierID": widget.supplier.supplierID.toString(),
            "supplierCode":
                SupplierCode.text.isNotEmpty ? SupplierCode.text : null,
            "name": name.text.isNotEmpty ? name.text : null,
            "name2": name2.text.isNotEmpty ? name2.text : null,
            "address1": address1.text.isNotEmpty ? address1.text : null,
            "address2": address2.text.isNotEmpty ? address2.text : null,
            "address3": address3.text.isNotEmpty ? address3.text : null,
            "address4": address4.text.isNotEmpty ? address4.text : null,
            "postCode": postcode.text.isNotEmpty ? postcode.text : null,
            "attention": attention.text.isNotEmpty ? attention.text : null,
            "phone1": phone1.text.isNotEmpty ? phone1.text : null,
            "phone2": phone2.text.isNotEmpty ? phone2.text : null,
            "attention": attention.text.isNotEmpty ? attention.text : null,
            "fax1": fax1.text.isNotEmpty ? fax1.text : null,
            "fax2": fax2.text.isNotEmpty ? fax2.text : null,
            "email": email.text.isNotEmpty ? email.text : null,
            "supplierTypeID": widget.supplier.supplierTypeID,
            "lastModifiedDateTime": "2023-10-23T03:26:38.370Z",
            "lastModifiedUserID": userid,
            "createdDateTime": "2023-10-23T03:26:38.370Z",
            "createdUserID": userid,
            "companyID": companyid
          }));

      if (response != null) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Save')),
        );
      } else {}
    }
  }

  getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(now.toUtc());
    return formattedDate;
  }
}
