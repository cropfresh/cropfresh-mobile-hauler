import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../widgets/registration_progress_widget.dart';

/// Step 2: Vehicle Information - Story 2.5 AC3
/// Vehicle Type selector, Vehicle Number, Payload Capacity
/// Navigates to vehicle photos screen
class Step2VehicleInfoScreen extends StatefulWidget {
  const Step2VehicleInfoScreen({super.key});

  @override
  State<Step2VehicleInfoScreen> createState() => _Step2VehicleInfoScreenState();
}

class _Step2VehicleInfoScreenState extends State<Step2VehicleInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleNumberController = TextEditingController();
  final _capacityController = TextEditingController();

  String? _selectedVehicleType;
  bool _isLoading = false;

  // Vehicle type data per AC8
  final List<Map<String, dynamic>> _vehicleTypes = [
    {
      'type': 'BIKE',
      'name': 'Bike',
      'icon': Icons.two_wheeler_rounded,
      'maxCapacity': 20,
      'maxRadius': 10,
      'description': 'Small parcels, quick delivery',
    },
    {
      'type': 'AUTO',
      'name': 'Auto',
      'icon': Icons.electric_rickshaw_rounded,
      'maxCapacity': 100,
      'maxRadius': 30,
      'description': 'Medium loads, city routes',
    },
    {
      'type': 'PICKUP_VAN',
      'name': 'Pickup Van',
      'icon': Icons.airport_shuttle_rounded,
      'maxCapacity': 500,
      'maxRadius': 80,
      'description': 'Large loads, inter-city',
    },
    {
      'type': 'SMALL_TRUCK',
      'name': 'Small Truck',
      'icon': Icons.local_shipping_rounded,
      'maxCapacity': 2000,
      'maxRadius': 150,
      'description': 'Bulk transport, long distance',
    },
  ];

  int get _maxCapacity {
    final vehicle = _vehicleTypes.firstWhere(
      (v) => v['type'] == _selectedVehicleType,
      orElse: () => {'maxCapacity': 2000},
    );
    return vehicle['maxCapacity'] as int;
  }

  @override
  void dispose() {
    _vehicleNumberController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  String? _validateVehicleNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter vehicle number';
    }
    // Indian vehicle number format: XX-00-XX-0000
    final pattern = RegExp(r'^[A-Z]{2}[-\s]?\d{2}[-\s]?[A-Z]{1,2}[-\s]?\d{4}$');
    if (!pattern.hasMatch(value.toUpperCase().replaceAll(' ', '-'))) {
      return 'Format: KA-01-AB-1234';
    }
    return null;
  }

  String? _validateCapacity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter payload capacity';
    }
    final capacity = int.tryParse(value);
    if (capacity == null || capacity <= 0) {
      return 'Enter valid capacity in kg';
    }
    if (capacity > _maxCapacity) {
      return 'Max capacity for vehicle: $_maxCapacity kg';
    }
    return null;
  }

  void _onContinue() async {
    if (_selectedVehicleType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a vehicle type'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.of(context).pushNamed('/register/vehicle-photos');
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
            const RegistrationProgressWidget(currentStep: 2),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vehicle\nInformation',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: AppColors.onSurface,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Tell us about your vehicle',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Vehicle Type Selection
                      _buildLabel('Vehicle Type', isRequired: true),
                      const SizedBox(height: 12),
                      _buildVehicleTypeGrid(),

                      const SizedBox(height: 32),

                      // Vehicle Number
                      _buildLabel('Vehicle Number', isRequired: true),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _vehicleNumberController,
                        textCapitalization: TextCapitalization.characters,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                        decoration: InputDecoration(
                          hintText: 'KA-01-AB-1234',
                          prefixIcon: Icon(Icons.confirmation_number_rounded,
                              color: AppColors.onSurfaceVariant),
                        ),
                        validator: _validateVehicleNumber,
                      ),

                      const SizedBox(height: 24),

                      // Payload Capacity
                      _buildLabel('Payload Capacity (kg)', isRequired: true),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _capacityController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: 'Max: $_maxCapacity kg',
                          prefixIcon: Icon(Icons.scale_rounded,
                              color: AppColors.onSurfaceVariant),
                          suffixText: 'kg',
                          suffixStyle: TextStyle(
                            fontSize: 16,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                        validator: _validateCapacity,
                      ),

                      if (_selectedVehicleType != null) ...[
                        const SizedBox(height: 12),
                        _buildCapacityInfo(),
                      ],

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
                              'ADD VEHICLE PHOTOS',
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

  Widget _buildVehicleTypeGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: _vehicleTypes.length,
      itemBuilder: (context, index) {
        final vehicle = _vehicleTypes[index];
        final isSelected = _selectedVehicleType == vehicle['type'];

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedVehicleType = vehicle['type'];
              _capacityController.clear();
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.outline,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primary30,
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  vehicle['icon'] as IconData,
                  size: 40,
                  color: isSelected ? AppColors.onPrimary : AppColors.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  vehicle['name'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? AppColors.onPrimary : AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '≤${vehicle['maxCapacity']}kg • ≤${vehicle['maxRadius']}km',
                  style: TextStyle(
                    fontSize: 11,
                    color: isSelected
                        ? AppColors.onPrimary80
                        : AppColors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCapacityInfo() {
    final vehicle = _vehicleTypes.firstWhere(
      (v) => v['type'] == _selectedVehicleType,
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary10,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary30),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${vehicle['name']}: Max ${vehicle['maxCapacity']}kg, within ${vehicle['maxRadius']}km',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
