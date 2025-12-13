import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Vehicle Photos Screen - Story 2.5 AC3
/// Capture front and side view photos
/// Optional additional photos (max 4 total)
class VehiclePhotosScreen extends StatefulWidget {
  const VehiclePhotosScreen({super.key});

  @override
  State<VehiclePhotosScreen> createState() => _VehiclePhotosScreenState();
}

class _VehiclePhotosScreenState extends State<VehiclePhotosScreen> {
  // Mock photo states (in real app would hold actual image data)
  bool _frontPhotoTaken = false;
  bool _sidePhotoTaken = false;
  final List<bool> _additionalPhotos = [false, false];

  bool get _requiredPhotosTaken => _frontPhotoTaken && _sidePhotoTaken;

  void _takePhoto(String type, int? index) async {
    // TODO: Implement actual camera capture with image_picker
    // Simulating photo capture
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      switch (type) {
        case 'front':
          _frontPhotoTaken = true;
          break;
        case 'side':
          _sidePhotoTaken = true;
          break;
        case 'additional':
          if (index != null && index < _additionalPhotos.length) {
            _additionalPhotos[index] = true;
          }
          break;
      }
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Photo captured successfully!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _onContinue() {
    Navigator.of(context).pushNamed('/register/step3');
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
          'Vehicle Photos',
          style: TextStyle(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Photo progress indicator
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.surfaceContainer,
              child: Row(
                children: [
                  Icon(
                    _requiredPhotosTaken
                        ? Icons.check_circle_rounded
                        : Icons.info_outline_rounded,
                    color: _requiredPhotosTaken
                        ? AppColors.success
                        : AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _requiredPhotosTaken
                          ? 'Required photos captured!'
                          : 'Front and Side views are required',
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Capture Vehicle Photos',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: AppColors.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'We need clear photos of your vehicle for verification',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Required Photos Section
                    Text(
                      'REQUIRED PHOTOS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurfaceVariant,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Front View Photo
                    _buildPhotoCard(
                      title: 'Front View',
                      description: 'Show number plate clearly',
                      icon: Icons.directions_car_rounded,
                      isTaken: _frontPhotoTaken,
                      isRequired: true,
                      onTap: () => _takePhoto('front', null),
                    ),

                    const SizedBox(height: 16),

                    // Side View Photo
                    _buildPhotoCard(
                      title: 'Side View',
                      description: 'Show full vehicle from side',
                      icon: Icons.local_shipping_rounded,
                      isTaken: _sidePhotoTaken,
                      isRequired: true,
                      onTap: () => _takePhoto('side', null),
                    ),

                    const SizedBox(height: 32),

                    // Optional Photos Section
                    Text(
                      'ADDITIONAL PHOTOS (Optional)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurfaceVariant,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _buildMiniPhotoCard(
                            title: 'Rear View',
                            isTaken: _additionalPhotos[0],
                            onTap: () => _takePhoto('additional', 0),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildMiniPhotoCard(
                            title: 'Interior',
                            isTaken: _additionalPhotos[1],
                            onTap: () => _takePhoto('additional', 1),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // Continue Button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 64,
                child: FilledButton(
                  onPressed: _requiredPhotosTaken ? _onContinue : null,
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
                        'CONTINUE TO LICENSE',
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
    required IconData icon,
    required bool isTaken,
    required bool isRequired,
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
            // Preview/Placeholder
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: isTaken
                    ? AppColors.success20
                    : AppColors.primary10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isTaken ? Icons.check_rounded : icon,
                size: 40,
                color: isTaken ? AppColors.success : AppColors.primary,
              ),
            ),

            const SizedBox(width: 16),

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
                            color: AppColors.error10,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Required',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.error,
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
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isTaken ? '✓ Photo captured' : 'Tap to capture',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isTaken ? AppColors.success : AppColors.primary,
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

  Widget _buildMiniPhotoCard({
    required String title,
    required bool isTaken,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 100,
        decoration: BoxDecoration(
          color: isTaken
              ? AppColors.success10
              : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isTaken ? AppColors.success : AppColors.outline,
            style: isTaken ? BorderStyle.solid : BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isTaken ? Icons.check_circle_rounded : Icons.add_a_photo_rounded,
              size: 32,
              color: isTaken ? AppColors.success : AppColors.onSurfaceVariant,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isTaken ? AppColors.success : AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
