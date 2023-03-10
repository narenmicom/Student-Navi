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

class EventsDetails {
  final String ename;
  final String description;
  final String venue;
  final String? registerLink;
  final String posterLink;
  final String startDate;
  final String endDate;
  final String organiser;

  EventsDetails({
    required this.ename,
    required this.description,
    required this.venue,
    this.registerLink,
    required this.posterLink,
    required this.startDate,
    required this.endDate,
    required this.organiser,
  });

  factory EventsDetails.fromJson(Map<String, dynamic> data) {
    final ename = data['ename'] as String;
    final description = data['description'] as String;
    final venue = data['venue'] as String;
    final registerLink = data!['register_link'] as String;
    final posterLink = data['poster_link'] as String;
    final startDate = data['start_date'] as String;
    final endDate = data['end_date'] as String;
    final organiser = data['organiser'] as String;
    return EventsDetails(
      ename: ename,
      description: description,
      venue: venue,
      registerLink: registerLink,
      posterLink: posterLink,
      startDate: startDate,
      endDate: endDate,
      organiser: organiser,
    );
  }
}

class StudentAttendanceData {
  // int presentCount;
  // int totalCount;
  final String subjectName;
  // final int present;
  // final int total;
  final String percentage;

  StudentAttendanceData({
    required this.subjectName,
    // required this.present,
    // required this.total,
    required this.percentage,
  });

  // factory StudentAttendanceData.fromJson(Map<String, dynamic> data) {
  //   final subjectName = data['subject_fullname'] as String;
  //   final present = data['counts'] as int;
  //   return StudentAttendanceData(subjectName: subjectName, present: present);
  // }
}
