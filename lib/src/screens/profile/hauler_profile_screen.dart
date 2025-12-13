import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_colors.dart';

/// Hauler Profile Screen - Story 2.7 (AC3)
/// Profile management for haulers with vehicle info, availability, and DL upload
class HaulerProfileScreen extends StatefulWidget {
  const HaulerProfileScreen({super.key});

  @override
  State<HaulerProfileScreen> createState() => _HaulerProfileScreenState();
}

class _HaulerProfileScreenState extends State<HaulerProfileScreen> {
  bool _isEditing = false;
  bool _hasChanges = false;
  bool _isSaving = false;

  // User data
  String _userName = 'Ravi Kumar';
  String _phoneNumber = '+91 87654 32109';
  
  // Vehicle info
  String _vehicleNumber = 'KA-01-AB-1234';
  String _vehicleCapacity = '2000';
  String _dlExpiry = '2026-03-15';
  String _upiId = 'ravi.kumar@okaxis';
  
  // Availability
  TimeOfDay _startTime = const TimeOfDay(hour: 6, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 20, minute: 0);
  List<String> _selectedDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  final List<String> _weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  void _toggleEdit() {
    HapticFeedback.lightImpact();
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) _hasChanges = false;
    });
  }

  void _markChanged() {
    if (!_hasChanges) setState(() => _hasChanges = true);
  }

  Future<void> _saveChanges() async {
    HapticFeedback.mediumImpact();
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _isSaving = false;
      _isEditing = false;
      _hasChanges = false;
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Text('Profile updated successfully'),
            ],
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  Future<void> _selectTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
      _markChanged();
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: AppColors.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        actions: [
          TextButton.icon(
            onPressed: _toggleEdit,
            icon: Icon(
              _isEditing ? Icons.close_rounded : Icons.edit_rounded,
              size: 20,
            ),
            label: Text(_isEditing ? 'Cancel' : 'Edit'),
            style: TextButton.styleFrom(
              foregroundColor: _isEditing ? AppColors.error : AppColors.primary,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Profile Header Card
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.heroGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: Text(
                      _userName[0].toUpperCase(),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_userName, style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold,
                        )),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('Verified Hauler', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Contact Section
          SliverToBoxAdapter(child: _buildSection(
            'Contact Information',
            Icons.contact_phone_rounded,
            [
              _buildReadOnlyField('Mobile Number', _phoneNumber, Icons.phone_android_rounded),
            ],
          )),

          // Vehicle Section
          SliverToBoxAdapter(child: _buildSection(
            'Vehicle Information',
            Icons.local_shipping_rounded,
            [
              _buildEditableField('Vehicle Number', _vehicleNumber, Icons.confirmation_number_rounded,
                hint: 'XX-00-XX-0000', onChanged: (v) { _vehicleNumber = v; _markChanged(); }),
              _buildEditableField('Payload Capacity (kg)', _vehicleCapacity, Icons.scale_rounded,
                keyboard: TextInputType.number, onChanged: (v) { _vehicleCapacity = v; _markChanged(); }),
              _buildDateField('DL Expiry Date', _dlExpiry, Icons.card_membership_rounded),
              _buildUploadField('Driving License', 'dl_image.jpg', Icons.upload_file_rounded),
            ],
          )),

          // Payment Section
          SliverToBoxAdapter(child: _buildSection(
            'Payment Information',
            Icons.payments_rounded,
            [
              _buildEditableField('UPI ID', _upiId, Icons.currency_rupee_rounded,
                hint: 'yourname@upi', onChanged: (v) { _upiId = v; _markChanged(); }),
            ],
          )),

          // Availability Section
          SliverToBoxAdapter(child: _buildSection(
            'Availability',
            Icons.schedule_rounded,
            [
              _buildTimeRange(),
              const SizedBox(height: 16),
              _buildDaySelector(),
            ],
          )),

          // Change History Link
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/profile/history'),
                icon: Icon(Icons.history_rounded),
                label: Text('View Change History'),
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _hasChanges ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _hasChanges ? 1.0 : 0.0,
          child: FloatingActionButton.extended(
            onPressed: _isSaving ? null : _saveChanges,
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            icon: _isSaving
                ? SizedBox(width: 20, height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onPrimary))
                : Icon(Icons.check_rounded),
            label: Text(_isSaving ? 'Saving...' : 'Save Changes'),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppColors.black10, blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary15,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 20, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                )),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(label, style: TextStyle(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w500)),
            const SizedBox(width: 4),
            Icon(Icons.lock_outline, size: 14, color: AppColors.onSurfaceVariant),
          ]),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.outline),
            ),
            child: Row(children: [
              Icon(icon, size: 20, color: AppColors.onSurfaceVariant60),
              const SizedBox(width: 12),
              Text(value, style: TextStyle(color: AppColors.onSurfaceVariant)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, String value, IconData icon,
      {String? hint, TextInputType? keyboard, required ValueChanged<String> onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _isEditing ? AppColors.primary30 : AppColors.outline),
            ),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Icon(icon, size: 20, color: AppColors.onSurfaceVariant),
              ),
              Expanded(
                child: TextField(
                  enabled: _isEditing,
                  controller: TextEditingController(text: value),
                  keyboardType: keyboard,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  onChanged: onChanged,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _isEditing ? () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.parse(_dlExpiry),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 3650)),
              );
              if (picked != null) {
                setState(() => _dlExpiry = picked.toIso8601String().split('T')[0]);
                _markChanged();
              }
            } : null,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.outline),
              ),
              child: Row(children: [
                Icon(icon, size: 20, color: AppColors.onSurfaceVariant),
                const SizedBox(width: 12),
                Expanded(child: Text(value)),
                if (_isEditing) Icon(Icons.calendar_today, size: 18, color: AppColors.primary),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadField(String label, String fileName, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.success10,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              Icon(Icons.check_circle, size: 20, color: AppColors.success),
              const SizedBox(width: 12),
              Expanded(child: Text('Uploaded: $fileName', style: TextStyle(color: AppColors.success))),
              if (_isEditing)
                TextButton(onPressed: () {}, child: Text('Replace')),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Hours', style: TextStyle(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTimePicker('Start', _startTime, () => _selectTime(true))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.arrow_forward, color: AppColors.onSurfaceVariant),
            ),
            Expanded(child: _buildTimePicker('End', _endTime, () => _selectTime(false))),
          ],
        ),
      ],
    );
  }

  Widget _buildTimePicker(String label, TimeOfDay time, VoidCallback onTap) {
    return GestureDetector(
      onTap: _isEditing ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.outline),
        ),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 4),
            Text(_formatTime(time), style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.primary,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Days', style: TextStyle(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _weekDays.map((day) {
            final isSelected = _selectedDays.contains(day);
            return GestureDetector(
              onTap: _isEditing ? () {
                setState(() {
                  if (isSelected) {
                    _selectedDays.remove(day);
                  } else {
                    _selectedDays.add(day);
                  }
                });
                _markChanged();
              } : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.outline,
                  ),
                ),
                child: Text(
                  day,
                  style: TextStyle(
                    color: isSelected ? AppColors.onPrimary : AppColors.onSurface,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
