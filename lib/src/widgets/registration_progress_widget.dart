import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Registration Progress Widget - Story 2.5 AC1
/// 4-step progress indicator with labels
/// Shows: Personal → Vehicle → License → Payment
class RegistrationProgressWidget extends StatelessWidget {
  final int currentStep;

  const RegistrationProgressWidget({
    super.key,
    required this.currentStep,
  });

  static const List<String> _stepLabels = [
    'Personal',
    'Vehicle',
    'License',
    'Payment',
  ];

  static const List<IconData> _stepIcons = [
    Icons.person_rounded,
    Icons.local_shipping_rounded,
    Icons.badge_rounded,
    Icons.payment_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        border: Border(
          bottom: BorderSide(color: AppColors.outline, width: 1),
        ),
      ),
      child: Column(
        children: [
          // Progress Bar
          Row(
            children: List.generate(4, (index) {
              final stepNum = index + 1;
              final isCompleted = stepNum < currentStep;
              final isCurrent = stepNum == currentStep;

              return Expanded(
                child: Row(
                  children: [
                    // Step Circle
                    _buildStepCircle(
                      stepNum: stepNum,
                      isCompleted: isCompleted,
                      isCurrent: isCurrent,
                    ),
                    // Connector Line (not after last step)
                    if (index < 3)
                      Expanded(
                        child: Container(
                          height: 3,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? AppColors.primary
                                : AppColors.outline,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),

          const SizedBox(height: 12),

          // Step Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              final stepNum = index + 1;
              final isCurrent = stepNum == currentStep;
              final isCompleted = stepNum < currentStep;

              return Expanded(
                child: Text(
                  _stepLabels[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                    color: isCurrent
                        ? AppColors.primary
                        : isCompleted
                            ? AppColors.success
                            : AppColors.onSurfaceVariant,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle({
    required int stepNum,
    required bool isCompleted,
    required bool isCurrent,
  }) {
    final Color backgroundColor;
    final Color foregroundColor;
    final Widget child;

    if (isCompleted) {
      backgroundColor = AppColors.success;
      foregroundColor = Colors.white;
      child = const Icon(Icons.check_rounded, size: 18);
    } else if (isCurrent) {
      backgroundColor = AppColors.primary;
      foregroundColor = AppColors.onPrimary;
      child = Icon(_stepIcons[stepNum - 1], size: 18);
    } else {
      backgroundColor = AppColors.outline;
      foregroundColor = AppColors.onSurfaceVariant;
      child = Text(
        stepNum.toString(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: foregroundColor,
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: const Color(0x4DFF6D00), // AppColors.primary with 30% opacity
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Center(
        child: IconTheme(
          data: IconThemeData(color: foregroundColor),
          child: child,
        ),
      ),
    );
  }
}
