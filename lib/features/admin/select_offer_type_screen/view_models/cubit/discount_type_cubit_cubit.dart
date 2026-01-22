import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'discount_type_cubit_state.dart';

class DiscountTypeCubit extends Cubit<String?> {
  DiscountTypeCubit() : super(null);

  void selectDiscountType(String keyValue) {
    emit(keyValue);
  }
}
