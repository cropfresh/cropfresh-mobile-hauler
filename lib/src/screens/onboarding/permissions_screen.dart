import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Permissions Screen - Story 2.5
/// Requests Location, Notifications, Camera permissions
/// Educational explanation for each permission
class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _locationGranted = false;
  bool _notificationGranted = false;
  bool _cameraGranted = false;

  bool get _allGranted =>
      _locationGranted && _notificationGranted && _cameraGranted;

  void _requestLocation() async {
    // TODO: Implement actual permission request
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _locationGranted = true);
  }

  void _requestNotification() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _notificationGranted = true);
  }

  void _requestCamera() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _cameraGranted = true);
  }

  void _onContinue() {
    Navigator.of(context).pushReplacementNamed('/register/step1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              // Header
              Text(
                'App Permissions',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: AppColors.onSurface,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'We need a few permissions to help you deliver efficiently',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.onSurfaceVariant,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 40),

              // Permission Cards
              Expanded(
                child: ListView(
                  children: [
                    _buildPermissionCard(
                      icon: Icons.location_on_rounded,
                      title: 'Location',
                      description:
                          'Navigate to pickup and delivery locations. Required for route optimization.',
                      isGranted: _locationGranted,
                      onRequest: _requestLocation,
                      isRequired: true,
                    ),
                    const SizedBox(height: 16),
                    _buildPermissionCard(
                      icon: Icons.notifications_active_rounded,
                      title: 'Notifications',
                      description:
                          'Get alerts for new jobs, delivery updates, and payment confirmations.',
                      isGranted: _notificationGranted,
                      onRequest: _requestNotification,
                      isRequired: true,
                    ),
                    const SizedBox(height: 16),
                    _buildPermissionCard(
                      icon: Icons.camera_alt_rounded,
                      title: 'Camera',
                      description:
                          'Take photos of your vehicle, license, and proof of delivery.',
                      isGranted: _cameraGranted,
                      onRequest: _requestCamera,
                      isRequired: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 64,
                child: FilledButton(
                  onPressed: _allGranted ? _onContinue : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    disabledBackgroundColor: AppColors.outline,
                    disabledForegroundColor: AppColors.onSurfaceVariant,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CONTINUE TO REGISTRATION',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
              ),

              if (!_allGranted) ...[
                const SizedBox(height: 12),
                Text(
                  'Please grant all permissions to continue',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isGranted,
    required VoidCallback onRequest,
    required bool isRequired,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isGranted
            ? AppColors.success10
            : AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isGranted ? AppColors.success : AppColors.outline,
          width: isGranted ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isGranted
                  ? AppColors.success20
                  : AppColors.primary15,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isGranted ? Icons.check_rounded : icon,
              color: isGranted ? AppColors.success : AppColors.primary,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    if (isRequired) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary15,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Required',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Action Button
          if (!isGranted)
            SizedBox(
              height: 44,
              child: FilledButton(
                onPressed: onRequest,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'ALLOW',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          else
            Icon(
              Icons.check_circle_rounded,
              color: AppColors.success,
              size: 32,
            ),
        ],
      ),
    );
  }
}
