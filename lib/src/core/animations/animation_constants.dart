/// Animation Constants for CropFresh Haulers App
/// Smooth, premium animations following Material 3 motion guidelines
class AnimationConstants {
  AnimationConstants._();

  // ============================================
  // DURATIONS
  // ============================================
  
  /// Splash screen logo animation
  static const Duration durationSplash = Duration(milliseconds: 1500);
  
  /// Page transition duration
  static const Duration durationPage = Duration(milliseconds: 400);
  
  /// Quick micro-interactions
  static const Duration durationQuick = Duration(milliseconds: 200);
  
  /// Medium animations (button presses, reveals)
  static const Duration durationMedium = Duration(milliseconds: 300);
  
  /// Slow animations (complex transitions)
  static const Duration durationSlow = Duration(milliseconds: 500);
  
  /// Very slow (celebration animations)
  static const Duration durationCelebration = Duration(milliseconds: 1000);

  // ============================================
  // SCALE VALUES
  // ============================================
  
  /// Logo starting scale for spring animation
  static const double scaleLogoStart = 0.3;
  
  /// Button press scale
  static const double scaleButtonPress = 0.95;
  
  /// Card hover scale
  static const double scaleCardHover = 1.02;

  // ============================================
  // OFFSET VALUES
  // ============================================
  
  /// Slide up offset for staggered animations
  static const double slideUpOffset = 30.0;
  
  /// Slide in offset for page transitions
  static const double slideInOffset = 50.0;

  // ============================================
  // DELAYS
  // ============================================
  
  /// Stagger delay between list items
  static const Duration staggerDelay = Duration(milliseconds: 100);
  
  /// Delay before content appears after splash
  static const Duration contentDelay = Duration(milliseconds: 600);
}
