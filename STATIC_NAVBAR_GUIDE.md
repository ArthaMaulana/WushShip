# Static Bottom Navigation Bar dengan Smooth Page Transitions

## Overview

Implementasi ini memberikan bottom navigation bar yang **statis** (tidak ikut berpindah) dengan transisi halaman yang **smooth** dan **konsisten** untuk semua halaman utama aplikasi WushShip.

## Arsitektur Implementasi

### 1. MainNavigationWrapper (`lib/widgets/navigation/main_navigation_wrapper.dart`)

**Komponen utama** yang mengelola navigation dan transisi:

```dart
// Menggunakan PageView dengan controller untuk smooth transition
PageView(
  controller: _pageController,
  physics: const NeverScrollableScrollPhysics(), // Disable swipe
  children: _screens,
)

// Bottom navigation bar statis
UserBottomNavBar(
  currentIndex: _currentIndex,
  onTap: _onNavTap,
)
```

**Fitur:**
- ✅ Bottom navbar **statis** (tidak ikut berpindah)
- ✅ Transisi **fade** + **slide** yang smooth (350ms)
- ✅ Animasi fade opacity (0.8 → 1.0) saat transisi
- ✅ Disable swipe gesture untuk mencegah navigasi accidental
- ✅ Haptic feedback pada tap navbar

### 2. Screen Body Components

Setiap halaman utama memiliki **body content** terpisah yang hanya berisi konten tanpa Scaffold:

- `lib/screens/user/content/home_screen_body.dart` - Homepage content
- `lib/screens/user/content/my_order_screen_body.dart` - My Orders content  
- `lib/screens/user/content/premium_screen_body.dart` - Premium content
- `lib/screens/user/content/profile_screen_body.dart` - Profile content

**Fitur:**
- ✅ Fade-in animation (500ms) saat screen pertama kali load
- ✅ SafeArea dan SliverAppBar untuk handling status bar
- ✅ Custom scroll behavior dengan CustomScrollView
- ✅ Responsive design dan proper padding

### 3. Enhanced UserBottomNavBar (`lib/widgets/user/user_bottom_nav_bar.dart`)

Bottom navigation dengan **animated feedback**:

```dart
// Icon scaling animation saat selected
AnimatedScale(
  scale: isSelected ? 1.2 : 1.0,
  duration: const Duration(milliseconds: 200),
  curve: Curves.elasticOut,
)

// Label fade animation
AnimatedOpacity(
  opacity: isSelected ? 1.0 : 0.6,
  duration: const Duration(milliseconds: 200),
)
```

**Fitur:**
- ✅ Icon **scaling** animation saat selected
- ✅ Label **fade** animation
- ✅ **Shadow elevation** yang dinamis
- ✅ **Haptic feedback** saat tap
- ✅ Rounded corner design dengan shadow

## Implementasi Integration

### Entry Point (main.dart)

```dart
// User authenticated diarahkan ke MainNavigationWrapper
if (user.role == UserRole.user) {
  return const MainNavigationWrapper();
}

// Routes menggunakan wrapper
routes: {
  '/user-home': (context) => const MainNavigationWrapper(),
}
```

### Navigation Flow

```
AuthWrapper → MainNavigationWrapper → [HomeBody, MyOrderBody, PremiumBody, ProfileBody]
                    ↑
              UserBottomNavBar (static)
```

## Animasi Details

### 1. Page Transition Animation
- **Duration**: 350ms
- **Curve**: `Curves.easeInOutCubic`
- **Type**: Fade + Slide horizontal
- **Opacity**: 0.8 → 1.0 during transition

### 2. Navbar Icon Animation
- **Duration**: 200ms  
- **Curve**: `Curves.elasticOut`
- **Scale**: 1.0 → 1.2 untuk selected state
- **Haptic**: `HapticFeedback.lightImpact()`

### 3. Screen Content Animation
- **Duration**: 500ms
- **Curve**: `Curves.easeInOut`
- **Type**: Fade-in dari 0.0 → 1.0

## Usage Examples

### Navigasi Antar Halaman Utama
```dart
// Otomatis handled oleh MainNavigationWrapper
// User tinggal tap bottom navigation
```

### Navigasi ke Child Pages
```dart
// Untuk halaman detail/child, tetap gunakan push biasa
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => DetailScreen()),
);

// Atau gunakan NavigationHelper untuk transisi custom
NavigationHelper.pushWithSlideTransition(
  context, 
  DetailScreen(),
);
```

### Custom Transition ke Halaman Lain
```dart
// Menggunakan NavigationHelper yang sudah ada
NavigationHelper.pushWithFadeTransition(context, TargetScreen());
NavigationHelper.pushWithScaleTransition(context, TargetScreen());
NavigationHelper.pushWithSlideTransition(context, TargetScreen());
```

## Benefits

1. **Static Navigation**: Bottom navbar tidak ikut berpindah, memberikan UX yang lebih stabil
2. **Smooth Transitions**: Animasi yang consistent dan tidak jarring
3. **Performance**: Efficient PageView controller daripada Navigator push/pop
4. **Memory Management**: Screen state terjaga karena PageView caching
5. **Haptic Feedback**: Memberikan feedback tactile yang meningkatkan UX
6. **Scalable**: Mudah menambah/edit halaman baru

## Customization

### Mengubah Durasi Animasi
```dart
// Di MainNavigationWrapper
_fadeController = AnimationController(
  duration: const Duration(milliseconds: 300), // Ubah di sini
  vsync: this,
);
```

### Menambah Halaman Baru
1. Buat file body content di `lib/screens/user/content/`
2. Tambahkan ke `_screens` list di MainNavigationWrapper
3. Update UserBottomNavBar dengan item baru

### Custom Animation Type
```dart
// Bisa ganti fade dengan slide, scale, atau kombinasi
// Lihat lib/utils/page_transitions.dart untuk opsi lain
```

## Performance Notes

- PageView pre-loads adjacent pages untuk smooth scrolling
- Animation controllers di-dispose dengan proper lifecycle
- Minimal rebuild dengan efficient state management
- Haptic feedback hanya pada user interaction

## Future Enhancements

- [ ] Page indicator untuk swipe gesture (opsional)
- [ ] Dynamic badge count pada navigation items
- [ ] Deep linking support untuk direct navigation
- [ ] Animation presets configuration
- [ ] Accessibility improvements (voice over, screen reader)

---

**Implementasi ini memberikan pengalaman navigasi yang smooth, modern, dan konsisten sesuai dengan standard aplikasi mobile modern.** 🚀
