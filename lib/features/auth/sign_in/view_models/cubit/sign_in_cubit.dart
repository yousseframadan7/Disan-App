import 'package:bloc/bloc.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/network/supabase/auth/sign_in_with_password.dart';
import 'package:disan/features/admin/time_lines/story/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  UserModel? userModel;
  //! sign in function
  //as a student
  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      try {
        emit(SignInLoading());
        await signInWithPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await saveUserData();
        if (state is SignInFailure) {
          return;
        } else {
          emit(SignInSuccess(route: ""));
        }
      } on Exception catch (e) {
        emit(SignInFailure(message: e.toString()));
      }
    }
  }

  Future<void> saveUserData() async {
    final supabase = getIt<SupabaseClient>();
    final firebaseMessaging = getIt<FirebaseMessaging>();
    final response = await getIt<SupabaseClient>()
        .from("users")
        .select()
        .eq("id", getIt<SupabaseClient>().auth.currentUser!.id)
        .single();
    userModel = UserModel.fromJson(response);
    final selectedRole = getIt<CacheHelper>().getData(key: "role");
    if (userModel!.role != selectedRole) {
      emit(SignInFailure(message: "You are not a $selectedRole"));
      return;
    }
    await getIt<CacheHelper>().saveUserModel(userModel!);
    final token = await firebaseMessaging.getToken();
    final currentTokens = userModel!.tokens ?? [];
    if (!currentTokens.contains(token)) {
      final updatedTokens = [...currentTokens, token];
      await supabase.from("users").update({"token": updatedTokens}).eq(
          "id", supabase.auth.currentUser!.id);
    }
  }
}
