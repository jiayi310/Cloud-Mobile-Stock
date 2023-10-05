import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilestock/utils/global.colors.dart';
import 'package:mobilestock/view/ClockIn/clockin.header.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:mobilestock/view/ClockIn/job.card.dart';

class ClockInHomeScreen extends StatefulWidget {
  const ClockInHomeScreen({Key? key}) : super(key: key);

  @override
  State<ClockInHomeScreen> createState() => _ClockInHomeScreenState();
}

class _ClockInHomeScreenState extends State<ClockInHomeScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: GlobalColors.mainColor,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            ClockInHeader(),
            SizedBox(
              height: 20,
            ),
            Container(
              child: CalendarTimeline(
                initialDate: DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime(2100),
                onDateSelected: (date) => print(date),
                leftMargin: 20,
                monthColor: Colors.grey,
                dayColor: Colors.black,
                activeDayColor: Colors.white,
                activeBackgroundDayColor: GlobalColors.mainColor,
                dotsColor: Color(0xFF333A47),
                locale: 'en_ISO',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            JobCard(),
          ],
        ),
      ),
    );
  }
}
