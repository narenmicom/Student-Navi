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
