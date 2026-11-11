import 'package:flutter/material.dart';
import '../models/rekomendasi.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    final kelas = rekomendasiKelas.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'AgriVision CNN',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Aplikasi untuk mencatat riwayat hasil deteksi '
            'penyakit dan hama padi pada Petak 1 dan Petak 2. '
            'Aplikasi menggunakan simulasi hasil model '
            'EfficientNet-B0 tanpa koneksi API.',
          ),

          const SizedBox(height: 20),

          const Text(
            'Daftar 5 Kelas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...kelas.map(
            (nama) => Card(
              child: ListTile(
                leading: const Icon(Icons.grass),
                title: Text(nama),
              ),
            ),
          ),
        ],
      ),
    );
  }
}