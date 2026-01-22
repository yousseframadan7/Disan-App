import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:disan/core/network/supabase/database/get_stream_data.dart';
import 'package:disan/features/admin/offers/models/offer_model.dart';

part 'get_offers_state.dart';

class GetOffersCubit extends Cubit<GetOffersState> {
  GetOffersCubit() : super(GetOffersLoading()) {
    getOffers();
    changeOffer();
  }

  StreamSubscription? offersubscription;
  List<OfferModel> offers = [];
  var pageController = PageController(initialPage: 0);
  int retryCount = 0;
  final int maxRetries = 3;
  changeOffer() {
    Timer.periodic(const Duration(seconds: 5), (_) {
      if (pageController.hasClients && offers.isNotEmpty) {
        int nextPage = (pageController.page?.round() ?? 0) + 1;

        if (nextPage >= offers.length) {
          nextPage = 0; // يرجع لأول صفحة
        }

        pageController.animateToPage(
          nextPage,
          duration: const Duration(seconds: 1),
          curve: Curves.linear,
        );
      }
    });
  }

  void getOffers() {
    emit(GetOffersLoading());
    try {
      offersubscription = streamData(tableName: "offers").listen(
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
