import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_models.dart';
import '../../auth/mock_auth_service.dart';

class AuthTestScreen extends StatelessWidget {
  const AuthTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication Test'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<AuthService>(
        builder: (context, authService, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Authentication Status',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                            'Is Loading', authService.isLoading.toString()),
                        _buildInfoRow('Is Authenticated',
                            authService.isAuthenticated.toString()),
                        _buildInfoRow('Current User',
                            authService.currentUser?.email ?? 'None'),
                        _buildInfoRow('Role',
                            authService.currentUser?.role.name ?? 'None'),
                        _buildInfoRow('Full Name',
                            authService.currentUser?.fullName ?? 'None'),
                        _buildInfoRow(
                            'Phone', authService.currentUser?.phone ?? 'None'),
                        if (authService.state.error != null)
                          _buildInfoRow('Error', authService.state.error!,
                              color: Colors.red),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Test Actions',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          _testSignUp(context, authService, UserRole.user),
                      child: const Text('Sign Up User'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          _testSignUp(context, authService, UserRole.courier),
                      child: const Text('Sign Up Courier'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          _testSignIn(context, authService, 'user@test.com'),
                      child: const Text('Sign In User'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          _testSignIn(context, authService, 'courier@test.com'),
                      child: const Text('Sign In Courier'),
                    ),
                    ElevatedButton(
                      onPressed: () => _testSignOut(context, authService),
                      child: const Text('Sign Out'),
                    ),
                    ElevatedButton(
                      onPressed: () => authService.clearError(),
                      child: const Text('Clear Error'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _testSignUp(
      BuildContext context, AuthService authService, UserRole role) async {
    final email =
        role == UserRole.user ? 'newuser@test.com' : 'newcourier@test.com';
    final name = role == UserRole.user ? 'New User' : 'New Courier';

    await authService.signUp(
      email: email,
      password: 'password123',
      fullName: name,
      phone: '081234567890',
      role: role,
    );
  }

  Future<void> _testSignIn(
      BuildContext context, AuthService authService, String email) async {
    await authService.signIn(
      email: email,
      password: 'password123',
    );
  }

  Future<void> _testSignOut(
      BuildContext context, AuthService authService) async {
    await authService.signOut();
  }
}
