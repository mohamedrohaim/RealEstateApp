import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:realestate/core/helper/date_converter.dart';
import 'package:realestate/core/widgets/titles_text_widget.dart';

class AppointmentsWidgets extends StatefulWidget {
  const AppointmentsWidgets({super.key, required this.date});
  final String date;
  @override
  State<AppointmentsWidgets> createState() => _AppointmentsWidgetsState();
}

class _AppointmentsWidgetsState extends State<AppointmentsWidgets> {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.date);
    String fromattedDate = DateFormat('MMMM yyyy').format(dateTime);
    DateConverter.getDateTimeWithMonth(dateTime);
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitlesTextWidget(
              label: "Your Appoitment at ${DateConverter.getDateTimeWithMonth(dateTime)}",
              fontSize: 16,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
