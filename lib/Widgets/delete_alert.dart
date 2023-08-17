import 'package:flutter/material.dart';

import '../cubit/data_base_cubit.dart';

class DeleteAlert extends StatelessWidget {
  const DeleteAlert({
    super.key,
    required this.titles,
    required this.currentindex,
    required this.cubit,
  });

  final List<String> titles;
  final int currentindex;
  final DataBaseCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete All Notes"),
      content: Text(
          "Are you sure you want to delete all \"${titles[currentindex]}\""),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No",
                style:
                    TextStyle(color: Colors.blue))),
        TextButton(
            onPressed: () {
              cubit.deleteTasks(
                  titles[currentindex].split(" ")[0]);
              Navigator.pop(context);
            },
            child: const Text(
              "YES",
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
  }
}

