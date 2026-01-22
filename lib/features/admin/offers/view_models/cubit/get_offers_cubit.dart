import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/network/supabase/database/stream_data_with_spacific.dart';
import 'package:disan/features/admin/offers/models/offer_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'get_offers_state.dart';

class GetOffersCubit extends Cubit<GetOffersState> {
  GetOffersCubit() : super(GetOffersInitial()){
    getOffers();
  }
  StreamSubscription? offersubscription;
  List<OfferModel> offers = [];
  int retryCount = 0;
  final int maxRetries = 3;

  void getOffers() {
    emit(GetOffersLoading());
    try {
      offersubscription = streamDataWithSpecificId(
              tableName: "offers",
              id: getIt<SupabaseClient>().auth.currentUser!.id,
              primaryKey: "shop_id")
          .listen(
        (event) {
          if (event.isNotEmpty) {
            offers = event.map((e) => OfferModel.fromJson(e)).toList();
            emit(GetOffersSuccess());
          } else {
            emit(EmptyOffers());
          }
        },
        onError: (error) async {
          if (retryCount < maxRetries) {
            retryCount++;
            emit(GetOffersLoading());
            await Future.delayed(const Duration(seconds: 1));
            getOffers();
          } else {
            emit(GetOffersFailure(message: error.toString()));
          }
        },
      );
    } on Exception catch (e) {
      emit(GetOffersFailure(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    offersubscription?.cancel();
    return super.close();
  }
}
