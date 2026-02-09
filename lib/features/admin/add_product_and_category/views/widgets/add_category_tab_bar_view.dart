import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/features/admin/add_product_and_category/view_models/cubit/add_category_cubit.dart';
import 'package:disan/features/admin/add_product_and_category/views/widgets/add_category_form_fields.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';

class AddCategoryTabBarView extends StatelessWidget {
  const AddCategoryTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategoryCubit(),
      child: BlocListener<AddCategoryCubit, AddCategoryState>(
        listener: (context, state) {
          if (state is AddCategorySuccess) {
            context.popScreen();
            quickAlert(
              type: QuickAlertType.success,
              text: LocaleKeys.category_added_successfully.tr(),
              title: LocaleKeys.success.tr(), // "Success",
            );
          }
          if (state is AddCategoryFailure) {
            quickAlert(
              type: QuickAlertType.error,
              text: state.message,
              title: LocaleKeys.error.tr(), // "Error",
            );
          }
        },
        child: AddCategoryFormFiels(),
      ),
    );
  }
}
