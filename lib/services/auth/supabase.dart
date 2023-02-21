import 'dart:convert';
import 'dart:developer' show log;
import 'package:code/constants/database.dart';
import 'package:code/utilities/data_classes.dart';
import 'package:code/utilities/generic.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthProvider {
  final List<NameList> nameList = [];
  static final SupabaseAuthProvider _shared =
      SupabaseAuthProvider._sharedInstance();

  SupabaseAuthProvider._sharedInstance();

  factory SupabaseAuthProvider() => _shared;

  Future<void> initialize() async {
    await Supabase.initialize(
      anonKey: anonKey,
      url: url,
    );
  }

  User? get currentUser {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;
    if (user != null) {
      log("Helo");
      return user;
    } else {
      return null;
    }
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
    try {
      final supabase = Supabase.instance.client;
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

  @override
  Future<User> createUser({
    required String email,
    required String password,
  }) async {
    final supabase = Supabase.instance.client;
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    final User? user = res.user;
    return user!;
  }

  @override
  Future<User> logIn({
    required String email,
    required String password,
  }) async {
    final client = Supabase.instance.client;
    final AuthResponse res = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final Session? session = res.session;
    final User? user = res.user;
    log(user.toString());
    log(session!.accessToken.toString());
    return user!;
  }

  @override
  Future<void> logOut() async {
    final client = Supabase.instance.client;
    await client.auth.signOut();
  }

  @override
  Future<void> sendPasswordReset({required String email}) async {
    final supabase = Supabase.instance.client;
    await supabase.auth.resetPasswordForEmail(email);
  }

  void dispose() {
    nameList.clear();
  }
}
