import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

/// Welcome Screen - Story 2.5
/// Hero illustration with value propositions
/// "Register Now" CTA and login link
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onRegister() {
    Navigator.of(context).pushReplacementNamed('/permissions');
  }

  void _onLogin() {
    // TODO: Navigate to login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SlideTransition(
          position: _slideUp,
          child: FadeTransition(
            opacity: _fadeIn,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Hero Illustration
                  _buildHeroIllustration(),

                  const SizedBox(height: 40),

                  // Value Propositions
                  _buildValueProps(),

                  const Spacer(),

                  // Action Buttons
                  _buildButtons(),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroIllustration() {
    return Column(
      children: [
        // Delivery truck visual
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.mapBackground,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.primary30),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Road line
              Positioned(
                bottom: 60,
                child: Container(
                  width: 200,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.onSurfaceVariant30,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Truck icon
              Icon(
                Icons.local_shipping_rounded,
                size: 100,
                color: AppColors.primary,
              ),
              // Farm icon (left)
              Positioned(
                left: 30,
                top: 50,
                child: Icon(
                  Icons.agriculture_rounded,
                  size: 40,
                  color: AppColors.success,
                ),
              ),
              // Market icon (right)
              Positioned(
                right: 30,
                top: 50,
                child: Icon(
                  Icons.store_rounded,
                  size: 40,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Title
        Text(
          'Deliver Fresh Produce',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppColors.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Connect farmers to buyers',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildValueProps() {
    final props = [
      {
        'icon': Icons.attach_money_rounded,
        'title': 'Earn More',
        'desc': 'Competitive pay per trip'
      },
      {
        'icon': Icons.schedule_rounded,
        'title': 'Flexible Hours',
        'desc': 'Work on your schedule'
      },
      {
        'icon': Icons.payments_rounded,
        'title': 'Instant Pay',
        'desc': 'Get paid via UPI immediately'
      },
    ];

    return Column(
      children: props.asMap().entries.map((entry) {
        final index = entry.key;
        final prop = entry.value;

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 400 + (index * 150)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(30 * (1 - value), 0),
                child: child,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary15,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    prop['icon'] as IconData,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prop['title'] as String,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurface,
                        ),
                      ),
                      Text(
                        prop['desc'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        // Register Now (64dp)
        SizedBox(
          width: double.infinity,
          height: 64,
          child: FilledButton(
            onPressed: _onRegister,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_shipping_rounded, size: 24),
                SizedBox(width: 12),
                Text(
                  'REGISTER NOW',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Login link
        TextButton(
          onPressed: _onLogin,
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16, color: AppColors.onSurfaceVariant),
              children: [
                const TextSpan(text: 'Already a driver? '),
                TextSpan(
                  text: 'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
