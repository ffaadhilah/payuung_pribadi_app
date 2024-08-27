import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddressPage extends StatefulWidget {
  final XFile? ktpImage;
  final Function(XFile?) onImageSelected;
  final TextEditingController nikController;
  final TextEditingController alamatController;
  final TextEditingController provinsiController;
  final TextEditingController kotaController;
  final TextEditingController kecamatanController;
  final TextEditingController kelurahanController;

  AddressPage({
    required this.ktpImage,
    required this.onImageSelected,
    required this.nikController,
    required this.alamatController,
    required this.provinsiController,
    required this.kotaController,
    required this.kecamatanController,
    required this.kelurahanController,
  });

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      widget.onImageSelected(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUploadKTP(),
            SizedBox(height: 16),
            _buildTextField('NIK', controller: widget.nikController),
            SizedBox(height: 16),
            _buildTextField('ALAMAT SESUAI KTP',
                controller: widget.alamatController),
            SizedBox(height: 16),
            _buildDropdownField('PROVINSI', widget.provinsiController.text,
                (newValue) {
              setState(() {
                widget.provinsiController.text = newValue!;
              });
            }),
            SizedBox(height: 16),
            _buildDropdownField('KOTA/KABUPATEN', widget.kotaController.text,
                (newValue) {
              setState(() {
                widget.kotaController.text = newValue!;
              });
            }),
            SizedBox(height: 16),
            _buildDropdownField('KECAMATAN', widget.kecamatanController.text,
                (newValue) {
              setState(() {
                widget.kecamatanController.text = newValue!;
              });
            }),
            SizedBox(height: 16),
            _buildDropdownField('KELURAHAN', widget.kelurahanController.text,
                (newValue) {
              setState(() {
                widget.kelurahanController.text = newValue!;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadKTP() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.person, size: 40, color: Colors.yellow[700]),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.ktpImage != null ? widget.ktpImage!.name : 'Upload KTP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (widget.ktpImage != null)
              Icon(Icons.check_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label,
      {required TextEditingController controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildDropdownField(
      String label, String selectedValue, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue.isEmpty ? 'Pilih' : selectedValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      items: [
        DropdownMenuItem(child: Text('Pilih'), value: 'Pilih'),
        DropdownMenuItem(child: Text('Option 1'), value: 'Option 1'),
        DropdownMenuItem(child: Text('Option 2'), value: 'Option 2'),
      ],
      onChanged: onChanged,
    );
  }
}
