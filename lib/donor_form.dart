import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/donor.dart';
import 'constants/app_constants.dart';
import 'utils/validators.dart';

class DonorForm extends StatefulWidget {
  const DonorForm({super.key});

  @override
  State<DonorForm> createState() => _DonorFormState();
}

class _DonorFormState extends State<DonorForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final phoneController = TextEditingController();
  final villageController = TextEditingController();
  bool isAvailable = true;
  bool _isSubmitting = false;

  final List<String> bloodGroups = AppConstants.bloodGroups;

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final donor = Donor(
        name: nameController.text.trim(),
        bloodGroup: bloodGroupController.text.trim(),
        phone: phoneController.text.trim(),
        village: villageController.text.trim(),
        isAvailable: isAvailable,
      );

      final success = await ApiService.addDonor(donor);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("✅ Donor registered successfully!"),
            backgroundColor: Colors.green,
          ),
        );
        _clearForm();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("❌ Failed to register donor. Please try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("❌ Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _clearForm() {
    nameController.clear();
    bloodGroupController.clear();
    phoneController.clear();
    villageController.clear();
    setState(() {
      isAvailable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Become a Blood Donor"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validateName,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: bloodGroupController.text.isNotEmpty ? bloodGroupController.text : null,
                decoration: const InputDecoration(
                  labelText: "Blood Group",
                  border: OutlineInputBorder(),
                ),
                items: bloodGroups.map((String bloodGroup) {
                  return DropdownMenuItem<String>(
                    value: bloodGroup,
                    child: Text(bloodGroup),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    bloodGroupController.text = newValue ?? '';
                  });
                },
                validator: Validators.validateBloodGroup,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: villageController,
                decoration: const InputDecoration(
                  labelText: "Village/City",
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validateVillage,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text("Available for Donation"),
                value: isAvailable,
                onChanged: (val) => setState(() => isAvailable = val),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSubmitting ? null : submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: _isSubmitting 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Register as Donor"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    bloodGroupController.dispose();
    phoneController.dispose();
    villageController.dispose();
    super.dispose();
  }
}