enum UserRole {
  user,
  courier,
}

class AppUser {
  final String id;
  final String email;
  final String? fullName;
  final String? phone;
  final UserRole role;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;

  const AppUser({
    required this.id,
    required this.email,
    this.fullName,
    this.phone,
    required this.role,
    required this.createdAt,
    this.updatedAt,
    this.metadata,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      email: json['email'],
      fullName: json['full_name'],
      phone: json['phone'],
      role: UserRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRole.user,
      ),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'phone': phone,
      'role': role.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'metadata': metadata,
    };
  }

  AppUser copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phone,
    UserRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      metadata: metadata ?? this.metadata,
    );
  }
}

class AppAuthState {
  final AppUser? user;
  final bool isLoading;
  final String? error;

  const AppAuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  AppAuthState copyWith({
    AppUser? user,
    bool? isLoading,
    String? error,
  }) {
    return AppAuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool get isAuthenticated => user != null;
  bool get isUser => user?.role == UserRole.user;
  bool get isCourier => user?.role == UserRole.courier;
}
