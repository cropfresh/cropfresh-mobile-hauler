import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/registration_progress_widget.dart';

/// Step 4: Payment Setup - Story 2.5 AC5
/// UPI ID input with verification
/// Optional bank account with IFSC lookup
class Step4PaymentScreen extends StatefulWidget {
  const Step4PaymentScreen({super.key});

  @override
  State<Step4PaymentScreen> createState() => _Step4PaymentScreenState();
}

class _Step4PaymentScreenState extends State<Step4PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _upiController = TextEditingController();
  final _bankAccountController = TextEditingController();
  final _ifscController = TextEditingController();

  bool _isVerifyingUpi = false;
  bool _upiVerified = false;
  String? _bankName;
  bool _isLoading = false;

  @override
  void dispose() {
    _upiController.dispose();
    _bankAccountController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  String? _validateUpi(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter UPI ID';
    }
    // UPI format: user@bank
    final pattern = RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9]+$');
    if (!pattern.hasMatch(value)) {
      return 'Format: username@bank (e.g., name@upi)';
    }
    return null;
  }

  void _verifyUpi() async {
    if (_validateUpi(_upiController.text) != null) {
      _formKey.currentState!.validate();
      return;
    }

    setState(() {
      _isVerifyingUpi = true;
      _upiVerified = false;
    });

    // Simulate Razorpay UPI verification
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    // For demo: always succeed
    setState(() {
      _isVerifyingUpi = false;
      _upiVerified = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 12),
            Text('UPI ID verified successfully!'),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _lookupIfsc() async {
    final ifsc = _ifscController.text.trim().toUpperCase();
    if (ifsc.length != 11) return;

    // Simulate IFSC lookup
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    // Mock bank name
    setState(() => _bankName = 'State Bank of India - Main Branch');
  }

  void _onContinue() async {
    if (!_upiVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please verify your UPI ID first'),
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

    Navigator.of(context).pushNamed('/register/review');
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
            const RegistrationProgressWidget(currentStep: 4),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment\nSetup',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: AppColors.onSurface,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'How do you want to receive payments?',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // UPI Section
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _upiVerified
                                ? AppColors.success
                                : AppColors.outline,
                            width: _upiVerified ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.payments_rounded,
                                    color: AppColors.primary),
                                const SizedBox(width: 12),
                                Text(
                                  'UPI Payment',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.error10,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Required',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.error,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _upiController,
                                    enabled: !_upiVerified,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(fontSize: 16),
                                    decoration: InputDecoration(
                                      hintText: 'yourname@upi',
                                      filled: true,
                                      fillColor: AppColors.background,
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 14),
                                    ),
                                    validator: _validateUpi,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                SizedBox(
                                  height: 52,
                                  child: FilledButton(
                                    onPressed: _upiVerified || _isVerifyingUpi
                                        ? null
                                        : _verifyUpi,
                                    style: FilledButton.styleFrom(
                                      backgroundColor: _upiVerified
                                          ? AppColors.success
                                          : AppColors.primary,
                                      foregroundColor: _upiVerified
                                          ? Colors.white
                                          : AppColors.onPrimary,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                    ),
                                    child: _isVerifyingUpi
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.black,
                                            ),
                                          )
                                        : _upiVerified
                                            ? const Icon(Icons.check_rounded)
                                            : const Text('VERIFY'),
                                  ),
                                ),
                              ],
                            ),

                            if (_upiVerified) ...[
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(Icons.check_circle_rounded,
                                      color: AppColors.success, size: 18),
                                  const SizedBox(width: 8),
                                  Text(
                                    'UPI ID verified',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Bank Account Section (Optional)
                      Container(
                        padding: const EdgeInsets.all(20),
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
                                Icon(Icons.account_balance_rounded,
                                    color: AppColors.onSurfaceVariant),
                                const SizedBox(width: 12),
                                Text(
                                  'Bank Account',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Optional',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Text(
                              'Backup for UPI failures',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),

                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _bankAccountController,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: 'Account Number',
                                filled: true,
                                fillColor: AppColors.background,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                              ),
                            ),

                            const SizedBox(height: 12),

                            TextFormField(
                              controller: _ifscController,
                              textCapitalization: TextCapitalization.characters,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: 'IFSC Code',
                                filled: true,
                                fillColor: AppColors.background,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                              ),
                              onChanged: (_) => _lookupIfsc(),
                            ),

                            if (_bankName != null) ...[
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.success10,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle_outline_rounded,
                                        color: AppColors.success, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _bankName!,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.success,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                              'REVIEW & SUBMIT',
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
}
