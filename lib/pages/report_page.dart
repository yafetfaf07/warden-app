import 'package:flutter/material.dart';
import 'package:warden_app/api/auth.dart';

class IncidentReportForm extends StatefulWidget {
    final String id;

  const IncidentReportForm({super.key, required this.id});

  @override
  State<IncidentReportForm> createState() => _IncidentReportFormState();
}

class _IncidentReportFormState extends State<IncidentReportForm> {
    final AuthService _service = AuthService();
  String parkingId = "";
    @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final (name, isSuccessful) = await _service.getProfile(widget.id);

      setState(() {
        if (isSuccessful && name != null) {
          parkingId = name.parkingAvenueId;
        } else if (name == null) {
          parkingId = "Unknown";
        }
      });
    });
  }

  final _formKey = GlobalKey<FormState>();
  
  // Form Controllers
  String _selectedCategory = 'ACCIDENT';
  final TextEditingController _reasonController = TextEditingController();
  
  bool _isLoading = false;

  final List<String> _categories = [
    'ACCIDENT',
    'MAINTENANCE',
    'SECURITY',
    'ILLEGAL_PARKING',
    'OTHER'
  ];

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final (report, success) = await _service.reportIncident(
      _selectedCategory,
      _reasonController.text,
      parkingId,
    );

    setState(() => _isLoading = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Report filed! ID: ${report?.id}'), backgroundColor: Colors.green,),
      );
      _formKey.currentState!.reset();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit report. Please try again.'),backgroundColor: Colors.red,),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Report Incident")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Incident Category'),
                items: _categories.map((String category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value!),
              ),
              const SizedBox(height: 16),
       
              const SizedBox(height: 16),

              // Reason Text Field
              TextFormField(
                controller: _reasonController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Reason/Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.length < 10 ? 'Please provide more detail' : null,
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _isLoading ? null : _submitReport,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white) 
                  : const Text("Submit Incident Report"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }
}