import 'dart:developer' show log;

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthProvider {
  final List<NameList> nameList = [];

  Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://zfkofzdawctajysziehp.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpma29memRhd2N0YWp5c3ppZWhwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzU4NDYxNjQsImV4cCI6MTk5MTQyMjE2NH0.I_GbARbLFM4HU4AuzicpbWD8i4bCsAdvxxwL5kurKPM',
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

  NameList({
    required this.rollNo,
    required this.name,
  });

  factory NameList.fromJson(Map<String, dynamic> data) {
    final rollNo = data['roll_no'] as int;
    final name = data['name'] as String;
    return NameList(rollNo: rollNo, name: name);
  }
}
