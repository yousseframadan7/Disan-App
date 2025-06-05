class AuthResponse {
  final UserData value;
  final int status;
  final bool isSuccess;
  final String successMessage;
  final String correlationId;
  final List<dynamic> errors;

  AuthResponse({
    required this.value,
    required this.status,
    required this.isSuccess,
    required this.successMessage,
    required this.correlationId,
    required this.errors,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      value: json['value'] != null
          ? UserData.fromJson(json['value'])
          : throw Exception('Missing value'),
      status: json['status'] ?? 0,
      isSuccess: json['isSuccess'] ?? false,
      successMessage: json['successMessage'] ?? '',
      correlationId: json['correlationId'] ?? '',
      errors: json['errors'] ?? [],
    );
  }
}

class UserData {
  final String userId;
  final String role;
  final String username;
  final String jwtToken;
  final String refreshToken;
  final String? error;

  UserData({
    required this.userId,
    required this.role,
    required this.username,
    required this.jwtToken,
    required this.refreshToken,
    this.error,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userId'],
      role: json['role'],
      username: json['username'],
      jwtToken: json['jwtToken'],
      refreshToken: json['refreshToken'],
      error: json['error'],
    );
  }
}
