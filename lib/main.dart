import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/constants/app_theme.dart';

// Screen imports
import 'src/screens/onboarding/splash_screen.dart';
import 'src/screens/onboarding/language_selection_screen.dart';
import 'src/screens/onboarding/welcome_screen.dart';
import 'src/screens/onboarding/permissions_screen.dart';
import 'src/screens/registration/step1_personal_info_screen.dart';
import 'src/screens/registration/otp_verification_screen.dart';
import 'src/screens/registration/step2_vehicle_info_screen.dart';
import 'src/screens/registration/vehicle_photos_screen.dart';
import 'src/screens/registration/step3_license_screen.dart';
import 'src/screens/registration/license_photos_screen.dart';
import 'src/screens/registration/step4_payment_screen.dart';
import 'src/screens/registration/review_screen.dart';
import 'src/screens/registration/registration_complete_screen.dart';
import 'src/screens/home/pending_verification_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Lock orientation to portrait for safety while driving
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const CropFreshHaulerApp());
}

/// CropFresh Haulers App
/// Material 3 Automotive Adaptation with Safety Orange theme
/// Designed for truck drivers - high contrast, large touch targets
class CropFreshHaulerApp extends StatelessWidget {
  const CropFreshHaulerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CropFresh Haulers',
      debugShowCheckedModeBanner: false,
      
      // Material 3 Theme - Safety First (High Contrast)
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Auto-switch for day/night driving
      
      // Routes for registration flow
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/language-selection': (context) => const LanguageSelectionScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/permissions': (context) => const PermissionsScreen(),
        '/register/step1': (context) => const Step1PersonalInfoScreen(),
        '/register/otp': (context) => const OtpVerificationScreen(),
        '/register/step2': (context) => const Step2VehicleInfoScreen(),
        '/register/vehicle-photos': (context) => const VehiclePhotosScreen(),
        '/register/step3': (context) => const Step3LicenseScreen(),
        '/register/license-photos': (context) => const LicensePhotosScreen(),
        '/register/step4': (context) => const Step4PaymentScreen(),
        '/register/review': (context) => const ReviewScreen(),
        '/register/complete': (context) => const RegistrationCompleteScreen(),
        '/home': (context) => const PendingVerificationHome(),
      },
    );
  }
}
