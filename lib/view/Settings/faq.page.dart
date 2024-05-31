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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                "General",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            FAQ(
              question: "1. What is Cubehous?",
              answer:
                  "Cubehous is a cloud-based platform designed to streamline sales processes and warehouse management. It offers comprehensive tools for inventory tracking, order management, sales analytics, and more to help businesses operate more efficiently.",
              queStyle: TextStyle(
                  color: GlobalColors.mainColor, fontWeight: FontWeight.bold),
              ansStyle: TextStyle(color: Colors.black),
            ),
            FAQ(
              question: "2. How do I access Cubehous?",
              answer:
                  "Cubehous can be accessed via a web browser on your computer or by downloading the Cubehous app from the Apple App Store for iOS devices and the Google Play Store for Android devices.",
              queStyle: TextStyle(
                  color: GlobalColors.mainColor, fontWeight: FontWeight.bold),
              ansStyle: TextStyle(color: Colors.black),
            ),
            FAQ(
              question: "3. How do I create an account on Cubehous?",
              answer:
                  "To create an account, visit the Cubehous website (www.cubehous.com) or open the app and click on the \"Sign Up\" button. Follow the prompts to enter your business details, email address, and create a password.",
              queStyle: TextStyle(
                  color: GlobalColors.mainColor, fontWeight: FontWeight.bold),
              ansStyle: TextStyle(color: Colors.black),
            ),
            FAQ(
              question: "4. How does Cubehous ensure the security of my data?",
              answer:
                  "Cubehous uses advanced security measures, including encryption and secure data centers, to protect your data. We comply with industry standards and regulations to ensure your information is safe. For more details, please refer to our Privacy Policy.",
              queStyle: TextStyle(
                  color: GlobalColors.mainColor, fontWeight: FontWeight.bold),
              ansStyle: TextStyle(color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                "Features and Usage",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            FAQ(
              question: "1. Which kind of business needs this solution?",
              answer:
                  "Any kind of business who need to manage stock in warehouse in an organize and efficient way, and also want to manage stock take, stock received and issues sales bill in mobility",
              queStyle: TextStyle(
                  color: GlobalColors.mainColor, fontWeight: FontWeight.bold),
              ansStyle: TextStyle(color: Colors.black),
            ),
            FAQ(
              question:
                  "2. Does this app can integrate with other software or application?",
              answer:
                  " Yes, Cubehous supports integration with popular accounting software like Autocount.",
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
