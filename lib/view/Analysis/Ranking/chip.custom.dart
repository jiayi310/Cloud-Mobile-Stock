import 'package:flutter/material.dart';

class CustomChipWidget extends StatefulWidget {
  CustomChipWidget({
    Key? key,
    required this.label,
    required this.selected,
    required this.onSelect,
  }) : super(key: key);
  final String label;
  final bool selected;
  final Function(bool) onSelect;

  @override
  State<CustomChipWidget> createState() => _CustomChipWidgetState();
}

class _CustomChipWidgetState extends State<CustomChipWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelect(true);
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: widget.selected ? Colors.white.withOpacity(.2) : null),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(
            widget.label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          )),
    );
  }
}
