import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Review Screen - Story 2.5 AC6
/// Summary of all registration data
/// Submit button to finalize registration
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool _isSubmitting = false;
  bool _termsAccepted = false;

  void _onSubmit() async {
    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please accept the terms and conditions'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    // Simulate API submission
    await Future.delayed(const Duration(milliseconds: 2000));

    if (!mounted) return;

    Navigator.of(context).pushReplacementNamed('/register/complete');
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
          'Review',
          style: TextStyle(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Review Your\nRegistration',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: AppColors.onSurface,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Please verify all information before submitting',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Personal Info Section
                    _buildSection(
                      title: 'Personal Information',
                      icon: Icons.person_rounded,
                      editRoute: '/register/step1',
                      items: [
                        _buildItem('Full Name', 'Rajesh Kumar'),
                        _buildItem('Mobile', '+91 98765 43210'),
                        _buildItem('Alternate', '+91 98765 43211'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Vehicle Info Section
                    _buildSection(
                      title: 'Vehicle Information',
                      icon: Icons.local_shipping_rounded,
                      editRoute: '/register/step2',
                      items: [
                        _buildItem('Vehicle Type', 'Pickup Van'),
                        _buildItem('Vehicle Number', 'KA-01-AB-1234'),
                        _buildItem('Capacity', '450 kg'),
                        _buildPhotoRow('Photos', 2),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // License Info Section
                    _buildSection(
                      title: 'License Details',
                      icon: Icons.badge_rounded,
                      editRoute: '/register/step3',
                      items: [
                        _buildItem('DL Number', 'KA01-2020-1234567'),
                        _buildItem('Expiry', '15/05/2028'),
                        _buildPhotoRow('DL Photos', 2),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Payment Info Section
                    _buildSection(
                      title: 'Payment Setup',
                      icon: Icons.payments_rounded,
                      editRoute: '/register/step4',
                      items: [
                        _buildItem('UPI ID', 'rajesh@upi', verified: true),
                        _buildItem('Bank Account', 'Not provided'),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Terms Checkbox
                    GestureDetector(
                      onTap: () => setState(() => _termsAccepted = !_termsAccepted),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _termsAccepted
                                ? AppColors.primary
                                : AppColors.outline,
                          ),
                        ),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: _termsAccepted
                                    ? AppColors.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: _termsAccepted
                                      ? AppColors.primary
                                      : AppColors.outline,
                                  width: 2,
                                ),
                              ),
                              child: _termsAccepted
                                  ? Icon(Icons.check_rounded,
                                      size: 16, color: AppColors.onPrimary)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'I agree to the ',
                                      style: TextStyle(
                                        color: AppColors.onSurface,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Terms of Service',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' and ',
                                      style: TextStyle(
                                        color: AppColors.onSurface,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
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
                  onPressed: _isSubmitting ? null : _onSubmit,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSubmitting
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 3,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'SUBMITTING...',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_rounded, size: 24),
                            SizedBox(width: 8),
                            Text(
                              'SUBMIT REGISTRATION',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
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

  Widget _buildSection({
    required String title,
    required IconData icon,
    required String editRoute,
    required List<Widget> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed(editRoute),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(40, 30),
                ),
                child: Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items,
        ],
      ),
    );
  }

  Widget _buildItem(String label, String value, {bool verified = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
                if (verified) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.verified_rounded,
                      color: AppColors.success, size: 16),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoRow(String label, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
          Row(
            children: List.generate(count, (index) {
              return Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: AppColors.success10,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 20,
                  color: AppColors.success,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
