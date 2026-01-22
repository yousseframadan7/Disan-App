import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/profile_details/view_models/cubit/update_profile_cubit.dart';
import 'package:disan/features/user/profile_details/views/widgets/profile_details_fields.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';

class ProfileDetailsScreenBody extends StatelessWidget {
  const ProfileDetailsScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.03,
            vertical: SizeConfig.height * 0.02,
          ),
          child: BlocProvider(
            create: (context) => UpdateProfileCubit(),
            child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
              listener: (context, state) {
                if (state is UpdateProfileSuccess) {
                  quickAlert(
                    type: QuickAlertType.success,
                    text: LocaleKeys.profile_updated_successfully.tr(),
                    title: LocaleKeys.success.tr(),
                  );
                }
                if (state is PickImageFailure) {
                  quickAlert(
                    type: QuickAlertType.error,
                    text: state.message,
                    title: LocaleKeys.error.tr(),
                  );
                }

                if (state is UpdateProfileEmail) {
                  quickAlert(
                    type: QuickAlertType.confirm,
                    text: LocaleKeys.verify_email_to_update.tr(),
                    title: LocaleKeys.info.tr(),
                  );
                }

                if (state is UpdateProfileFailure) {
                  quickAlert(
                    type: QuickAlertType.error,
                    text: state.message,
                    title: LocaleKeys.error.tr(),
                  );
                }
                if (state is NoChangeProfile) {
                  quickAlert(
                    type: QuickAlertType.info,
                    title: LocaleKeys.info.tr(),
                    text: LocaleKeys.no_changes_made.tr(),
                  );
                }
              },
              child: const ProfileDetailsFields(),
            ),
          ),
        ),
      ),
    );
  }
}
