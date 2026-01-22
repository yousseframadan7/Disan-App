import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/admin/customer_chats/models/customer_chat_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'get_customer_chats_state.dart';

class GetCustomerChatsCubit extends Cubit<GetCustomerChatsState> {
  GetCustomerChatsCubit() : super(GetCustomerChatsLoading()) {
    _loadChats();
  }

  final SupabaseClient supabase = getIt<SupabaseClient>();
  StreamSubscription<List<Map<String, dynamic>>>? _streamSubscription;
  final List<CustomerChatModel> chats = [];

  void _loadChats() {
    _streamSubscription = supabase
        .from('chats')
        .stream(primaryKey: ['id'])
        .eq("shop_id", getIt<SupabaseClient>().auth.currentUser!.id)
        .order('created_at')
        .listen((data) async {
          if (data.isNotEmpty) {
            chats.clear();
            for (final row in data) {
              final userResponse = await supabase
                  .from('users')
                  .select()
                  .eq('id', row['customer_id'])
                  .maybeSingle();
              final chat = CustomerChatModel.fromJson(row);
              if (userResponse != null) {
                chat.customer = CustomerModel.fromJson(userResponse);
                log(userResponse.toString());
              }
              chats.add(chat);
            }
            emit(GetCustomerChatsSuccess());
          } else {
            emit(EmptyCustomerChats());
          }
        });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
