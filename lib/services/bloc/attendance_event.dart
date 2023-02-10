import 'package:flutter/foundation.dart';

@immutable
abstract class AttendanceEvent {
  const AttendanceEvent();
}

class AttendanceEventInitialize extends AttendanceEvent {
  const AttendanceEventInitialize();
}

class AttendanceGetNameList extends AttendanceEvent {
  const AttendanceGetNameList();
}

class AttendanceSendToCloud extends AttendanceEvent {
  const AttendanceSendToCloud();
}
