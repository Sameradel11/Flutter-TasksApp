import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_v2/cubit/data_base_cubit.dart';

import '../Widgets/custom_task_container.dart';

class NewTasks extends StatefulWidget {
  const NewTasks({super.key});

  @override
  State<NewTasks> createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataBaseCubit, DataBaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        DataBaseCubit cubit = DataBaseCubit.get(context);
        cubit.newTasks.sort((a, b) => a['datetime'].compareTo(b['datetime']));
        return ListView.separated(
            itemBuilder: ((context, index) => CustomTask(
                  mytask: cubit.newTasks[index],
                )),
            separatorBuilder: ((context, index) => Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.shade100.withOpacity(0.2),
                )),
            itemCount: cubit.newTasks.length);
      },
    );
  }
}
