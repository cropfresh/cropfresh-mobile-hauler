import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// License Photos Screen - Story 2.5 AC4
/// Capture DL front and back photos
class LicensePhotosScreen extends StatefulWidget {
  const LicensePhotosScreen({super.key});

  @override
  State<LicensePhotosScreen> createState() => _LicensePhotosScreenState();
}

class _LicensePhotosScreenState extends State<LicensePhotosScreen> {
  bool _frontPhotoTaken = false;
  bool _backPhotoTaken = false;

  bool get _allPhotosTaken => _frontPhotoTaken && _backPhotoTaken;

  void _takePhoto(String side) async {
    // TODO: Implement actual camera capture
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      if (side == 'front') {
        _frontPhotoTaken = true;
      } else {
        _backPhotoTaken = true;
      }
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${side.toUpperCase()} captured!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _onContinue() {
    Navigator.of(context).pushNamed('/register/step4');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'License Photos',
          style: TextStyle(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Info Bar
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.surfaceContainer,
              child: Row(
                children: [
                  Icon(
                    _allPhotosTaken
                        ? Icons.check_circle_rounded
                        : Icons.camera_alt_rounded,
                    color: _allPhotosTaken
                        ? AppColors.success
                        : AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _allPhotosTaken
                          ? 'Both photos captured!'
                          : 'Capture front and back of your license',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Capture License Photos',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: AppColors.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Clear photos help speed up verification',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Front Photo
                    _buildPhotoCard(
                      title: 'License Front',
                      description: 'Photo of the front side with your details',
                      isTaken: _frontPhotoTaken,
                      onTap: () => _takePhoto('front'),
                    ),

                    const SizedBox(height: 16),

                    // Back Photo
                    _buildPhotoCard(
                      title: 'License Back',
                      description: 'Photo of the back side',
                      isTaken: _backPhotoTaken,
                      onTap: () => _takePhoto('back'),
                    ),

                    const SizedBox(height: 32),

                    // Tips
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.mapBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.lightbulb_rounded,
                                  color: AppColors.primary, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Photo Tips',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '• Ensure good lighting\n• All text should be readable\n• No glare or shadows\n• Hold camera steady',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.onSurfaceVariant,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 64,
                child: FilledButton(
                  onPressed: _allPhotosTaken ? _onContinue : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    disabledBackgroundColor: AppColors.outline,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CONTINUE TO PAYMENT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoCard({
    required String title,
    required String description,
    required bool isTaken,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isTaken
              ? AppColors.success10
              : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isTaken ? AppColors.success : AppColors.outline,
            width: isTaken ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 50,
              decoration: BoxDecoration(
                color: isTaken
                    ? AppColors.success20
                    : AppColors.primary10,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isTaken ? Icons.check_rounded : Icons.badge_rounded,
                size: 28,
                color: isTaken ? AppColors.success : AppColors.primary,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              isTaken ? Icons.check_circle_rounded : Icons.camera_alt_rounded,
              color: isTaken ? AppColors.success : AppColors.primary,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
