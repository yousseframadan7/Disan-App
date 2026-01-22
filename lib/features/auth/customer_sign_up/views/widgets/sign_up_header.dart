import 'package:disan/core/components/custom_icon_button.dart';
import 'package:disan/core/utilies/assets/images/app_images.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/auth/customer_sign_up/view_models/cubit/customer_sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerSignUpHeader extends StatelessWidget {
  const CustomerSignUpHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerSignUpCubit, CustomerSignUpState>(
      builder: (context, state) {
        if (state is PickImageLoading) {
          return SizedBox(
            height: SizeConfig.height * 0.3,
            child: const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          );
        }
        var cubit = context.read<CustomerSignUpCubit>();
        return SizedBox(
          height: SizeConfig.height * 0.3,
          width: SizeConfig.width,
          child: Center(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.height * 0.05,
                  ),
                  child: CircleAvatar(
                    backgroundImage: cubit.userImage == null
                        ? AssetImage(AppImages.profileImage)
                        : FileImage(cubit.userImage!) as ImageProvider,
                    radius: SizeConfig.height * 0.08,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CustomIconButton(
                    icon: Icons.upload,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.kPrimaryColor,
                    onPressed: () => cubit.pickUserImage(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
