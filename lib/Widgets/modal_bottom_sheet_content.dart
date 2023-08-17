import 'package:flutter/cupertino.dart';
import 'package:todoapp_v2/Widgets/text_fields.dart';

import '../cubit/data_base_cubit.dart';
import 'custom_button.dart';

class ModalBottomSheetContent extends StatelessWidget {
  const ModalBottomSheetContent({
    super.key,
    required this.titlecontroller,
    required this.timecontroller,
    required this.datecontroller,
    required this.formkey,
    required this.cubit,
  });

  final TextEditingController titlecontroller;
  final TextEditingController timecontroller;
  final TextEditingController datecontroller;
  final GlobalKey<FormState> formkey;
  final DataBaseCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            right: 8,
            left: 8),
        child: Column(children: [
          TitleTextField(titlecontroller: titlecontroller),
          TimeTextField(timecontroller: timecontroller),
          DateTextField(datecontroller: datecontroller),
          CustomButton(
              text: "Add",
              ontap: () {
                if (formkey.currentState!.validate()) {
                  cubit.insertrecord(titlecontroller.text, timecontroller.text,
                      datecontroller.text, "New");
                  Navigator.pop(context);
                }
              })
        ]),
      ),
    );
  }
}
