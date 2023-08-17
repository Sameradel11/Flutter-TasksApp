import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp_v2/Views/archivedtasks_page.dart';
import 'package:todoapp_v2/Views/donetasks_page.dart';
import 'package:todoapp_v2/Widgets/color_listview.dart';
import 'package:todoapp_v2/Widgets/custom_button.dart';
import 'package:todoapp_v2/Widgets/custom_text_field.dart';
import 'package:todoapp_v2/cubit/data_base_cubit.dart';

import '../Widgets/custom_floating_button.dart';
import '../Widgets/delete_alert.dart';
import '../Widgets/modal_bottom_sheet_content.dart';
import '../Widgets/text_fields.dart';
import 'newtasks_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> titles = ["New Tasks", "Done Tasks", "Archived Tasks"];
  final List<Widget> views = [
    const NewTasks(),
    const DoneTasks(),
    const ArchivedTasks()
  ];
  final Icon icon = const Icon(Icons.add);
  int currentindex = 0;
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataBaseCubit(),
      child: BlocConsumer<DataBaseCubit, DataBaseState>(
        listener: (context, state) {},
        builder: (context, state) {
          DataBaseCubit cubit = DataBaseCubit.get(context);
          cubit.createDataBase();
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  Text(titles[currentindex]),
                  const Spacer(flex: 1),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return DeleteAlert(
                                  titles: titles,
                                  currentindex: currentindex,
                                  cubit: cubit);
                            });
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
            ),
            floatingActionButton: CustomFloatingButton(
                formkey: formkey,
                titlecontroller: titlecontroller,
                timecontroller: timecontroller,
                datecontroller: datecontroller,
                cubit: cubit,
                icon: icon),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.amber,
              currentIndex: currentindex,
              onTap: (index) {
                currentindex = index;
                setState(() {});
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "New"),
                BottomNavigationBarItem(icon: Icon(Icons.check), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: "Archive")
              ],
            ),
            body: views[currentindex],
          );
        },
      ),
    );
  }
}

