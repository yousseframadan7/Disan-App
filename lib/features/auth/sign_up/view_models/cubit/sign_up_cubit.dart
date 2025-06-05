// import 'package:bloc/bloc.dart';
// import 'package:disan/core/network/api/api_consumer.dart';
// import 'package:disan/core/network/api/end_points.dart';
// import 'package:flutter/material.dart';

// part 'sign_up_state.dart';

// class SignUpCubit extends Cubit<SignUpState> {
//   SignUpCubit({required this.apiConsumer}) : super(SignUpInitial());
//   final ApiConsumer apiConsumer;
//   final docotrFormKey = GlobalKey<FormState>();
//   final studentFormKey = GlobalKey<FormState>();
//   bool acceptTerms = false;
//   //! controllers
//   final doctorUserNameController = TextEditingController();
//   final doctorEmailController = TextEditingController();
//   final doctorPasswordController = TextEditingController();
//   final studentEmailController = TextEditingController();
//   final studentPasswordController = TextEditingController();
//   final studentUserNameController = TextEditingController();
//   //! sign up function
//   // as a student
//   Future<void> signUpAsStudent() async {
//     if (acceptTerms == false) {
//       emit(AcceptTermsAndPolicy());
//       return;
//     }
//     try {
//       emit(SignUpLoading());
//       await apiConsumer.post(
//         EndPoints.registerAsStudent,
//         data: {
//           ApiKeys.userName: studentUserNameController.text,
//           ApiKeys.email: studentEmailController.text,
//           ApiKeys.password: studentPasswordController.text,
//           ApiKeys.ip: DateTime.now().millisecondsSinceEpoch.toString(),
//         },
//       );
//       emit(SignUpSuccess());
//     } on Exception catch (e) {
//       emit(SignUpFailure(message: e.toString()));
//     }
//   }

//   // as a doctor
//   Future<void> signUpAsDoctor() async {
//     if (acceptTerms == false) {
//       emit(AcceptTermsAndPolicy());
//       return;
//     }
//     try {
//       emit(SignUpLoading());
//       await apiConsumer.post(
//         EndPoints.registerAsDoctor,
//         data: {
//           ApiKeys.userName: doctorUserNameController.text,
//           ApiKeys.email: doctorEmailController.text,
//           ApiKeys.password: doctorPasswordController.text,
//         },
//       );
//       emit(SignUpSuccess());
//     } on Exception catch (e) {
//       emit(SignUpFailure(message: e.toString()));
//     }
//   }

//   //! change accept terms
//   void changeAcceptTerms() {
//     acceptTerms = !acceptTerms;
//     emit(ChangeTermsAndPolicyState());
//   }
// }
