import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/hasil_deteksi.dart';
import '../models/rekomendasi.dart';
import '../state/deteksi_model.dart';

class HalamanInputDeteksi extends StatefulWidget {
  const HalamanInputDeteksi({super.key});

  @override
  State<HalamanInputDeteksi> createState() =>
      _HalamanInputDeteksiState();
}

class _HalamanInputDeteksiState
    extends State<HalamanInputDeteksi> {
  final skorController = TextEditingController();
  final petugasController = TextEditingController();

  String petak = 'Petak 1';
  String kelas = rekomendasiKelas.keys.first;

  bool dataBenar = false;
  bool sedangMenyimpan = false;

  String? errorSkor;
  String? errorPetugas;

  @override
  void dispose() {
    skorController.dispose();
    petugasController.dispose();
    super.dispose();
  }

  Future<void> simpanData() async {
    if (!dataBenar || sedangMenyimpan) return;

    final skor = int.tryParse(skorController.text.trim());
    final nama = petugasController.text.trim();

    setState(() {
      errorSkor = null;
      errorPetugas = null;

      if (skor == null || skor < 0 || skor > 100) {
        errorSkor = 'Skor harus angka 0 sampai 100';
      }

      if (nama.isEmpty) {
        errorPetugas = 'Nama petugas tidak boleh kosong';
      }
    });

    if (errorSkor != null || errorPetugas != null) {
      return;
    }

    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.fact_check_outlined,
            size: 36,
          ),
          title: const Text(
            'Konfirmasi Data',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Apakah data deteksi berikut sudah benar?\n\n'
            'Petak: $petak\n'
            'Kelas: $kelas\n'
            'Skor: $skor%\n'
            'Petugas: $nama',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              icon: const Icon(Icons.check),
              label: const Text('Ya, Simpan'),
            ),
          ],
        );
      },
    );

    if (!mounted || konfirmasi != true) return;

    setState(() {
      sedangMenyimpan = true;
    });

    final hasil = HasilDeteksi(
      petak: petak,
      kelas: kelas,
      skor: skor!,
      namaPetugas: nama,
      waktu: DateTime.now(),
    );

    context.read<DeteksiModel>().tambahData(hasil);

    final messenger = ScaffoldMessenger.of(context);

    Navigator.pop(context);

    messenger.showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text('Data tersimpan'),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Deteksi'),
        centerTitle: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header form
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1B5E20),
                    Color(0xFF43A047),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.document_scanner_outlined,
                    color: Colors.white,
                    size: 38,
                  ),

                  SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Form Hasil Deteksi CNN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Catat hasil pemeriksaan '
                          'kesehatan tanaman padi.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Informasi Petak Sawah
            _judulBagian(
              context,
              Icons.landscape_outlined,
              'Lokasi Pemeriksaan',
            ),

            const SizedBox(height: 12),

            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pilih Petak Sawah',
                      style: tema.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    RadioGroup<String>(
                      groupValue: petak,
                      onChanged: (nilai) {
                        if (nilai != null) {
                          setState(() {
                            petak = nilai;
                          });
                        }
                      },
                      child: const Column(
                        children: [
                          RadioListTile<String>(
                            title: Text('Petak 1'),
                            subtitle: Text(
                              'Area persawahan pertama',
                            ),
                            value: 'Petak 1',
                          ),
                          RadioListTile<String>(
                            title: Text('Petak 2'),
                            subtitle: Text(
                              'Area persawahan kedua',
                            ),
                            value: 'Petak 2',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Data hasil deteksi
            _judulBagian(
              context,
              Icons.biotech_outlined,
              'Hasil Deteksi CNN',
            ),

            const SizedBox(height: 12),

            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: kelas,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Kelas Prediksi',
                        prefixIcon: const Icon(
                          Icons.eco_outlined,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      items: rekomendasiKelas.keys
                          .map((nama) {
                        return DropdownMenuItem<String>(
                          value: nama,
                          child: Text(
                            nama,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (nilai) {
                        if (nilai != null) {
                          setState(() {
                            kelas = nilai;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 18),

                    TextField(
                      controller: skorController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        labelText: 'Skor Deteksi (%)',
                        hintText: 'Contoh: 85',
                        prefixIcon: const Icon(
                          Icons.percent,
                        ),
                        helperText:
                            'Masukkan skor antara 0 sampai 100',
                        errorText: errorSkor,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (_) {
                        if (errorSkor != null) {
                          setState(() {
                            errorSkor = null;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Data Petugas
            _judulBagian(
              context,
              Icons.badge_outlined,
              'Informasi Petugas',
            ),

            const SizedBox(height: 12),

            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: petugasController,
                  textCapitalization:
                      TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Nama Petugas',
                    hintText: 'Masukkan nama petugas',
                    prefixIcon: const Icon(
                      Icons.person_outline,
                    ),
                    errorText: errorPetugas,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (_) {
                    if (errorPetugas != null) {
                      setState(() {
                        errorPetugas = null;
                      });
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 22),

            // Informasi penggunaan
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: warna.secondaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: warna.onSecondaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Pastikan kelas prediksi, skor, '
                      'dan nama petugas sesuai '
                      'hasil pemeriksaan.',
                      style: TextStyle(
                        color: warna.onSecondaryContainer,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Konfirmasi data
            Card(
              margin: EdgeInsets.zero,
              child: CheckboxListTile(
                title: const Text(
                  'Data sudah benar',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Saya telah memeriksa informasi '
                  'yang akan disimpan.',
                ),
                secondary: Icon(
                  Icons.fact_check_outlined,
                  color: warna.primary,
                ),
                value: dataBenar,
                controlAffinity:
                    ListTileControlAffinity.trailing,
                onChanged: (nilai) {
                  setState(() {
                    dataBenar = nilai ?? false;
                  });
                },
              ),
            ),

            const SizedBox(height: 24),

            // Tombol simpan
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed:
                    dataBenar && !sedangMenyimpan
                        ? simpanData
                        : null,
                icon: const Icon(
                  Icons.save_outlined,
                ),
                label: const Text(
                  'Simpan Hasil Deteksi',
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 17,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _judulBagian(
    BuildContext context,
    IconData ikon,
    String judul,
  ) {
    final tema = Theme.of(context);

    return Row(
      children: [
        Icon(
          ikon,
          color: tema.colorScheme.primary,
          size: 24,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            judul,
            style: tema.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
