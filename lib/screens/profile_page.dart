import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:payuung_pribadi_app/db/database_helper.dart';
import 'package:payuung_pribadi_app/screens/address_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _kotaController = TextEditingController();
  final TextEditingController _provinsiController = TextEditingController();
  final TextEditingController _kodePosController = TextEditingController();
  final TextEditingController _cabangBankController = TextEditingController();
  final TextEditingController _nomorRekeningController =
      TextEditingController();
  final TextEditingController _namaPemilikRekeningController =
      TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _kelurahanController = TextEditingController();

  String _jenisKelamin = 'Pilih';
  String _pendidikan = 'Pilih';
  String _statusPernikahan = 'Pilih';
  String _lamaBekerja = 'Pilih';
  String _sumberPendapatan = 'Pilih';
  String _pendapatanKotorPertahun = 'Pilih';
  String _namaBank = 'Pilih';

  PageController _pageController = PageController();
  int _currentIndex = 0;
  XFile? _ktpImage;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    var profile = await DatabaseHelper().getProfile(1);
    if (profile != null) {
      setState(() {
        _namaController.text = profile['nama'] ?? '';
        _dateController.text = profile['tanggal_lahir'] ?? '';
        _jenisKelamin = profile['jenis_kelamin'] ?? 'Pilih';
        _emailController.text = profile['alamat_email'] ?? '';
        _noHpController.text = profile['no_hp'] ?? '';
        _pendidikan = profile['pendidikan'] ?? 'Pilih';
        _statusPernikahan = profile['status_pernikahan'] ?? 'Pilih';
        _alamatController.text = profile['alamat'] ?? '';
        _kotaController.text = profile['kota'] ?? '';
        _provinsiController.text = profile['provinsi'] ?? '';
        _kodePosController.text = profile['kode_pos'] ?? '';
        _lamaBekerja = profile['lama_bekerja'] ?? 'Pilih';
        _sumberPendapatan = profile['sumber_pendapatan'] ?? 'Pilih';
        _pendapatanKotorPertahun =
            profile['pendapatan_kotor_pertahun'] ?? 'Pilih';
        _namaBank = profile['nama_bank'] ?? 'Pilih';
        _cabangBankController.text = profile['cabang_bank'] ?? '';
        _nomorRekeningController.text = profile['nomor_rekening'] ?? '';
        _namaPemilikRekeningController.text =
            profile['nama_pemilik_rekening'] ?? '';
        _nikController.text = profile['nik'] ?? '';
        _kecamatanController.text = profile['kecamatan'] ?? '';
        _kelurahanController.text = profile['kelurahan'] ?? '';
        if (profile['ktp_image'] != null) {
          _ktpImage = XFile(profile['ktp_image']);
        }
      });
    }
  }

  void _saveProfile() async {
    Map<String, dynamic> row = {
      'id': 1,
      'nama': _namaController.text,
      'tanggal_lahir': _dateController.text,
      'jenis_kelamin': _jenisKelamin,
      'alamat_email': _emailController.text,
      'no_hp': _noHpController.text,
      'pendidikan': _pendidikan,
      'status_pernikahan': _statusPernikahan,
      'alamat': _alamatController.text,
      'kota': _kotaController.text,
      'provinsi': _provinsiController.text,
      'kode_pos': _kodePosController.text,
      'lama_bekerja': _lamaBekerja,
      'sumber_pendapatan': _sumberPendapatan,
      'pendapatan_kotor_pertahun': _pendapatanKotorPertahun,
      'nama_bank': _namaBank,
      'cabang_bank': _cabangBankController.text,
      'nomor_rekening': _nomorRekeningController.text,
      'nama_pemilik_rekening': _namaPemilikRekeningController.text,
      'nik': _nikController.text,
      'kecamatan': _kecamatanController.text,
      'kelurahan': _kelurahanController.text,
      'ktp_image': _ktpImage?.path,
    };

    var profile = await DatabaseHelper().getProfile(1);
    if (profile != null) {
      await DatabaseHelper().updateProfile(row);
    } else {
      await DatabaseHelper().insertProfile(row);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data berhasil disimpan'),
        backgroundColor: Colors.green,
      ),
    );

    await _loadProfile();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _nextPage() {
    if (_currentIndex < 2) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.animateToPage(
        _currentIndex - 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _setKtpImage(XFile? image) {
    setState(() {
      _ktpImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Pribadi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          _buildStepper(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                _buildPersonalInfoPage(),
                AddressPage(
                  ktpImage: _ktpImage,
                  onImageSelected: _setKtpImage,
                  nikController: _nikController,
                  alamatController: _alamatController,
                  provinsiController: _provinsiController,
                  kotaController: _kotaController,
                  kecamatanController: _kecamatanController,
                  kelurahanController: _kelurahanController,
                ),
                _buildCompanyInfoPage(),
              ],
            ),
          ),
          if (_currentIndex > 0) _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStep(1, 'Biodata Diri', 0),
          _buildStep(2, 'Alamat Pribadi', 1),
          _buildStep(3, 'Informasi Perusahaan', 2),
        ],
      ),
    );
  }

  Widget _buildStep(int stepNumber, String title, int pageIndex) {
    bool isActive = _currentIndex >= pageIndex;
    return GestureDetector(
      onTap: () {
        _goToPage(pageIndex);
      },
      child: Column(
        children: [
          Container(
            width: 60,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      isActive ? Colors.yellow[700] : Colors.grey[300],
                  child: Text(
                    '$stepNumber',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isActive ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoPage() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField('Nama Lengkap',
                      controller: _namaController, hintText: 'test'),
                  SizedBox(height: 16),
                  _buildTextField(
                    'Tanggal Lahir',
                    controller: _dateController,
                    suffixIcon: Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          _dateController.text =
                              DateFormat('dd MMMM yyyy').format(pickedDate);
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  _buildDropdownField('Jenis Kelamin', _jenisKelamin,
                      (newValue) {
                    setState(() {
                      _jenisKelamin = newValue!;
                    });
                  }),
                  SizedBox(height: 16),
                  _buildTextField('Alamat Email',
                      controller: _emailController,
                      hintText: 'hreprouat@gmail.com'),
                  SizedBox(height: 16),
                  _buildTextField('No. HP',
                      controller: _noHpController, hintText: '087887878878'),
                  SizedBox(height: 16),
                  _buildDropdownField('Pendidikan', _pendidikan, (newValue) {
                    setState(() {
                      _pendidikan = newValue!;
                    });
                  }),
                  SizedBox(height: 16),
                  _buildDropdownField('Status Pernikahan', _statusPernikahan,
                      (newValue) {
                    setState(() {
                      _statusPernikahan = newValue!;
                    });
                  }),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.yellow[700],
                  minimumSize: Size(150, 50),
                ),
                child: Text('Selanjutnya'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label, {
    String? hintText,
    TextEditingController? controller,
    Widget? suffixIcon,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          suffixIcon: suffixIcon != null
              ? GestureDetector(
                  onTap: onTap,
                  child: suffixIcon,
                )
              : null,
        ),
        readOnly: onTap != null,
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

  Widget _buildCompanyInfoPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdownField('Lama Bekerja', _lamaBekerja, (newValue) {
              setState(() {
                _lamaBekerja = newValue!;
              });
            }),
            SizedBox(height: 16),
            _buildDropdownField('Sumber Pendapatan', _sumberPendapatan,
                (newValue) {
              setState(() {
                _sumberPendapatan = newValue!;
              });
            }),
            SizedBox(height: 16),
            _buildDropdownField(
                'Pendapatan Kotor Pertahun', _pendapatanKotorPertahun,
                (newValue) {
              setState(() {
                _pendapatanKotorPertahun = newValue!;
              });
            }),
            SizedBox(height: 16),
            _buildDropdownField('Nama Bank', _namaBank, (newValue) {
              setState(() {
                _namaBank = newValue!;
              });
            }),
            SizedBox(height: 16),
            _buildTextField('Cabang Bank', controller: _cabangBankController),
            SizedBox(height: 16),
            _buildTextField('Nomor Rekening',
                controller: _nomorRekeningController),
            SizedBox(height: 16),
            _buildTextField('Nama Pemilik Rekening',
                controller: _namaPemilikRekeningController),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: _previousPage,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.yellow[700],
              minimumSize: Size(150, 50),
            ),
            child: Text('Sebelumnya'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_currentIndex == 2) {
                _saveProfile();
              } else {
                _nextPage();
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.yellow[700],
              minimumSize: Size(150, 50),
            ),
            child: Text(_currentIndex == 2 ? 'Simpan' : 'Selanjutnya'),
          )
        ],
      ),
    );
  }
}
