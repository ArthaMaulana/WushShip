# WushShip Authentication Setup Guide

## 1. Supabase Setup

### Step 1: Create Supabase Project
1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Create a new project
3. Wait for the project to be ready

### Step 2: Get Project Credentials
1. Go to Settings → API
2. Copy your **Project URL** and **anon public key**
3. Replace the values in `lib/auth/supabase_config.dart`:

```dart
static const String supabaseUrl = 'https://your-project-id.supabase.co';
static const String supabaseAnonKey = 'your-anon-key-here';
```

### Step 3: Create Database Tables
1. Go to SQL Editor in your Supabase dashboard
2. Run the following SQL commands:

```sql
-- Create user_profiles table
CREATE TABLE user_profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  phone TEXT,
  role TEXT NOT NULL CHECK (role IN ('user', 'courier')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  metadata JSONB
);

-- Create Row Level Security (RLS) policies
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

-- Users can only see and update their own profile
CREATE POLICY "Users can view own profile" ON user_profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON user_profiles
  FOR UPDATE USING (auth.uid() = id);

-- Allow users to insert their own profile during registration
CREATE POLICY "Users can insert own profile" ON user_profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Create function to handle user registration
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.user_profiles (id, email, full_name, phone, role)
  VALUES (
    new.id,
    new.email,
    new.raw_user_meta_data->>'full_name',
    new.raw_user_meta_data->>'phone',
    new.raw_user_meta_data->>'role'
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to automatically create user profile on signup
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();
```

## 2. Authentication Flow

### Features Implemented:
✅ **Role-based Authentication**: Users and Couriers have separate login flows
✅ **Registration**: New users can sign up with email/password
✅ **Login**: Existing users can sign in
✅ **Auto-routing**: Users are automatically redirected to appropriate screens
✅ **Error Handling**: Proper error messages and loading states
✅ **Profile Management**: User profiles stored in Supabase

### Screen Flow:
1. **App Launch** → `SplashScreen` → `AuthWrapper`
2. **Not Authenticated** → `RoleSelectionScreen`
3. **Select User** → `UserLoginScreen` → `HomeScreen`
4. **Select Courier** → `CourierLoginScreen` → `CourierDashboardScreen`

## 3. Testing the Implementation

### Test Users (after setup):
1. **User Account**:
   - Email: user@test.com
   - Password: password123
   - Role: user

2. **Courier Account**:
   - Email: courier@test.com
   - Password: password123
   - Role: courier

### How to Test:
1. Run the app: `flutter run`
2. Try registering new accounts
3. Test login with existing accounts
4. Verify role-based navigation

## 4. Security Features

- **Row Level Security (RLS)**: Users can only access their own data
- **Email Verification**: Can be enabled in Supabase auth settings
- **Password Reset**: Implemented in auth service
- **Secure Token Storage**: Handled by Supabase Flutter SDK

## 5. Future Enhancements

- [ ] Email verification flow
- [ ] Social login (Google, Facebook)
- [ ] Two-factor authentication
- [ ] Profile photo upload
- [ ] Push notifications
- [ ] Real-time chat system
- [ ] Location tracking for couriers

## 6. File Structure

```
lib/
├── auth/
│   ├── auth_models.dart      # User and auth state models
│   ├── auth_service.dart     # Authentication service
│   └── supabase_config.dart  # Supabase configuration
├── screens/
│   ├── auth/
│   │   ├── role_selection_screen.dart
│   │   ├── user_login_screen.dart
│   │   └── courier_login_screen.dart
│   ├── user/
│   │   └── home_screen.dart
│   └── courier/
│       └── courier_dashboard_screen.dart
└── main.dart                # Updated with auth wrapper
```

## 7. Dependencies Added

```yaml
dependencies:
  supabase_flutter: ^2.9.1
  provider: ^6.1.1
```

## Troubleshooting

### Common Issues:
1. **"Invalid API key"** → Check your Supabase credentials
2. **"Table doesn't exist"** → Run the SQL setup commands
3. **"RLS policy violation"** → Check your database policies
4. **Build errors** → Run `flutter clean` and `flutter pub get`

### Debug Mode:
Set `debug: true` in `supabase_config.dart` for detailed logs.
