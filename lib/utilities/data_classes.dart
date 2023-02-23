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

class Subjects {
  final String subjectId;
  final String subjectName;

  Subjects({
    required this.subjectId,
    required this.subjectName,
  });

  factory Subjects.fromJson(Map<String, dynamic> data) {
    final subjectId = data['subject_id'] as String;
    final subjectName = data['subject_name'] as String;
    return Subjects(subjectId: subjectId, subjectName: subjectName);
  }
}

class Lecture {
  final String lectureid;
  final String subjectid;

  Lecture({
    required this.lectureid,
    required this.subjectid,
  });

  factory Lecture.fromJson(Map<String, dynamic> data) {
    final lectureid = data['lecture_id'] as String;
    final subjectid = data['subject_id'] as String;
    return Lecture(lectureid: lectureid, subjectid: subjectid);
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
  String value;
  String name;

  TakenAttendanceFormat(this.rollNo, this.value, this.name);

  // Map toJson() {
  //   return {"$rollNo": (value ? "Present" : "Absent")};
  // }
}