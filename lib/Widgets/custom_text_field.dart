import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.prefix,
      this.onchange,
      this.onsaved,
      this.ontap,
      this.type = TextInputType.text,
      this.readonly = false,
      t});
  final onchange;
  final onsaved;
  final TextEditingController controller;
  final Text label;
  final prefix;
  final ontap;
  final TextInputType type;
  final bool readonly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: readonly,
        keyboardType: type,
        onTap: ontap,
        onChanged: onchange,
        onSaved: onsaved,
        controller: controller,
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
            label: label,
            prefix: prefix,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: Colors.amber)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: const BorderSide(color: Colors.black))),
        validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          );
  }
}
