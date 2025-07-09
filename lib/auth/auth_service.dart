import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_models.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  AppAuthState _state = const AppAuthState();

  AppAuthState get state => _state;
  AppUser? get currentUser => _state.user;
  bool get isAuthenticated => _state.isAuthenticated;
  bool get isLoading => _state.isLoading;

  AuthService() {
    _init();
  }

  void _init() {
    // Listen to auth state changes
    _supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session != null) {
        _loadUserProfile(session.user.id);
      } else if (event == AuthChangeEvent.signedOut) {
        _setState(const AppAuthState());
      }
    });

    // Check if user is already signed in
    final session = _supabase.auth.currentSession;
    if (session != null) {
      _loadUserProfile(session.user.id);
    }
  }

  void _setState(AppAuthState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> _loadUserProfile(String userId) async {
    try {
      _setState(_state.copyWith(isLoading: true));

      final response = await _supabase
          .from('user_profiles')
          .select()
          .eq('id', userId)
          .single();

      final user = AppUser.fromJson(response);
      _setState(AppAuthState(user: user));
    } catch (e) {
      _setState(AppAuthState(error: 'Failed to load user profile: $e'));
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required UserRole role,
  }) async {
    try {
      _setState(_state.copyWith(isLoading: true));

      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone': phone,
          'role': role.name,
        },
      );

      if (response.user != null) {
        // Create user profile
        await _supabase.from('user_profiles').insert({
          'id': response.user!.id,
          'email': email,
          'full_name': fullName,
          'phone': phone,
          'role': role.name,
          'created_at': DateTime.now().toIso8601String(),
        });

        return true;
      }
      return false;
    } catch (e) {
      _setState(_state.copyWith(error: 'Sign up failed: $e', isLoading: false));
      return false;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _setState(_state.copyWith(isLoading: true));

      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return response.user != null;
    } catch (e) {
      _setState(_state.copyWith(error: 'Sign in failed: $e', isLoading: false));
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      _setState(_state.copyWith(error: 'Sign out failed: $e'));
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      _setState(_state.copyWith(isLoading: true));

      await _supabase.auth.resetPasswordForEmail(email);
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

      final userId = currentUser?.id;
      if (userId == null) return false;

      final updates = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (fullName != null) updates['full_name'] = fullName;
      if (phone != null) updates['phone'] = phone;

      await _supabase.from('user_profiles').update(updates).eq('id', userId);

      // Reload user profile
      await _loadUserProfile(userId);
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
