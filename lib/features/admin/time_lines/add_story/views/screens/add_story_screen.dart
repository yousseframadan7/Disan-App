import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/admin/time_lines/add_story/view_models/cubit/add_story_cubit.dart';
import 'package:disan/features/admin/time_lines/add_story/views/widgets/add_story_screen_body.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddStoryAndReels extends StatelessWidget {
  const AddStoryAndReels({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) =>
          AddStoryAndReelsCubit(supabaseClient: getIt<SupabaseClient>(), timeLineType: args),
      child: Scaffold(
        body: AddStoryAndReelsScreenBody(
          timeLineType: args,
        ),
      ),
    );
  }
}

