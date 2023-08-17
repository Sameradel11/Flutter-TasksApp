import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/custom_task_container.dart';
import '../cubit/data_base_cubit.dart';

class ArchivedTasks extends StatefulWidget {
  const ArchivedTasks({super.key});

  @override
  State<ArchivedTasks> createState() => _ArchivedTasksState();
}

class _ArchivedTasksState extends State<ArchivedTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBaseCubit, DataBaseState>(
      builder: (context, state) {
        DataBaseCubit cubit = DataBaseCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) => CustomTask(
                  mytask: cubit.archivedTasks[index],
                ),
            separatorBuilder: (context, idnex) =>
                Container(height: 1, color: Colors.grey),
            itemCount: cubit.archivedTasks.length);
      },
    );
  }
}
