class ProfileModel {
  final String name;
  final String role;
  final String email;
  final String phone;
  final String address;
  final String photoUrl;
  final Map<String, dynamic>? additionalInfo;

  ProfileModel({
    required this.name,
    required this.role,
    required this.email,
    required this.phone,
    required this.address,
    required this.photoUrl,
    this.additionalInfo,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      additionalInfo: json['additionalInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'email': email,
      'phone': phone,
      'address': address,
      'photoUrl': photoUrl,
      'additionalInfo': additionalInfo,
    };
  }
}
