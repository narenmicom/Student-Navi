import 'dart:developer';

import 'package:intl/intl.dart';

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

class StudentUserDetails {
  final String name;
  final int rollNo;
  final String profilePicture;

  StudentUserDetails({
    required this.name,
    required this.rollNo,
    required this.profilePicture,
  });

  factory StudentUserDetails.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final rollNo = data['roll_no'] as int;
    final profilePicture = data['profile_picture_link'] as String;
    return StudentUserDetails(
        name: name, rollNo: rollNo, profilePicture: profilePicture);
  }
}

class StaffUserDetails {
  final String name;
  final String profilePicture;

  StaffUserDetails({
    required this.name,
    required this.profilePicture,
  });

  factory StaffUserDetails.fromJson(Map<String, dynamic> data) {
    final name = data['name'] as String;
    final profilePicture = data['profile_picture_link'] as String;
    return StaffUserDetails(name: name, profilePicture: profilePicture);
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

class NotesDetails {
  final String notesName;
  final String subjectName;
  final String fileLink;

  NotesDetails({
    required this.notesName,
    required this.subjectName,
    required this.fileLink,
  });

  factory NotesDetails.fromJson(Map<String, dynamic> data) {
    final notesName = data['notesname'] as String;
    final subjectName = data['subject_name'] as String;
    final fileLink = data['file_link'] as String;
    return NotesDetails(
      notesName: notesName,
      subjectName: subjectName,
      fileLink: fileLink,
    );
  }
}

class AnnouncementDetails {
  final String announcementName;
  final String announcementType;
  final String issuingAuthority;
  final String description;
  final String attachmentLink;
  final String date;
  final String month;
  final String year;

  AnnouncementDetails({
    required this.announcementName,
    required this.announcementType,
    required this.issuingAuthority,
    required this.description,
    required this.attachmentLink,
    required this.date,
    required this.month,
    required this.year,
  });

  factory AnnouncementDetails.fromJson(Map<String, dynamic> data) {
    final announcementName = data['announcement_name'] as String;
    final announcementType = data['announcement_type'] as String;
    final issuingAuthority = data['issuing_authority'] as String;
    final description = data['description'] ?? 'null';
    final attachmentLink = data['attachment_link'] as String;
    final month = DateFormat('MMM').format(DateTime.parse(data['created_at']));
    final date = DateFormat('dd').format(DateTime.parse(data['created_at']));
    final year = DateFormat('yy').format(DateTime.parse(data['created_at']));
    return AnnouncementDetails(
      announcementName: announcementName,
      announcementType: announcementType,
      issuingAuthority: issuingAuthority,
      description: description,
      attachmentLink: attachmentLink,
      date: date,
      month: month,
      year: year,
    );
  }
}

class EventsDetails {
  final int eventId;
  final String ename;
  final String description;
  final String venue;
  final String registerLink;
  final String posterLink;
  final String date;
  final String startTime;
  final String endTime;
  final String organiser;

  EventsDetails({
    required this.eventId,
    required this.ename,
    required this.description,
    required this.venue,
    required this.registerLink,
    required this.posterLink,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.organiser,
  });

  factory EventsDetails.fromJson(Map<String, dynamic> data) {
    final eventId = data['eid'] as int;
    final ename = data['ename'] as String;
    final description = data['description'] as String;
    final venue = data['venue'] as String;
    final registerLink = data['register_link'] as String;
    final posterLink = data['poster_link'] as String;
    var startDate = DateTime.parse(data['start_date']);
    // var endDate = data['end_date'] as String;
    final organiser = data['organiser'] as String;
    final formattedDate = DateFormat('EEEE, MMMM dd, yyyy').format(startDate);
    final startTime = DateFormat('h:mma').format(startDate);
    final endTime =
        DateFormat('h:mma').format(DateTime.parse(data['end_date']));
    // var strtDate = ;
    return EventsDetails(
      eventId: eventId,
      ename: ename,
      description: description,
      venue: venue,
      registerLink: registerLink,
      posterLink: posterLink,
      date: formattedDate,
      startTime: startTime,
      endTime: endTime,
      organiser: organiser,
    );
  }
}

class LectureList {
  final String lectureDate;
  final String lectureId;

  LectureList({required this.lectureDate, required this.lectureId});

  factory LectureList.fromJson(Map<String, dynamic> data) {
    final lectureDate =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(data['lecture_date']));
    final lectureId = data['lecture_id'] as String;
    return LectureList(lectureDate: lectureDate, lectureId: lectureId);
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
