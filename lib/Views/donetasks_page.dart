import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp_v2/Widgets/custom_task_container.dart';
import 'package:todoapp_v2/cubit/data_base_cubit.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBaseCubit, DataBaseState>(
      builder: (context, state) {
        DataBaseCubit cubit = DataBaseCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) => CustomTask(
                  mytask: cubit.doneTasks[index],
                ),
            separatorBuilder: (context, idnex) =>
                Container(height: 1, color: Colors.grey),
            itemCount: cubit.doneTasks.length);
      },
    );
  }
}
