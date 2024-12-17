import 'package:flutter/material.dart';

class ProfessionalInfoForm extends StatefulWidget {
  const ProfessionalInfoForm({Key? key}) : super(key: key);

  @override
  State<ProfessionalInfoForm> createState() => _ProfessionalInfoFormState();
}

class _ProfessionalInfoFormState extends State<ProfessionalInfoForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _licenseNumberController = TextEditingController();
  final TextEditingController _licenseStateController = TextEditingController();
  final TextEditingController _universityNameController = TextEditingController();
  final TextEditingController _highestDegreeController = TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _graduationYearController = TextEditingController();
  final TextEditingController _workExperienceController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();

  // Date fields
  DateTime? _licenseIssueDate;
  DateTime? _licenseExpiryDate;

  // CV upload
  String? _cvFilePath;

  // Method to pick a date
  Future<void> _selectDate(BuildContext context, {required bool isIssueDate}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isIssueDate) {
          _licenseIssueDate = pickedDate;
        } else {
          _licenseExpiryDate = pickedDate;
        }
      });
    }
  }

  // Method to upload CV
  Future<void> _uploadCV() async {
    // Simulating file selection
    setState(() {
      _cvFilePath = "sample_cv.pdf"; // Replace with actual file picker logic
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Professional Information'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('License Number', _licenseNumberController, 'Enter license number'),
              _buildTextField('License State', _licenseStateController, 'Enter license state'),
              _buildDateField(
                context,
                'License Issue Date',
                _licenseIssueDate,
                isIssueDate: true,
              ),
              _buildDateField(
                context,
                'License Expiry Date',
                _licenseExpiryDate,
                isIssueDate: false,
              ),
              _buildTextField('University Name', _universityNameController, 'Enter university name'),
              _buildTextField('Highest Degree', _highestDegreeController, 'Enter highest degree'),
              _buildTextField('Field of Study', _fieldOfStudyController, 'Enter field of study'),
              _buildTextField(
                'Graduation Year',
                _graduationYearController,
                'Enter graduation year',
                inputType: TextInputType.number,
              ),
              _buildTextField('Work Experience', _workExperienceController, 'Enter work experience'),
              _buildBiographyField(),
              _buildFileUploadField(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform save or update actions here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data saved successfully!')),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to build text fields
  Widget _buildTextField(
      String label, TextEditingController controller, String hint, {TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        validator: (value) => value == null || value.isEmpty ? '$label is required' : null,
      ),
    );
  }

  // Helper to build date fields
  Widget _buildDateField(BuildContext context, String label, DateTime? selectedDate,
      {required bool isIssueDate}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => _selectDate(context, isIssueDate: isIssueDate),
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              hintText: selectedDate != null
                  ? '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}'
                  : 'Select a date',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            validator: (_) => selectedDate == null ? '$label is required' : null,
          ),
        ),
      ),
    );
  }

  // Helper to build biography field
  Widget _buildBiographyField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _biographyController,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: 'Biography',
          hintText: 'Write a brief biography',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  // Helper to build file upload field
  Widget _buildFileUploadField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: _uploadCV,
            child: Text(_cvFilePath == null ? 'Upload CV' : 'Change CV'),
          ),
          const SizedBox(width: 16),
          if (_cvFilePath != null)
            Expanded(
              child: Text(
                'Selected: $_cvFilePath',
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}
