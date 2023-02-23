import 'package:bloc/bloc.dart';
import 'package:code/services/auth/supabaseprovider.dart';
import 'package:code/services/bloc/attendance_event.dart';
import 'package:code/services/bloc/attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc(SupabaseAuthProvider provider)
      : super(const AttendanceStateUninitialized()) {
    //initialize
    on<AttendanceEventInitialize>((event, emit) async {
      await provider.initialize();
    });

    //AttendanceGetNameList
    on<AttendanceGetNameList>(
      (event, emit) async {
        final allNamelist = await provider.allNameList();
        emit(
          AttendanceStateViewing(nameList: allNamelist),
        );
      },
    );
  }
}
