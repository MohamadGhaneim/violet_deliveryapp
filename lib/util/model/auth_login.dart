class AuthLogin {
  final String fullName;
  final String token;

  AuthLogin({required this.fullName, required this.token});

  factory AuthLogin.fromJson(Map<String, dynamic> json) {
    return AuthLogin(
      fullName: json['full_name'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
