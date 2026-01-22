import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/network/supabase/database/get_stream_data.dart';
import 'package:disan/features/admin/time_lines/story/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_customers_state.dart';

class GetCustomersCubit extends Cubit<GetCustomersState> {
  GetCustomersCubit() : super(GetCustomersLoading()) {
    getCustomers();
  }
  final supabase = getIt.get<SupabaseClient>();
  StreamSubscription? _streamSubscription;
  List<UserModel> customers = [];
  getCustomers() {
    try {
      _streamSubscription = streamData(tableName: "users").listen((event) {
        if (event.isNotEmpty) {
          customers = event.map((e) => UserModel.fromJson(e)).toList();
          customers.removeWhere((element) => element.role != "customer");
          emit(GetCustomersSuccess());
        } else {
          emit(NoCustomersExist());
        }
      }, onError: (error) {
        emit(GetCustomersFailure(message: error.toString()));
      });
    } on Exception catch (e) {
      emit(GetCustomersFailure(message: e.toString()));
    }
  }
}
