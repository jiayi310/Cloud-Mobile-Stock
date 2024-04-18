import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../api/base.client.dart';
import '../../../models/Location.dart';
import '../../../size.config.dart';
import '../../../utils/global.colors.dart';
import '../../Customer/textfield.widget.dart';

class NewLocation extends StatefulWidget {
  NewLocation({Key? key, required this.isEdit, required this.location})
      : super(key: key);
  bool isEdit;
  Location location;

  @override
  State<NewLocation> createState() => _NewLocationState();
}

class _NewLocationState extends State<NewLocation> {
  final storage = new FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  int userid = 0, companyid = 0;
  bool value = false;
  final TextEditingController location = TextEditingController();
  final TextEditingController phone1 = TextEditingController();
  final TextEditingController phone2 = TextEditingController();
  final TextEditingController address1 = TextEditingController();
  final TextEditingController address2 = TextEditingController();
  final TextEditingController address3 = TextEditingController();
  final TextEditingController address4 = TextEditingController();
  final TextEditingController postcode = TextEditingController();
  final TextEditingController fax1 = TextEditingController();
  final TextEditingController fax2 = TextEditingController();
  Uint8List? _image;

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
    if (widget.isEdit) {
      phone1.text = widget.location.phone1 ?? '';
      phone2.text = widget.location.phone2 ?? '';
      address1.text = widget.location.address1 ?? '';
      address2.text = widget.location.address2 ?? '';
      address3.text = widget.location.address3 ?? '';
      address4.text = widget.location.address4 ?? '';
      postcode.text = widget.location.postCode ?? '';
      fax1.text = widget.location.fax1 ?? '';
      fax2.text = widget.location.fax2 ?? '';
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
            "New Location",
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
                  TextFieldWidget(
                    label: 'Location',
                    controller: location,
                    icon: Icon(
                      Icons.code,
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
          '/Location/CreateLocation?companyId=' + companyid.toString(),
          jsonEncode({
            "location": location.text.isNotEmpty ? location.text : null,
            "address1": address1.text.isNotEmpty ? address1.text : null,
            "address2": address2.text.isNotEmpty ? address2.text : null,
            "address3": address3.text.isNotEmpty ? address3.text : null,
            "address4": address4.text.isNotEmpty ? address4.text : null,
            "postCode": postcode.text.isNotEmpty ? postcode.text : null,
            "phone1": phone1.text.isNotEmpty ? phone1.text : null,
            "phone2": phone2.text.isNotEmpty ? phone2.text : null,
            "fax1": fax1.text.isNotEmpty ? fax1.text : null,
            "fax2": fax2.text.isNotEmpty ? fax2.text : null,
            "isActive": true,
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
          const SnackBar(content: Text('Duplicated Location Code')),
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

  updateData() async {
    if (_formKey.currentState!.validate()) {
      String response = await BaseClient().post(
          '/Location/UpdateLocation?Locationid=' +
              widget.location.locationID.toString(),
          jsonEncode({
            "location": location.text.isNotEmpty ? location.text : null,
            "address1": address1.text.isNotEmpty ? address1.text : null,
            "address2": address2.text.isNotEmpty ? address2.text : null,
            "address3": address3.text.isNotEmpty ? address3.text : null,
            "address4": address4.text.isNotEmpty ? address4.text : null,
            "postCode": postcode.text.isNotEmpty ? postcode.text : null,
            "phone1": phone1.text.isNotEmpty ? phone1.text : null,
            "phone2": phone2.text.isNotEmpty ? phone2.text : null,
            "fax1": fax1.text.isNotEmpty ? fax1.text : null,
            "fax2": fax2.text.isNotEmpty ? fax2.text : null,
            "isActive": true,
            "lastModifiedDateTime": getCurrentDateTime(),
            "lastModifiedUserID": userid,
            "createdDateTime": widget.location.createdDateTime,
            "createdUserID": widget.location.createdUserID,
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
