import 'package:flutter/material.dart';

import '../../utils/global.colors.dart';

class Privacy extends StatelessWidget {
  const Privacy({Key? key}) : super(key: key);

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
          "Privacy",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                "Privacy Policy",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Last updated: October 23, 2023",
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.justify,
                "This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You."
                "We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the Free Privacy Policy Generator.",
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Interpretation and Definitions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Interpretation",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  textAlign: TextAlign.justify,
                  "The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural."),
              SizedBox(
                height: 10,
              ),
              Text(
                "Definitions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  textAlign: TextAlign.justify,
                  "For the purposes of this Privacy Policy:\n"
                  "\tAccount means a unique account created for You to access our Service or parts of our Service."
                  "Affiliate means an entity that controls, is controlled by or is under common control with a party, where \"control\" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority."
                  "Application refers to Cubehous, the software program provided by the Company."
                  "Company (referred to as either \"the Company\", \"We\", \"Us\" or \"Our\" in this Agreement) refers to Presoft (M) Sdn Bhd, 2A-1, Jalan Puteri 2/5, 47100 Bandar Puteri Puchong, Selangor."
                  "Country refers to: Malaysia"
                  "Device means any device that can access the Service such as a computer, a cellphone or a digital tablet."
                  "Personal Data is any information that relates to an identified or identifiable individual."
                  "Service refers to the Application."
                  "Service Provider means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used."
                  "Third-party Social Media Service refers to any website or any social network website through which a User can log in or create an account to use the Service."
                  "Usage Data refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit)."
                  "You means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable."),
            ],
          ),
        ),
      ),
    );
  }
}
