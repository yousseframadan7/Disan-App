import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/home/view_models/cubit/story_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedBar extends StatelessWidget {
  final int index;
  final int position;

  const AnimatedBar({super.key, required this.index, required this.position});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.01),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cubit = context.read<StoryCubit>();
            return Stack(
              children: [
                Container(
                  height: SizeConfig.height * 0.005,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: position > index
                        ? Colors.white
                        : Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                if (position == index)
                  AnimatedBuilder(
                    animation: cubit.animationController,
                    builder: (context, _) => Container(
                      height: SizeConfig.height * 0.005,
                      width: constraints.maxWidth *
                          cubit.animationController.value,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}