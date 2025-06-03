class UserModel {
  final String uid;
  final String email;
  final DateTime? createdAt;

  UserModel({required this.uid, required this.email, this.createdAt});

  factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
    return UserModel(
      uid: uid,
      email: data['email'] ?? '',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'createdAt': createdAt,
    };
  }
}
