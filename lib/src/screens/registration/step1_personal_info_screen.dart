import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/registration_progress_widget.dart';

/// Step 1: Personal Information - Story 2.5 AC2
/// Full Name, Mobile Number, Alternate Contact
/// Triggers OTP on valid mobile submission
class Step1PersonalInfoScreen extends StatefulWidget {
  const Step1PersonalInfoScreen({super.key});

  @override
  State<Step1PersonalInfoScreen> createState() => _Step1PersonalInfoScreenState();
}

class _Step1PersonalInfoScreenState extends State<Step1PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _alternateController = TextEditingController();
  
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _alternateController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your mobile number';
    }
    // Indian mobile format: 10 digits
    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length != 10) {
      return 'Enter valid 10-digit mobile number';
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(cleaned)) {
      return 'Enter valid Indian mobile number';
    }
    return null;
  }

  void _onSendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate OTP send delay
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;
    
    setState(() => _isLoading = false);

    // Navigate to OTP screen with data
    Navigator.of(context).pushNamed(
      '/register/otp',
      arguments: {
        'fullName': _nameController.text.trim(),
        'mobile': _mobileController.text.trim(),
        'alternateMobile': _alternateController.text.trim(),
      },
    );
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
          'Register',
          style: TextStyle(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            const RegistrationProgressWidget(currentStep: 1),

            // Form Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Text(
                        'Personal\nInformation',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: AppColors.onSurface,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Tell us about yourself',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Full Name Field
                      _buildLabel('Full Name', isRequired: true),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: 'Enter your full name',
                          prefixIcon: Icon(Icons.person_rounded,
                              color: AppColors.onSurfaceVariant),
                        ),
                        validator: _validateName,
                      ),

                      const SizedBox(height: 24),

                      // Mobile Number Field
                      _buildLabel('Mobile Number', isRequired: true),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        maxLength: 10,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: '9876543210',
                          counterText: '',
                          prefixIcon: Icon(Icons.phone_rounded,
                              color: AppColors.onSurfaceVariant),
                          prefixText: '+91 ',
                          prefixStyle: TextStyle(
                            fontSize: 18,
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        validator: _validateMobile,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'We\'ll send an OTP to verify this number',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Alternate Contact (Optional)
                      _buildLabel('Alternate Contact', isRequired: false),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _alternateController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        maxLength: 10,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: 'Emergency contact (optional)',
                          counterText: '',
                          prefixIcon: Icon(Icons.phone_callback_rounded,
                              color: AppColors.onSurfaceVariant),
                          prefixText: '+91 ',
                          prefixStyle: TextStyle(
                            fontSize: 18,
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 64,
                child: FilledButton(
                  onPressed: _isLoading ? null : _onSendOtp,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 3,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SEND OTP',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.sms_rounded, size: 24),
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

  Widget _buildLabel(String text, {required bool isRequired}) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
          ),
        ),
        if (isRequired) ...[
          const SizedBox(width: 4),
          Text(
            '*',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }
}
