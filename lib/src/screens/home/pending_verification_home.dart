import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Pending Verification Home - Story 2.5 AC7
/// Read-only view showing registration status
/// Displayed while awaiting admin verification
class PendingVerificationHome extends StatelessWidget {
  const PendingVerificationHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.local_shipping_rounded, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'CropFresh Haulers',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded, color: Colors.black),
            onPressed: () {
              // Show help dialog
              _showHelpDialog(context);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          // Simulate status refresh
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Card - Main focus
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.statusPending,
                      AppColors.statusPending80,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.statusPending30,
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.white20,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.hourglass_top_rounded,
                            color: Colors.black,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account Status',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'PENDING',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.black10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline_rounded,
                              color: Colors.black, size: 20),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Our team is verifying your documents. This typically takes 24 hours.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Registration Summary
              Text(
                'Your Registration',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.onSurface,
                ),
              ),

              const SizedBox(height: 16),

              // Vehicle Card
              _buildInfoCard(
                icon: Icons.local_shipping_rounded,
                title: 'Vehicle',
                items: [
                  'Pickup Van',
                  'KA-01-AB-1234',
                  'Capacity: 450 kg',
                ],
              ),

              const SizedBox(height: 12),

              // License Card
              _buildInfoCard(
                icon: Icons.badge_rounded,
                title: 'License',
                items: [
                  'KA01-2020-1234567',
                  'Expires: 15/05/2028',
                ],
              ),

              const SizedBox(height: 12),

              // Payment Card
              _buildInfoCard(
                icon: Icons.payments_rounded,
                title: 'Payment',
                items: [
                  'UPI: rajesh@upi ✓',
                ],
              ),

              const SizedBox(height: 32),

              // What's Next Section
              Text(
                'What Happens Next?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.onSurface,
                ),
              ),

              const SizedBox(height: 16),

              _buildTimelineStep(
                number: '1',
                title: 'Document Verification',
                description: 'Our team reviews your license and vehicle details',
                isComplete: false,
                isActive: true,
              ),
              _buildTimelineStep(
                number: '2',
                title: 'Verification Call',
                description: 'We\'ll call to confirm your details',
                isComplete: false,
                isActive: false,
              ),
              _buildTimelineStep(
                number: '3',
                title: 'Account Activation',
                description: 'Start receiving delivery requests',
                isComplete: false,
                isActive: false,
              ),

              const SizedBox(height: 32),

              // Contact Support
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Contact support
                  },
                  icon: const Icon(Icons.support_agent_rounded),
                  label: const Text(
                    'CONTACT SUPPORT',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required List<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outline),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary10,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                ...items.map((item) => Text(
                      item,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.onSurfaceVariant,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep({
    required String number,
    required String title,
    required String description,
    required bool isComplete,
    required bool isActive,
  }) {
    final color = isComplete
        ? AppColors.success
        : isActive
            ? AppColors.primary
            : AppColors.outline;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isComplete || isActive ? color : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: Center(
                  child: isComplete
                      ? const Icon(Icons.check_rounded,
                          color: Colors.white, size: 18)
                      : Text(
                          number,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isActive ? Colors.white : color,
                          ),
                        ),
                ),
              ),
              Container(
                width: 2,
                height: 30,
                color: AppColors.outline,
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isActive ? AppColors.onSurface : AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
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
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Need Help?'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact our support team:'),
            SizedBox(height: 12),
            Text('📞  1800-123-4567'),
            Text('📧  support@cropfresh.in'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }
}
