import 'dart:convert';
import 'dart:developer' show log;

import 'package:code/constants/database.dart';
import 'package:code/services/auth/auth_provider.dart';
import 'package:code/utilities/generic.dart';
import 'package:code/views/attendance_view.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthProvider extends AuthProvider {
  final List<NameList> nameList = [];

  @override
  Future<void> initialize() async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }

  Future<List<NameList>> allNameList() async {
    final supabase = Supabase.instance.client;
    final data = await supabase.from('student_name').select('*');
    for (var item in data) {
      final parsed = NameList.fromJson(item);
      nameList.add(parsed);
    }
    return nameList;
  }

  void insertAttendanceRecord(takenAttendance) async {
    final supabase = Supabase.instance.client;
    try {
      List list = [];
      for (var item in takenAttendance) {
        TakenAttendanceFormat jsonTest =
            TakenAttendanceFormat(item.rollNo, item.value!);
        var data = jsonEncode(jsonTest);
        list.add(data);
      }
      final date = getTodaysDate();
      await supabase.from('attendance_2019').insert({
        'date': date,
        'present/absent': list,
      });
    } on PostgrestException catch (e) {
      log(e.toString());
    }

    // readAttendanceFromTable('iot_attendance_2019');
  }

  void readAttendanceFromTable(tablename) async {
    final supabase = Supabase.instance.client;
    final read = await supabase.from(tablename).select('*');
    final List<AttendanceBook> attendanceBookList = [];
    for (var item in read) {
      var parsed = AttendanceBook.fromJson(item);
      attendanceBookList.add(parsed);
    }
    log(attendanceBookList[0].presentAbsent.toString());
  }

  static final SupabaseAuthProvider _shared =
      SupabaseAuthProvider._sharedInstance();

  SupabaseAuthProvider._sharedInstance();

  factory SupabaseAuthProvider() => _shared;
}

class NameList {
  final String name;
  final int rollNo;
  bool? value;

  NameList({
    required this.rollNo,
    required this.name,
    this.value = false,
  });

  factory NameList.fromJson(Map<String, dynamic> data) {
    final rollNo = data['roll_no'] as int;
    final name = data['name'] as String;
    final value = data['value'] ?? false;
    return NameList(rollNo: rollNo, name: name, value: value);
  }
}

class AttendanceBook {
  final String date;
  final List presentAbsent;

  AttendanceBook({required this.date, required this.presentAbsent});

  factory AttendanceBook.fromJson(Map<String, dynamic> data) {
    final date = data['date'] as String;
    final presentAbsent = data['present/absent'] as List;
    return AttendanceBook(date: date, presentAbsent: presentAbsent);
  }
}

class TakenAttendanceFormat {
  int rollNo;
  bool value;

  TakenAttendanceFormat(this.rollNo, this.value);

  Map toJson() {
    return {"$rollNo": value ? "Present" : "Absent"};
  }
}
