import 'package:disan/features/user/hom/view_models/cubit/get_trending_shops_cubit.dart';
import 'package:disan/features/user/hom/views/widgets/error_message.dart';
import 'package:disan/features/user/hom/views/widgets/loading_trending_shop_shimmer.dart';
import 'package:disan/features/user/hom/views/widgets/trending_shop_list_view.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingShops extends StatelessWidget {
  const TrendingShops({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTrendingShopsCubit, GetTrendingShopsState>(
      builder: (context, state) {
        if (state is GetTrendingShopsLoading) {
          return const LoadingTrendingShopsShimmer();
        } else if (state is GetTrendingShopsSuccess) {
          final cubit = context.read<GetTrendingShopsCubit>();
          return TrendingShopListView(
            shopsCubit: cubit,
          );
        } else if (state is GetTrendingShopsFailure) {
          return ErrorMessage(message: state.message);
        } else if (state is EmptyTrendingShops) {
          return ErrorMessage(message: LocaleKeys.no_trending_shops_available.tr(),); //"No trending shops available.");
        }
        return const SizedBox.shrink();
      },
    );
  }
}



