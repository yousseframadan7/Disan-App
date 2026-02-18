abstract class GetAllProductsState {
  const GetAllProductsState();
}

class GetAllProductsInitial extends GetAllProductsState {}

class GetAllProductsLoading extends GetAllProductsState {}

class GetAllProductsLoaded extends GetAllProductsState {
  final List<Map<String, dynamic>> products;

  const GetAllProductsLoaded({required this.products});
}

class GetAllProductsError extends GetAllProductsState {
  final String errorMessage;

  const GetAllProductsError({required this.errorMessage});
}
