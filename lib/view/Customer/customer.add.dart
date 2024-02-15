import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobilestock/view/Customer/textfield.widget.dart';

import '../../api/base.client.dart';
import '../../size.config.dart';
import '../../utils/global.colors.dart';
import '../../utils/utils.dart';

class NewCustomer extends StatefulWidget {
  const NewCustomer({Key? key}) : super(key: key);

  @override
  State<NewCustomer> createState() => _NewCustomerState();
}

class _NewCustomerState extends State<NewCustomer> {
  final storage = new FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  int userid = 0, companyid = 0;
  bool value = false;
  final TextEditingController customerCode = TextEditingController();
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
  final TextEditingController deliver1 = TextEditingController();
  final TextEditingController deliver2 = TextEditingController();
  final TextEditingController deliver3 = TextEditingController();
  final TextEditingController deliver4 = TextEditingController();
  final TextEditingController deliverpostcode = TextEditingController();
  final TextEditingController attention = TextEditingController();
  final TextEditingController fax1 = TextEditingController();
  final TextEditingController fax2 = TextEditingController();
  Uint8List? _image;

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
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
                  postData();
                },
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
            ],
          ),
        ),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Stack(children: [
                      _image != null
                          ? ClipOval(
                              child: Image.memory(
                                _image!,
                                width: 120,
                                height: 120,
                              ),
                            )
                          : ClipOval(
                              child: Image.asset(
                                "assets/images/avatar.png",
                                width: 120,
                                height: 120,
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 5,
                        child: buildCircle(
                          color: Colors.white,
                          all: 3,
                          child: buildCircle(
                            color: GlobalColors.mainColor,
                            all: 1,
                            child: IconButton(
                              color: Colors.white,
                              onPressed: selectImage,
                              icon: Icon(
                                Icons.add_a_photo,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFieldWidget(
                    label: 'Customer Code',
                    controller: customerCode,
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
                  Divider(),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: this.value,
                          activeColor: GlobalColors.mainColor,
                          onChanged: (bool? value) {
                            setState(() {
                              this.value = value!;
                              deliver1.text = address1.text;
                              deliver2.text = address2.text;
                              deliver3.text = address3.text;
                              deliver4.text = address4.text;
                              deliverpostcode.text = postcode.text;
                            });
                          }),
                      Text("Same as Address"),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFieldWidget(
                    label: 'Deliver Address 1',
                    controller: deliver1,
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
                    label: 'Deliver Address 2',
                    controller: deliver2,
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
                    label: 'Deliver Address 3',
                    controller: deliver3,
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
                          label: 'Deliver Address 4',
                          controller: deliver4,
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
                          label: 'Deliver Post Code',
                          controller: deliverpostcode,
                          icon: Icon(
                            Icons.local_post_office,
                            color: GlobalColors.mainColor,
                          ),
                          onChanged: (name) {},
                        ),
                      ),
                    ],
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
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Processing Data')),
      // );

      int response = await BaseClient().post('/Customer/CreateCustomer', {
        "customerCode": customerCode.text.isNotEmpty ? customerCode.text : null,
        "name": name.text.isNotEmpty ? name.text : null,
        "name2": name2.text.isNotEmpty ? name2.text : null,
        "address1": address1.text.isNotEmpty ? address1.text : null,
        "address2": address2.text.isNotEmpty ? address2.text : null,
        "address3": address3.text.isNotEmpty ? address3.text : null,
        "address4": address4.text.isNotEmpty ? address4.text : null,
        "postCode": postcode.text.isNotEmpty ? postcode.text : null,
        "deliverAddr1": deliver1.text.isNotEmpty ? deliver1.text : null,
        "deliverAddr2": deliver2.text.isNotEmpty ? deliver2.text : null,
        "deliverAddr3": deliver3.text.isNotEmpty ? deliver3.text : null,
        "deliverAddr4": deliver4.text.isNotEmpty ? deliver4.text : null,
        "deliverPostCode":
            deliverpostcode.text.isNotEmpty ? deliverpostcode.text : null,
        "attention": attention.text.isNotEmpty ? attention.text : null,
        "phone1": phone1.text.isNotEmpty ? phone1.text : null,
        "phone2": phone2.text.isNotEmpty ? phone2.text : null,
        "attention": attention.text.isNotEmpty ? attention.text : null,
        "fax1": fax1.text.isNotEmpty ? fax1.text : null,
        "fax2": fax2.text.isNotEmpty ? fax2.text : null,
        "email": email.text.isNotEmpty ? email.text : null,
        "priceCategory": 1,
        "lastModifiedDateTime": "2023-10-23T03:26:38.370Z",
        "lastModifiedUserID": userid,
        "createdDateTime": "2023-10-23T03:26:38.370Z",
        "createdUserID": userid,
        "companyID": companyid
      });

      if (response == 1) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Save')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Duplicated Customer Code')),
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
}
