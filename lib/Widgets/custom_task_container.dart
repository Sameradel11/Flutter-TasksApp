import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_v2/cubit/data_base_cubit.dart';

class CustomTask extends StatefulWidget {
  const CustomTask({super.key, required this.mytask});
  final Map mytask;

  @override
  State<CustomTask> createState() => _CustomTaskState();
}

class _CustomTaskState extends State<CustomTask> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataBaseCubit, DataBaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        print(widget.mytask);
        DataBaseCubit cubit = DataBaseCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 40,
                child: Text(
                  widget.mytask["time"],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.mytask["title"],
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      widget.mytask['date'],
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {
                        cubit.updateTask(widget.mytask["id"], "Done");
                      },
                      icon: const Icon(Icons.check_circle))),
              Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm delete"),
                              content: const Text(
                                  "Do you want to delete this message"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.red),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      cubit.deleterecord(widget.mytask['id']);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Yes"))
                              ],
                            );
                          },
                          context: context,
                        );
                      },
                      icon: const Icon(Icons.delete))),
              Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {
                        cubit.updateTask(widget.mytask["id"], "Archived");
                      },
                      icon: const Icon(Icons.archive))),
            ],
          ),
        );
      },
    );
  }
}
