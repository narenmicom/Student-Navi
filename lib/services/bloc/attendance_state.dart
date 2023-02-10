import 'package:code/services/auth/supabase.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AttendanceState {
  const AttendanceState();
}

class AttendanceStateUninitialized extends AttendanceState {
  const AttendanceStateUninitialized();
}

class AttendanceStateViewing extends AttendanceState {
  final List<NameList> nameList;
  const AttendanceStateViewing({required this.nameList});
}

class AttendanceStateSendingToCloud extends AttendanceState {
  const AttendanceStateSendingToCloud();
}
