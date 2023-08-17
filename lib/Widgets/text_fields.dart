import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'custom_text_field.dart';

class DateTextField extends StatelessWidget {
  const DateTextField({
    super.key,
    required this.datecontroller,
  });

  final TextEditingController datecontroller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: CustomTextField(
        readonly: true,
        ontap: () async {
          DateTime currentdate = DateTime.now();
          DateTime? selecteddate = await showDatePicker(
              context: context,
              initialDate: currentdate,
              firstDate: DateTime.now(),
              lastDate: DateTime(2100));

          if (selecteddate != null) {
            String textformatted = DateFormat.yMd().format(selecteddate);
            datecontroller.text = textformatted;
            currentdate = selecteddate;
          }
        },
        controller: datecontroller,
        label: const Text(
          "Date",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        prefix: const Padding(
            padding: EdgeInsets.only(right: 8), child: Icon(Icons.date_range)),
      ),
    );
  }
}

class TimeTextField extends StatelessWidget {
  const TimeTextField({super.key, required this.timecontroller});
  final timecontroller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: CustomTextField(
        readonly: true,
        ontap: () async {
          TimeOfDay currentdate = TimeOfDay.now();
          TimeOfDay? selectedtime =
              await showTimePicker(context: context, initialTime: currentdate);
          if (selectedtime != null) {
            timecontroller.text = selectedtime.format(context).toString();
            currentdate = selectedtime;
          }
        },
        controller: timecontroller,
        label: const Text(
          "Time",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        prefix: const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.watch_later_outlined)),
      ),
    );
  }
}

class TitleTextField extends StatelessWidget {
  const TitleTextField({super.key, required this.titlecontroller});
  final titlecontroller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: CustomTextField(
        controller: titlecontroller,
        label: const Text(
          "Title",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        prefix: const Padding(
            padding: EdgeInsets.only(right: 8), child: Icon(Icons.title)),
      ),
    );
  }
}
