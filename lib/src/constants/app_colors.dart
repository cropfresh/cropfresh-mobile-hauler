import 'package:flutter/material.dart';

/// CropFresh Haulers App Color System
/// Based on UX Design: "Safety First" Theme
/// Material 3 Automotive Adaptation for truck drivers
/// 
/// Design Principles:
/// - High contrast for outdoor/sunlight visibility
/// - Large readable text
/// - Safety Orange for maximum visibility
class AppColors {
  AppColors._();

  // ============================================
  // THEME 1: SAFETY FIRST (Light Theme - Default)
  // High Contrast Safety Orange for daytime driving
  // ============================================
  
  /// Primary - Safety Orange
  /// High visibility in bright sunlight
  static const Color primary = Color(0xFFFF6D00);
  
  /// On Primary - Black for maximum contrast
  static const Color onPrimary = Color(0xFF000000);
  
  /// Primary Container - Lighter orange
  static const Color primaryContainer = Color(0xFFFFE0B2);
  
  /// On Primary Container
  static const Color onPrimaryContainer = Color(0xFF331200);
  
  /// Secondary - Pure Black
  static const Color secondary = Color(0xFF000000);
  
  /// On Secondary
  static const Color onSecondary = Color(0xFFFFFFFF);
  
  /// Background - Pure White
  static const Color background = Color(0xFFFFFFFF);
  
  /// On Background
  static const Color onBackground = Color(0xFF000000);
  
  /// Surface - Light Gray
  static const Color surface = Color(0xFFF5F5F5);
  
  /// On Surface
  static const Color onSurface = Color(0xFF000000);
  
  /// On Surface Variant - Subdued text
  static const Color onSurfaceVariant = Color(0xFF424242);
  
  /// Surface Container - Cards and elevated surfaces
  static const Color surfaceContainer = Color(0xFFFFFFFF);
  
  /// Surface Container High
  static const Color surfaceContainerHigh = Color(0xFFFAFAFA);
  
  /// Outline
  static const Color outline = Color(0xFFE0E0E0);
  
  /// Outline Variant
  static const Color outlineVariant = Color(0xFFBDBDBD);
  
  /// Error - Red for warnings
  static const Color error = Color(0xFFD32F2F);
  
  /// On Error
  static const Color onError = Color(0xFFFFFFFF);
  
  /// Success - Green for confirmations
  static const Color success = Color(0xFF388E3C);
  
  /// On Success
  static const Color onSuccess = Color(0xFFFFFFFF);

  // ============================================
  // THEME 2: NIGHT RIDER (Dark Theme)
  // OLED Dark with Signal Green for night driving
  // ============================================
  
  /// Dark Primary - Signal Green
  static const Color darkPrimary = Color(0xFF00E676);
  
  /// Dark On Primary
  static const Color darkOnPrimary = Color(0xFF000000);
  
  /// Dark Primary Container
  static const Color darkPrimaryContainer = Color(0xFF003D1A);
  
  /// Dark On Primary Container
  static const Color darkOnPrimaryContainer = Color(0xFF69F0AE);
  
  /// Dark Secondary
  static const Color darkSecondary = Color(0xFF212121);
  
  /// Dark On Secondary
  static const Color darkOnSecondary = Color(0xFFFFFFFF);
  
  /// Dark Background - True Black for OLED
  static const Color darkBackground = Color(0xFF121212);
  
  /// Dark On Background
  static const Color darkOnBackground = Color(0xFFFFFFFF);
  
  /// Dark Surface
  static const Color darkSurface = Color(0xFF1E1E1E);
  
  /// Dark On Surface
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  
  /// Dark On Surface Variant
  static const Color darkOnSurfaceVariant = Color(0xFFB0B0B0);
  
  /// Dark Surface Container
  static const Color darkSurfaceContainer = Color(0xFF2C2C2C);
  
  /// Dark Outline
  static const Color darkOutline = Color(0xFF444444);
  
  /// Dark Error
  static const Color darkError = Color(0xFFCF6679);
  
  /// Dark Success
  static const Color darkSuccess = Color(0xFF00E676);

  // ============================================
  // GRADIENTS
  // ============================================
  
  /// Hero gradient for branding
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF6D00), // Safety Orange
      Color(0xFFFF8F00), // Lighter Orange
    ],
  );
  
  /// Dark hero gradient
  static const LinearGradient darkHeroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF00E676), // Signal Green
      Color(0xFF69F0AE), // Lighter Green
    ],
  );

  // ============================================
  // SEMANTIC COLORS
  // ============================================
  
  /// Status - Pending Verification
  static const Color statusPending = Color(0xFFFFA000);
  
  /// Status - Active/Approved
  static const Color statusActive = Color(0xFF388E3C);
  
  /// Status - Rejected
  static const Color statusRejected = Color(0xFFD32F2F);
  
  /// Map placeholder background
  static const Color mapBackground = Color(0xFFFFF3E0);
  
  /// Map border
  static const Color mapBorder = Color(0xFFFF6D00);

  // ============================================
  // PRE-COMPUTED OPACITY COLORS
  // These avoid deprecated withOpacity() calls
  // ============================================
  
  /// Primary 10% opacity (for backgrounds)
  static const Color primary10 = Color(0x1AFF6D00);
  
  /// Primary 15% opacity (for light backgrounds)
  static const Color primary15 = Color(0x26FF6D00);
  
  /// Primary 30% opacity (for borders, shadows)
  static const Color primary30 = Color(0x4DFF6D00);
  
  /// Primary 40% opacity (for stronger shadows)
  static const Color primary40 = Color(0x66FF6D00);
  
  /// Success 10% opacity
  static const Color success10 = Color(0x1A388E3C);
  
  /// Success 20% opacity
  static const Color success20 = Color(0x33388E3C);
  
  /// Error 10% opacity
  static const Color error10 = Color(0x1AD32F2F);
  
  /// On Primary 80% opacity
  static const Color onPrimary80 = Color(0xCC000000);
  
  /// On Surface Variant 30% opacity
  static const Color onSurfaceVariant30 = Color(0x4D424242);
  
  /// On Surface Variant 60% opacity
  static const Color onSurfaceVariant60 = Color(0x99424242);
  
  /// Status Pending 15% opacity
  static const Color statusPending15 = Color(0x26FFA000);
  
  /// Status Pending 30% opacity
  static const Color statusPending30 = Color(0x4DFFA000);
  
  /// Status Pending 80% opacity
  static const Color statusPending80 = Color(0xCCFFA000);
  
  /// White 20% opacity
  static const Color white20 = Color(0x33FFFFFF);
  
  /// Black 10% opacity
  static const Color black10 = Color(0x1A000000);
}
