import 'dart:developer' show log;

import 'package:code/constants/database.dart';
import 'package:code/services/auth/auth_provider.dart';
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
