import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _senderNameController = TextEditingController();
  final TextEditingController _senderPhoneController = TextEditingController();
  final TextEditingController _senderAddressController =
      TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _receiverPhoneController =
      TextEditingController();
  final TextEditingController _receiverAddressController =
      TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemValueController = TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();
  final TextEditingController _itemWeightController = TextEditingController();
  final TextEditingController _itemLengthController = TextEditingController();
  final TextEditingController _itemWidthController = TextEditingController();
  final TextEditingController _itemHeightController = TextEditingController();

  String _selectedPaymentType = 'COD';
  final String _selectedService = 'Pilih layanan';
  final String _selectedVoucher = 'Voucher';
  final String _selectedPacking = 'Bungkus';

  @override
  void dispose() {
    _labelController.dispose();
    _senderNameController.dispose();
    _senderPhoneController.dispose();
    _senderAddressController.dispose();
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    _receiverAddressController.dispose();
    _itemNameController.dispose();
    _itemValueController.dispose();
    _itemDescriptionController.dispose();
    _itemWeightController.dispose();
    _itemLengthController.dispose();
    _itemWidthController.dispose();
    _itemHeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Pengiriman',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pengirim Section
            _buildSection(
              title: 'Pengirim',
              actionText: 'Ubah',
              children: [
                _buildInputField('Label', _labelController, 'Contoh : Rumah'),
                const SizedBox(height: 16),
                _buildInputField(
                    'Nama Pengirim', _senderNameController, 'Contoh : Joe'),
                const SizedBox(height: 16),
                _buildInputField('No. Handphone', _senderPhoneController,
                    'Contoh : +6289876543210'),
                const SizedBox(height: 16),
                _buildLocationField('Area Penjemputan',
                    'Kelurahan, Kecamatan, Kabupaten, Provinsi'),
                const SizedBox(height: 16),
                _buildLocationField(
                    'Pilih Lokasi', 'Pilih Lokasi Spesifik Anda'),
                const SizedBox(height: 16),
                _buildInputField('Alamat Lengkap', _senderAddressController,
                    'Contoh : Jln, Xxx Xxx'),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B7BF5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Penerima Section
            _buildSection(
              title: 'Penerima',
              actionText: 'Ubah',
              children: [
                _buildInputField(
                    'Nama Penerima', _receiverNameController, 'Contoh : Joe'),
                const SizedBox(height: 16),
                _buildInputField('No. Handphone', _receiverPhoneController,
                    'Contoh : +6289876543210'),
                const SizedBox(height: 16),
                _buildLocationField('Area Tujuan',
                    'Kelurahan , Kecamatan , Kabupaten , Provinsi'),
                const SizedBox(height: 16),
                _buildLocationField('Alamat Lengkap', 'Contoh : Jln, Xxx Xxx',
                    hasPreview: true),
              ],
            ),

            const SizedBox(height: 24),

            // Informasi Barang Section
            _buildSection(
              title: 'Informasi Barang',
              actionText: 'Ubah',
              children: [
                _buildInputField(
                    'Nama Barang', _itemNameController, 'Contoh : Laptop'),
                const SizedBox(height: 16),
                _buildDropdownField('Jenis Barang', 'Pilih Jenis Barang'),
                const SizedBox(height: 16),
                _buildInputField('Keterangan', _itemDescriptionController,
                    'Contoh : Barang antik'),
                const SizedBox(height: 16),
                _buildInputField('Nilai Barang', _itemValueController,
                    'Contoh : Rp. 250 000'),
                const SizedBox(height: 16),
                _buildDimensionFields(),
              ],
            ),

            const SizedBox(height: 24),

            // Tipe Pembayaran Section
            _buildSection(
              title: 'Tipe Pembayaran',
              children: [
                _buildPaymentTypeSelector(),
                const SizedBox(height: 16),
                _buildDropdownField('Opsi Penjemputan', 'Opsi Penjemputan'),
              ],
            ),

            const SizedBox(height: 24),

            // Tambahan Section
            _buildSection(
              title: 'Tambahan',
              children: [
                _buildDropdownField('Pilih layanan', _selectedService),
                const SizedBox(height: 16),
                _buildDropdownField('Voucher', _selectedVoucher),
                const SizedBox(height: 16),
                _buildDropdownField('Bungkus', _selectedPacking),
              ],
            ),

            const SizedBox(height: 40),

            // Kirim Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  _submitShipping();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B7BF5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'KIRIM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    String? actionText,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              if (actionText != null)
                Text(
                  actionText,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4B7BF5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInputField(
      String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(36),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              hintStyle: const TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationField(String label, String hint,
      {bool hasPreview = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hint,
                  style: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 14,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF9E9E9E),
                size: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDimensionFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                  'Berat Barang', _itemWeightController, 'Contoh : 5kg'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputField(
                  'Jumlah Isi Paket', TextEditingController(), 'Contoh : 1'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                  'Panjang', _itemLengthController, 'Contoh: 10'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child:
                  _buildInputField('lebar', _itemWidthController, 'Contoh: 10'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInputField(
                  'tinggi', _itemHeightController, 'Contoh: 10'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedPaymentType = 'COD';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _selectedPaymentType == 'COD'
                    ? const Color(0xFF4B7BF5)
                    : const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  'COD',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _selectedPaymentType == 'COD'
                        ? Colors.white
                        : const Color(0xFF4B7BF5),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedPaymentType = 'Non-COD';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _selectedPaymentType == 'Non-COD'
                    ? const Color(0xFF4B7BF5)
                    : const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  'Non-COD',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _selectedPaymentType == 'Non-COD'
                        ? Colors.white
                        : const Color(0xFF4B7BF5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _submitShipping() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pengiriman berhasil dibuat!'),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate back to home or show success screen
    Navigator.of(context).pop();
  }
}
