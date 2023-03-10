import 'dart:developer' show log;
import 'dart:io';
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
      return user;
    } else {
      return null;
    }
  }

  Future<List<NameList>> allNameList() async {
    final supabase = Supabase.instance.client;
    final data = await supabase
        .from('student_details')
        .select('*')
        .order('roll_no', ascending: true);
    log("message");
    for (var item in data) {
      final parsed = NameList.fromJson(item);
      nameList.add(parsed);
    }
    log("rece");
    return nameList;
  }

  Future<List<String>> getsubjects() async {
    final supabase = Supabase.instance.client;
    final List<Subjects> subjectList = [];
    List<String> subject = [];
    final data = await supabase.from('subject').select('*');
    for (var item in data) {
      final parsed = Subjects.fromJson(item);
      subjectList.add(parsed);
    }
    subjectList.forEach((element) {
      subject.add(element.subjectName);
    });
    return subject;
  }

  Future<String> addAttendanceRecord(takenAttendance, String subject) async {
    try {
      var newLectureID = '';
      final supabase = Supabase.instance.client;
      final date = getTodaysDate();
      //getting subject details
      var subjectDetails = await supabase
          .from('subject')
          .select('*')
          .eq('subject_name', subject);
      subjectDetails = Subjects.fromJson(subjectDetails[0]);

      //to check if there is already lecture of a subject present
      List readFromLecture = await supabase
          .from('lecture')
          .select('*')
          .like('subject_id', '%${subjectDetails.subjectId}%');

      if (readFromLecture.isEmpty) {
        //creating new lecture id starts with 01
        newLectureID = "${subject}01";
        await supabase.from('lecture').insert({
          'lecture_id': newLectureID,
          'lecture_date': date,
          'subject_id': subjectDetails.subjectId
        });
      } else {
        // if not incrementing the existing lecture id
        var lecture =
            Lecture.fromJson(readFromLecture[readFromLecture.length - 1]);
        final currentLectureId = lecture.lectureid;
        var nextid = (int.parse(
                    currentLectureId.substring(currentLectureId.length - 2)) +
                1)
            .toString();
        if (nextid.length == 1) {
          nextid = '0$nextid';
        }
        newLectureID = subject + nextid;
        await supabase.from('lecture').insert({
          'lecture_id': newLectureID,
          'lecture_date': date,
          'subject_id': subjectDetails.subjectId
        });
      }

      for (var item in takenAttendance) {
        TakenAttendanceFormat jsonTest = TakenAttendanceFormat(
            item.rollNo, item.value ? "Present" : "Absent", item.name);
        await supabase.from('attendance2019').insert({
          'lecture_id': newLectureID,
          'roll_no': jsonTest.rollNo,
          'attendance': jsonTest.value,
          'subject_id': subjectDetails.subjectId
        });
      }
      return "sent";
    } on PostgrestException catch (e) {
      return e.toString();
    }
    // readAttendanceFromTable('iot_attendance_2019');
  }

  Future<List<StudentAttendanceData>> studentAttendanceDeatils(rollNo) async {
    final supabase = Supabase.instance.client;
    var i = 0;
    final List<StudentAttendanceData> studentAttendanceDeatils = [];
    final presentRes =
        await supabase.rpc('present_count', params: {'rollno': rollNo});
    final totalRes =
        await supabase.rpc('total_count', params: {'rollno': rollNo});
    for (var item in presentRes) {
      final totalcount = totalRes[i]['counts'] as int;
      final present = item['counts'] as int;
      final subjectName = item['subject_fullname'] as String;
      final percentage = "${((present / totalcount) * 100).round()}%";
      final parsed = StudentAttendanceData(
          subjectName: subjectName, percentage: percentage);
      studentAttendanceDeatils.add(parsed);
      i++;
    }
    return studentAttendanceDeatils;
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

  // void addStudent({
  //   required String rollNo,
  //   required String name,
  // }) async {
  //   final supabase = Supabase.instance.client;
  //   final res = await supabase.from("student_details").insert({
  //     'roll_no': rollNo,
  //     'name': name,
  //   });
  //   log(res.toString());
  // }

  void addSubject({
    required String subjectId,
    required String subjectName,
    required String subjectfullname,
  }) async {
    final res = await Supabase.instance.client.from("subject").insert({
      'subject_id': subjectId,
      'subject_name': subjectName,
      'subject_fullname': subjectfullname,
    });
    log(res.toString());
  }

  Future<String> addEvent(Map<String, dynamic>? details) async {
    final avatarFile = File(details?['eventposter'][0].path);
    final res = await supabase.rpc('lastesteventid');
    try {
      final String path = await Supabase.instance.client.storage
          .from('images')
          .upload('events/${res + 1}.jpg', avatarFile);
      final imgpath =
          "https://zfkofzdawctajysziehp.supabase.co/storage/v1/object/public/$path";
      if (imgpath != null) {
        final res = await Supabase.instance.client.from('events').insert({
          'ename': details!['ename'],
          'description': details['description'],
          'venue': details['venue'],
          'register_link': details['register_link'],
          'poster_link': imgpath,
          'start_date': details['startdate'].toIso8601String(),
          'end_date': details['enddate'].toIso8601String(),
          'organiser': details['organiser'],
        });
      }
      return "Submitted";
    } on PostgrestException catch (e) {
      return e.toString();
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<List<EventsDetails>> getEventsDetails() async {
    final List<EventsDetails> eventsDetails = [];
    final res = await Supabase.instance.client.from('events').select('*');
    for (var item in res) {
      final parsed = EventsDetails.fromJson(item);
      eventsDetails.add(parsed);
    }

    return eventsDetails;
  }

  Future<String> addNotes(Map<String, dynamic>? details) async {
    final filename = File(details?['filename'][0].path);
    try {
      final String path = await Supabase.instance.client.storage
          .from('files')
          .upload('${details!['subjectsname']}-${details!['notesname']}.pdf',
              filename);
      final filepath =
          "https://zfkofzdawctajysziehp.supabase.co/storage/v1/object/public/$path";
      if (details != null) {
        final res = await Supabase.instance.client.from('notes').insert({
          'notesname': details['notesname'],
          'subject_name': details['subjectsname'],
          'file_link': filepath,
        });
      }
      return "Submitted";
    } on PostgrestException catch (e) {
      return e.toString();
    } on Exception catch (e) {
      return e.toString();
    }
  }

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
