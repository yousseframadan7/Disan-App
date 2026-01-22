import 'package:disan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:disan/features/admin/offers/view_models/cubit/get_offers_cubit.dart';
import 'package:disan/features/admin/offers/views/widgets/offer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_failure_message.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_loading.dart';
import 'package:lottie/lottie.dart';

class OffersScreenBody extends StatelessWidget {
  const OffersScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetOffersCubit(),
      child: BlocBuilder<GetOffersCubit, GetOffersState>(
        builder: (context, state) {
          if (state is GetOffersFailure) {
            return CustomFailureMesage(errorMessage: state.message);
          }
          if (state is EmptyOffers) {
            return Center(child: Lottie.asset(AppLotties.emptyRequestsLottie));
          }
          if (state is GetOffersLoading) {
            return const CustomLoading();
          }
          var offers = context.read<GetOffersCubit>().offers;
          return OffersListView(offers: offers);
        },
      ),
    );
  }
}

