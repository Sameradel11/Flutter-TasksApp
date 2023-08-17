import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_v2/consts.dart';
import 'package:todoapp_v2/cubit/data_base_cubit.dart';

class ColorCircle extends StatefulWidget {
  ColorCircle({super.key, required this.color, required this.isactiv});
  Color color;
  bool isactiv;
  @override
  State<ColorCircle> createState() => _ColorCircleState();
}

class _ColorCircleState extends State<ColorCircle> {
  @override
  Widget build(BuildContext context) {
    return widget.isactiv
        ? CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: CircleAvatar(backgroundColor: widget.color, radius: 25),
          )
        : CircleAvatar(backgroundColor: widget.color, radius: 25);
  }
}

class ColorListView extends StatefulWidget {
  const ColorListView({super.key});

  @override
  State<ColorListView> createState() => _ColorListViewState();
}

class _ColorListViewState extends State<ColorListView> {
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBaseCubit, DataBaseState>(
      builder: (context, state) {
        DataBaseCubit cubit = DataBaseCubit.get(context);
        return ListView.builder(
            itemCount: colorlist.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  currentindex = index;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ColorCircle(
                    isactiv: currentindex == index,
                    color: colorlist[index],
                  ),
                ),
              );
            });
      },
    );
  }
}
