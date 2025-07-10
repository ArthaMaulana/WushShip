import 'package:flutter/foundation.dart';

import 'auth_models.dart';

class AuthService extends ChangeNotifier {
  AppAuthState _state = const AppAuthState();
  bool _disposed = false;

  AppAuthState get state => _state;
  AppUser? get currentUser => _state.user;
  bool get isAuthenticated => _state.isAuthenticated;
  bool get isLoading => _state.isLoading;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  // Mock users for testing
  final List<AppUser> _mockUsers = [
    AppUser(
      id: 'user1',
      email: 'user@test.com',
      fullName: 'Test User',
      phone: '081234567890',
      role: UserRole.user,
      createdAt: DateTime.now(),
    ),
    AppUser(
      id: 'courier1',
      email: 'courier@test.com',
      fullName: 'Test Courier',
      phone: '081234567891',
      role: UserRole.courier,
      createdAt: DateTime.now(),
    ),
  ];

  void _setState(AppAuthState newState) {
    if (_disposed) return;
    _state = newState;
    notifyListeners();
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required UserRole role,
  }) async {
    try {
      if (_disposed) return false;

      _setState(_state.copyWith(isLoading: true));

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      if (_disposed) return false;

      // Check if user already exists
      final existingUser = _mockUsers.firstWhere(
        (user) => user.email == email,
        orElse: () => AppUser(
          id: 'new_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          fullName: fullName,
          phone: phone,
          role: role,
          createdAt: DateTime.now(),
        ),
      );

      if (existingUser.id.startsWith('new_')) {
        _mockUsers.add(existingUser);
      }

      if (_disposed) return false;

      _setState(AppAuthState(user: existingUser));
      return true;
    } catch (e) {
      if (_disposed) return false;
      _setState(_state.copyWith(error: 'Sign up failed: $e', isLoading: false));
      return false;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      if (_disposed) return false;

      _setState(_state.copyWith(isLoading: true));

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      if (_disposed) return false;

      // Find user by email
      final user = _mockUsers.firstWhere(
        (user) => user.email == email,
        orElse: () => throw Exception('User not found'),
      );

      // Simple password check (in real app, this would be done server-side)
      if (password.length < 6) {
        throw Exception('Invalid password');
      }

      if (_disposed) return false;

      _setState(AppAuthState(user: user));
      return true;
    } catch (e) {
      if (_disposed) return false;
      _setState(_state.copyWith(error: 'Sign in failed: $e', isLoading: false));
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      _setState(_state.copyWith(isLoading: true));

      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      _setState(const AppAuthState());
    } catch (e) {
      _setState(_state.copyWith(error: 'Sign out failed: $e'));
    }
  }

  Future<void> switchUserRole(UserRole newRole) async {
    try {
      _setState(_state.copyWith(isLoading: true));

      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Get current user and update role
      final currentUser = _state.user;
      if (currentUser != null) {
        final updatedUser = AppUser(
          id: currentUser.id,
          email: currentUser.email,
          fullName: currentUser.fullName,
          phone: currentUser.phone,
          role: newRole,
          createdAt: currentUser.createdAt,
        );

        _setState(_state.copyWith(
          user: updatedUser,
          isLoading: false,
        ));
      } else {
        throw Exception('No user logged in');
      }
    } catch (e) {
      _setState(_state.copyWith(error: 'Switch role failed: $e'));
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      _setState(_state.copyWith(isLoading: true));

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Check if user exists
      final userExists = _mockUsers.any((user) => user.email == email);
      if (!userExists) {
        throw Exception('User not found');
      }

      _setState(_state.copyWith(isLoading: false));
      return true;
    } catch (e) {
      _setState(_state.copyWith(
          error: 'Reset password failed: $e', isLoading: false));
      return false;
    }
  }

  Future<bool> updateProfile({
    String? fullName,
    String? phone,
  }) async {
    try {
      _setState(_state.copyWith(isLoading: true));

      final currentUserData = currentUser;
      if (currentUserData == null) return false;

      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      final updatedUser = currentUserData.copyWith(
        fullName: fullName ?? currentUserData.fullName,
        phone: phone ?? currentUserData.phone,
        updatedAt: DateTime.now(),
      );

      // Update in mock users list
      final index =
          _mockUsers.indexWhere((user) => user.id == currentUserData.id);
      if (index != -1) {
        _mockUsers[index] = updatedUser;
      }

      _setState(AppAuthState(user: updatedUser));
      return true;
    } catch (e) {
      _setState(_state.copyWith(
          error: 'Update profile failed: $e', isLoading: false));
      return false;
    }
  }

  void clearError() {
    _setState(_state.copyWith(error: null));
  }
}
