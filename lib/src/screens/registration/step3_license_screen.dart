import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/registration_progress_widget.dart';

/// Step 3: License Verification - Story 2.5 AC4
/// DL Number input, Expiry date picker
/// Navigates to license photos screen
class Step3LicenseScreen extends StatefulWidget {
  const Step3LicenseScreen({super.key});

  @override
  State<Step3LicenseScreen> createState() => _Step3LicenseScreenState();
}

class _Step3LicenseScreenState extends State<Step3LicenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dlNumberController = TextEditingController();
  DateTime? _expiryDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _dlNumberController.dispose();
    super.dispose();
  }

  String? _validateDlNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter driving license number';
    }
    // Indian DL format: State code + year + number (varies by state)
    // Example: KA01-2020-1234567, DL-0420110012345
    if (value.length < 10) {
      return 'Enter valid DL number';
    }
    return null;
  }

  Future<void> _selectExpiryDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 365)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 20)),
      helpText: 'Select License Expiry Date',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.onPrimary,
              surface: AppColors.surface,
              onSurface: AppColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _expiryDate = picked);
    }
  }

  bool get _isExpiryValid {
    if (_expiryDate == null) return false;
    return _expiryDate!.isAfter(DateTime.now());
  }

  String get _formattedExpiry {
    if (_expiryDate == null) return '';
    return '${_expiryDate!.day.toString().padLeft(2, '0')}/${_expiryDate!.month.toString().padLeft(2, '0')}/${_expiryDate!.year}';
  }

  void _onContinue() async {
    if (!_formKey.currentState!.validate()) return;

    if (_expiryDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select license expiry date'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_isExpiryValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('License has expired. Please renew before registration.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.of(context).pushNamed('/register/license-photos');
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
            const RegistrationProgressWidget(currentStep: 3),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'License\nVerification',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: AppColors.onSurface,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'We need your driving license details',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // DL Number
                      _buildLabel('Driving License Number', isRequired: true),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _dlNumberController,
                        textCapitalization: TextCapitalization.characters,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                        decoration: InputDecoration(
                          hintText: 'KA01-2020-1234567',
                          prefixIcon: Icon(Icons.badge_rounded,
                              color: AppColors.onSurfaceVariant),
                        ),
                        validator: _validateDlNumber,
                      ),

                      const SizedBox(height: 24),

                      // Expiry Date
                      _buildLabel('License Expiry Date', isRequired: true),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _selectExpiryDate,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainer,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _expiryDate != null && !_isExpiryValid
                                  ? AppColors.error
                                  : AppColors.outline,
                              width: _expiryDate != null && !_isExpiryValid ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today_rounded,
                                  color: AppColors.onSurfaceVariant),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  _expiryDate != null
                                      ? _formattedExpiry
                                      : 'Select expiry date',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: _expiryDate != null
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: _expiryDate != null
                                        ? AppColors.onSurface
                                        : AppColors.onSurfaceVariant60,
                                  ),
                                ),
                              ),
                              Icon(
                                _isExpiryValid
                                    ? Icons.check_circle_rounded
                                    : Icons.arrow_drop_down_rounded,
                                color: _isExpiryValid
                                    ? AppColors.success
                                    : AppColors.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (_expiryDate != null && !_isExpiryValid) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.error_outline_rounded,
                                color: AppColors.error, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              'License has expired. Please renew.',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.error,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 32),

                      // Info Box
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary10,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppColors.primary30),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.security_rounded,
                                color: AppColors.primary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Your license details are securely stored and used only for verification purposes.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 64,
                child: FilledButton(
                  onPressed: _isLoading ? null : _onContinue,
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
                              'ADD LICENSE PHOTOS',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.camera_alt_rounded, size: 24),
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
          Text('*', style: TextStyle(color: AppColors.error)),
        ],
      ],
    );
  }
}
