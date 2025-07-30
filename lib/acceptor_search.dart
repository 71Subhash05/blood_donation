import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/donor.dart';
import 'constants/app_constants.dart';

class AcceptorSearch extends StatefulWidget {
  const AcceptorSearch({super.key});

  @override
  State<AcceptorSearch> createState() => _AcceptorSearchState();
}

class _AcceptorSearchState extends State<AcceptorSearch> {
  final _villageController = TextEditingController();
  String? _selectedBloodGroup;
  List<Donor> _donors = [];
  bool _loading = false;
  String _error = '';

  final List<String> _bloodGroups = AppConstants.bloodGroups;

  @override
  void initState() {
    super.initState();
    _loadAllDonors();
  }

  Future<void> _loadAllDonors() async {
    setState(() => _loading = true);
    try {
      final donors = await ApiService.fetchDonors();
      setState(() => _donors = donors);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _searchDonors() async {
    final village = _villageController.text.trim();
    
    if (village.isEmpty && _selectedBloodGroup == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter village or select blood group'), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      final donors = await ApiService.fetchDonors(
        village: village.isNotEmpty ? village : null,
        bloodGroup: _selectedBloodGroup,
      );
      setState(() => _donors = donors);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Blood Donors"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _villageController,
                    decoration: const InputDecoration(
                      labelText: 'Village/City',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedBloodGroup,
                    decoration: const InputDecoration(
                      labelText: 'Blood Group',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.bloodtype),
                    ),
                    items: _bloodGroups.map((group) => 
                      DropdownMenuItem(value: group, child: Text(group))
                    ).toList(),
                    onChanged: (value) => setState(() => _selectedBloodGroup = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _searchDonors,
                    icon: const Icon(Icons.search),
                    label: const Text("Search"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _villageController.clear();
                      setState(() => _selectedBloodGroup = null);
                      _loadAllDonors();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Show All"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, foregroundColor: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_loading) const CircularProgressIndicator(),
            if (_error.isNotEmpty) 
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.red.shade50, border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(8)),
                child: Text(_error, style: const TextStyle(color: Colors.red)),
              ),
            if (_donors.isNotEmpty)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.green.shade50, border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(8)),
                      child: Text('Found ${_donors.length} donor(s)', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _donors.length,
                        itemBuilder: (context, index) {
                          final donor = _donors[index];
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Text(donor.bloodGroup, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                              title: Text(donor.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("📞 ${donor.phone}"),
                                  Text("📍 ${donor.village}"),

                                ],
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: donor.isAvailable ? Colors.green : Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(donor.isAvailable ? 'Available' : 'Busy', style: const TextStyle(color: Colors.white, fontSize: 12)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (!_loading && _donors.isEmpty && _error.isEmpty)
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('No donors found', style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}