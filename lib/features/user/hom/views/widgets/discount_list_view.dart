import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/hom/view_models/cubit/get_offers_cubit.dart';
import 'package:disan/features/user/hom/views/widgets/custom_smooth_page_indecator.dart';
import 'package:disan/features/user/hom/views/widgets/discount_card.dart';
import 'package:disan/features/user/hom/views/widgets/discount_card_shimmer.dart';
import 'package:disan/features/user/hom/views/widgets/error_message.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscountListView extends StatelessWidget {
  const DiscountListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.offers.tr(), style: AppTextStyles.title20BlackW500),
        SizedBox(height: SizeConfig.height * 0.008),
        BlocProvider(
          create: (context) => GetOffersCubit(),
          child: BlocBuilder<GetOffersCubit, GetOffersState>(
            builder: (context, state) {
              var cubit = context.read<GetOffersCubit>();
              if (state is GetOffersLoading) {
                return SizedBox(
                  height: SizeConfig.height * 0.25,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    separatorBuilder: (_, __) =>
                        SizedBox(width: SizeConfig.width * 0.03),
                    itemBuilder: (context, index) =>
                        const DiscountCardShimmer(),
                  ),
                );
              }
              if (state is EmptyOffers) {
                return ErrorMessage(message: "No offers available.");
              }
              if (state is GetOffersFailure) {
                return ErrorMessage(message: state.message);
              }
              return SizedBox(
                height: SizeConfig.height * 0.27,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: cubit.pageController,
                        itemCount: cubit.offers.length,
                        itemBuilder: (context, index) {
                          return DiscountCard(
                            offerModel: cubit.offers[index],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: SizeConfig.height * 0.01),
                    CustomSmoothPageIndecator(
                      itemLength: cubit.offers.length,
                      pageController: cubit.pageController,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
