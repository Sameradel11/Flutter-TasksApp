import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../consts.dart';
part 'data_base_cubit_state.dart';

class DataBaseCubit extends Cubit<DataBaseState> {
  DataBaseCubit() : super(DataBaseCubitInitial());
  Database? mydatabase;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  DateTime? selectedDateandtime;
  static DataBaseCubit get(context) {
    return BlocProvider.of(context);
  }

  createDataBase() async {
    Database db =
        await openDatabase("ToDoApp.db", version: 1, onCreate: (db, version) {
      try {
        db.execute(
            "Create Table $KtableName (id integer primary key  ,title String ,time String,date String,datetime String,color integer,status String)");
        print("Table created Succesfully");
      } on Exception catch (e) {
        print("There is an Exception when creating the table $e");
      }
    }, onOpen: (db) {
      print("Data Base IS open");
      mydatabase = db;
      getrecords(db);
      print("Data Retrieved Succesfully");
      emit(DataBaseCubitSuccess());
    });
  }

  void getrecords(db) async {
    List<Map> alldata = [];
    alldata = await db!.rawQuery("select * from $KtableName");
    print(alldata);
    alldata.forEach((element) {
      if (element["status"] == "New") {
        newTasks.add(element);
      } else if (element["status"] == "Done") {
        doneTasks.add(element);
      } else if (element["status"] == "Archived") {
        archivedTasks.add(element);
      }
    });
    print("archivedTasks is $archivedTasks");
    emit(DataBaseCubitSuccess());
  }

  void deleterecord(int? id) async {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    await mydatabase!.rawDelete("DELETE FROM $KtableName WHERE id = $id");
    getrecords(mydatabase);
    emit(DataBaseCubitSuccess());
  }

  void updateTask(int id, String status) async {
    newTasks = [];
    archivedTasks = [];
    doneTasks = [];
    await mydatabase!
        .rawUpdate('UPDATE $KtableName SET status ="$status"  WHERE id = $id');
    getrecords(mydatabase);
  }

  void insertrecord(
      String title, String time, String date, String status) async {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    String formattedtime = formattime(time);
    String formatteddate = formatdate(date);
    int n = await mydatabase!.rawInsert(
        "Insert into $KtableName(title,time,date,datetime,status) values('$title','$time','$date','$formatteddate $formattedtime','New')");
    getrecords(mydatabase);
    emit(DataBaseCubitSuccess());
  }

  String formatdate(String date) {
    List<String> datelist = date.split("/");
    String year = datelist[2];
    String month = formatzero(datelist[0]);
    String day = formatzero(datelist[1]);
    String formatteddate = "$year/$month/$day";
    return formatteddate;
  }

  String formatzero(String time) {
    if (time.length < 2) {
      time = "0$time";
    }
    return time;
  }

  String format24(String hour, String minute) {
    if (minute.contains("PM") && hour != "12") {
      hour = "${int.parse(hour) + 12}";
    }
    return hour;
  }

  String formattime(String time) {
    List<String> timelist = time.split(":");
    String hour = formatzero(timelist[0]);
    String minute = formatzero(timelist[1]);

    if (time.contains("AM") && time.contains("12")) {
      hour = "00";
    }
    if (minute.contains("PM")) {
      hour = format24(hour, minute);
    }
    return "$hour:$minute";
  }

  deleteTasks(String status) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    mydatabase!.rawDelete("Delete from $KtableName where status =\"$status\"");
    getrecords(mydatabase);
  }
}
