import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/network/supabase/database/stream_data_with_spacific.dart';
import 'package:disan/core/notifications/fcm_notification.dart';
import 'package:disan/features/admin/customer_requests/models/customer_request_model.dart';
import 'package:disan/features/admin/time_lines/story/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_customer_requests_state.dart';

class GetCustomerRequestsCubit extends Cubit<GetCustomerRequestsState> {
  GetCustomerRequestsCubit() : super(GetCustomerRequestsLoading()) {
    getCustomerRequests();
  }
  StreamSubscription? _subscription;
  List<CustomerRequestModel> pendingCustomerRequests = [];
  List<CustomerRequestModel> processingCustomerRequests = [];
  List<CustomerRequestModel> shippedCustomerRequests = [];
  List<CustomerRequestModel> deliveredCustomerRequests = [];
  getCustomerRequests() async {
    try {
      _subscription = streamDataWithSpecificId(
              tableName: 'orders',
              id: getIt<SupabaseClient>().auth.currentUser!.id,
              primaryKey: "shop_id")
          .listen((event) async {
        if (event.isNotEmpty) {
          List<CustomerRequestModel> tempList = [];
          for (var e in event) {
            final response = CustomerRequestModel.fromJson(e);
            try {
              final userDetails = await getIt<SupabaseClient>()
                  .from('users')
                  .select()
                  .eq('id', response.customerId)
                  .single();
              response.user = UserModel.fromJson(userDetails);
            } catch (e) {
              emit(GetCustomerRequestsFailure(
                  message: 'Failed to fetch user/product details: $e'));
              return;
            }

            tempList.add(response);
          }
          pendingCustomerRequests = [];
          processingCustomerRequests = [];
          shippedCustomerRequests = [];
          deliveredCustomerRequests = [];
          for (var element in tempList) {
            if (element.status == 'pending') {
              pendingCustomerRequests.add(element);
            }
            if (element.status == 'processing') {
              processingCustomerRequests.add(element);
            }
            if (element.status == 'delivered') {
              deliveredCustomerRequests.add(element);
            }
            if (element.status == 'shipped') {
              shippedCustomerRequests.add(element);
            }
          }
          emit(GetCustomerRequestsSuccess());
        } else {
          emit(CustomerRequestsEmpty());
        }
      }, onError: (error) {
        emit(GetCustomerRequestsFailure(message: error.toString()));
      });
    } on Exception catch (e) {
      emit(GetCustomerRequestsFailure(message: e.toString()));
    }
  }

  updateCustomerRequestStatus(
      {required UserModel user,
      required String requestId,
      required String status}) async {
    try {
      emit(UpdateCustomerRequestLoading());
      await getIt<SupabaseClient>()
          .from('orders')
          .update({'status': status}).eq('id', requestId);
      String? notificationTitle, notificationBody;
      switch (status) {
        case 'processing':
          notificationBody = 'Your request has been processed';
          notificationTitle = 'Request Processed';
          break;
        case 'rejected':
          notificationBody = 'Your request has been rejected';
          notificationTitle = 'Request Rejected';
          break;
        case 'shipped':
          notificationBody = 'Your request has been shipped';
          notificationTitle = 'Request Shipped';
          break;
        case 'delivered':
          notificationBody = 'Your request has been delivered';
          notificationTitle = 'Request Delivered';
          break;
        default:
      }
      for (final token in user.tokens ?? []) {
        await getIt<NotificationsHelper>().sendNotification(
          title: notificationTitle!,
          body: notificationBody!,
          token: token,
        );
      }
      emit(UpdateCustomerRequestStatus(
        userName: user.name,
        status: status,
      ));
    } on Exception catch (e) {
      log(e.toString());
      emit(UpdateCustomerRequestFailure(message: e.toString()));
    }
  }

  deleteCustomerRequest(
      {required UserModel user,
      required String requestId,
      required String status}) async {
    try {
      emit(UpdateCustomerRequestLoading());
      await getIt<SupabaseClient>()
          .from('order_items')
          .delete()
          .eq('id', requestId);
      await getIt<SupabaseClient>().from('orders').delete().eq('id', requestId);
      String? notificationTitle, notificationBody;
      notificationBody = 'Your request has been rejected';
      notificationTitle = 'Request Rejected';
      for (final token in user.tokens ?? []) {
        await getIt<NotificationsHelper>().sendNotification(
          title: notificationTitle,
          body: notificationBody,
          token: token,
        );
      }
      emit(DeleteCustomerRequestSuccess(
        userName: user.name,
      ));
    } on Exception catch (e) {
      emit(UpdateCustomerRequestFailure(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
