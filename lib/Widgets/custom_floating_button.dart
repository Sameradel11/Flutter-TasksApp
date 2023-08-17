import 'package:flutter/material.dart';

import '../cubit/data_base_cubit.dart';
import 'modal_bottom_sheet_content.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
    required this.formkey,
    required this.titlecontroller,
    required this.timecontroller,
    required this.datecontroller,
    required this.cubit,
    required this.icon,
  });

  final GlobalKey<FormState> formkey;
  final TextEditingController titlecontroller;
  final TextEditingController timecontroller;
  final TextEditingController datecontroller;
  final DataBaseCubit cubit;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber,
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.grey,
            context: context,
            builder: (context) {
              return Form(
                key: formkey,
                child: ModalBottomSheetContent(
                    titlecontroller: titlecontroller,
                    timecontroller: timecontroller,
                    datecontroller: datecontroller,
                    formkey: formkey,
                    cubit: cubit),
              );
            }).whenComplete(() {
          timecontroller.clear();
          datecontroller.clear();
          titlecontroller.clear();
        });
      },
      child: icon,
    );
  }
}
