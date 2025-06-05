// import 'dart:developer';
// import 'package:bloc/bloc.dart';
// import 'package:disan/core/cache/cache_helper.dart';
// import 'package:disan/core/di/dependancy_injection.dart';
// import 'package:disan/features/auth/sign_in/models/auth_response_model.dart';
// import 'package:disan/features/auth/sign_in/models/user_model.dart';
// import 'package:flutter/material.dart';
// part 'sign_in_state.dart';

// class SignInCubit extends Cubit<SignInState> {
//   SignInCubit() : super(SignInInitial());
//   final docotrFormKey = GlobalKey<FormState>();
//   final studentFormKey = GlobalKey<FormState>();
//   AuthResponse? authResponde;
//   UserModel? userModel;
//   //! controllers
//   final doctorEmailController = TextEditingController();
//   final doctorPasswordController = TextEditingController();
//   final doctorUserNameController = TextEditingController();
//   final studentUserNameController = TextEditingController();
//   final studentEmailController = TextEditingController();
//   final studentPasswordController = TextEditingController();

//   //! sign in function
//   //as a student
//   Future<void> signInAsStudent() async {
//     if (studentFormKey.currentState!.validate()) {
//       try {
//         emit(SignInLoading());
//         var response = await apiConsumer.post(
//           EndPoints.loginAsStudent,
//           data: {
//             ApiKeys.userName: studentUserNameController.text,
//             ApiKeys.password: studentPasswordController.text,
//           },
//         );
//         authResponde = AuthResponse.fromJson(response);
//         await saveUserData();
//         emit(SignInSuccess(route: ""));
//       } on Exception catch (e) {
//         emit(SignInFailure(message: e.toString()));
//       }
//     }
//   }
//   //as a doctor
//   Future<void> signInAsDoctor() async {
//     if (docotrFormKey.currentState!.validate()) {
//       try {
//         emit(SignInLoading());
//         var response = await apiConsumer.post(
//           EndPoints.loginAsDoctor,
//           data: {
//             ApiKeys.userName: doctorUserNameController.text,
//             ApiKeys.password: doctorPasswordController.text,
//           },
//         );
//         authResponde = AuthResponse.fromJson(response);
//         await saveUserData();
//         emit(SignInSuccess(route: ""));
//       } on Exception catch (e) {
//         emit(SignInFailure(message: e.toString()));
//       }
//     }
//   }

//   Future<void> saveUserData() async {
//     userModel = UserModel(
//       username: authResponde!.value.username,
//       id: authResponde!.value.userId,

//     );
//     log(userModel!.id.toString());
//     await getIt.get<CacheHelper>().saveUserModel(userModel!);
//   }
// }
