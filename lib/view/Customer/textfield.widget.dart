import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilestock/utils/global.colors.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final Icon icon;
  List<TextInputFormatter> inputFormatters;

  TextFieldWidget({
    Key? key,
    required this.label,
    required this.icon,
    required this.controller,
    required this.onChanged,
    this.inputFormatters = const [],
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateText(val) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onChanged: (val) {},
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
                labelText: widget.label,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: GlobalColors.mainColor),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: GlobalColors.mainColor),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: GlobalColors.mainColor),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                hintText: widget.label,
                prefixIcon: widget.icon),
            controller: widget.controller,
            validator: (value) {
              if (widget.label == "Customer Code" || widget.label == "Name") {
                if (value!.isEmpty)
                  return "Cannot be empty";
                else
                  return null;
              }

              if (widget.label == "Email") {
                if (value!.isNotEmpty) {
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value!))
                    return "Enter correct email: example@gmail.com";
                  else
                    return null;
                }
              }
              if (widget.label == "Phone 1" ||
                  widget.label == "Phone 2" ||
                  widget.label == "Fax 1" ||
                  widget.label == "Fax 2") {
                if (value!.isNotEmpty) {
                  if (!RegExp(r'^[0-9\-+]*$').hasMatch(value))
                    return "Enter a valid phone number";
                  else
                    return null;
                }
                return null;
              }
            },
          )
        ],
      );
}
