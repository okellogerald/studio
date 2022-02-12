
class VerificationStatus {
  VerificationStatus({required this.verified, required this.email});

  final bool verified;
  final String email;

  factory VerificationStatus.fromJson(Map<String, dynamic> json) {
    return VerificationStatus(
        verified: json['verified'] as bool, email: json['email'] as String);
  }

  Map<String, dynamic> toJson() => {'verified': verified, 'email': email};
}
