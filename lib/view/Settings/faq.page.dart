import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:mobilestock/utils/global.colors.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: GlobalColors.mainColor,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "FAQ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            FAQ(
              question:
                  "1. Question 2 dummy text of the printing and typesetting?",
              answer: data,
              queStyle: TextStyle(
                  color: GlobalColors.mainColor, fontWeight: FontWeight.bold),
              ansStyle: TextStyle(color: Colors.black),
            ),
            FAQ(
              question:
                  "1. Question 2 dummy text of the printing and typesetting?",
              answer: data,
              queStyle: TextStyle(
                  color: GlobalColors.mainColor, fontWeight: FontWeight.bold),
              ansStyle: TextStyle(color: Colors.black),
            ),
            FAQ(
              question:
                  "1. Question 2 dummy text of the printing and typesetting?",
              answer: data,
              queStyle: TextStyle(
                  color: GlobalColors.mainColor, fontWeight: FontWeight.bold),
              ansStyle: TextStyle(color: Colors.black),
            ),
          ]),
        ),
      ),
    );
  }
}

String data = """"
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
""";
