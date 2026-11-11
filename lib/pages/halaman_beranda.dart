import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_routes.dart';
import '../state/deteksi_model.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;
    final deteksi = context.watch<DeteksiModel>();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Header sambutan
        Container(
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
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.eco,
                size: 42,
                color: Colors.white,
              ),

              const SizedBox(height: 18),

              const Text(
                'Selamat Datang di AgriVision CNN',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Solusi pencatatan dan pemantauan '
                'hasil deteksi penyakit tanaman padi '
                'untuk kelompok tani.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '🌾 Smart Rice Monitoring',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 26),

        // Ringkasan data
        Text(
          'Ringkasan Pemantauan',
          style: tema.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: _KartuRingkasan(
                judul: 'Total Deteksi',
                jumlah: deteksi.total,
                ikon: Icons.analytics_outlined,
                warna: warna.primary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _KartuRingkasan(
                judul: 'Tanaman Sehat',
                jumlah: deteksi.jumlahSehat,
                ikon: Icons.check_circle_outline,
                warna: Colors.green,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _KartuRingkasan(
                judul: 'Perlu Tindakan',
                jumlah: deteksi.jumlahTindakan,
                ikon: Icons.warning_amber_rounded,
                warna: Colors.deepOrange,
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        // Informasi model
        Text(
          'Teknologi Deteksi',
          style: tema.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: warna.primaryContainer,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.memory,
                        color: warna.onPrimaryContainer,
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EfficientNet-B0',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Model klasifikasi penyakit padi',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Divider(height: 30),

                const _BarisInformasi(
                  ikon: Icons.category_outlined,
                  label: 'Jumlah kelas',
                  nilai: '5 kelas',
                ),

                const SizedBox(height: 12),

                const _BarisInformasi(
                  ikon: Icons.coronavirus_outlined,
                  label: 'Kategori penyakit',
                  nilai: '4 penyakit',
                ),

                const SizedBox(height: 12),

                const _BarisInformasi(
                  ikon: Icons.spa_outlined,
                  label: 'Kategori sehat',
                  nilai: '1 kelas',
                ),

                const SizedBox(height: 12),

                const _BarisInformasi(
                  ikon: Icons.landscape_outlined,
                  label: 'Wilayah pantauan',
                  nilai: '2 petak sawah',
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 22),

        // Informasi simulasi
        Card(
          color: warna.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: warna.onSecondaryContainer,
                  size: 28,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Aplikasi ini menggunakan simulasi '
                    'hasil deteksi CNN. Data dimasukkan '
                    'secara manual tanpa koneksi API.',
                    style: TextStyle(
                      color: warna.onSecondaryContainer,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 22),

        // Tombol tentang aplikasi
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.tentang,
              );
            },
            icon: const Icon(Icons.info_outline),
            label: const Text('Tentang Aplikasi'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

// Widget kartu ringkasan
class _KartuRingkasan extends StatelessWidget {
  final String judul;
  final int jumlah;
  final IconData ikon;
  final Color warna;

  const _KartuRingkasan({
    required this.judul,
    required this.jumlah,
    required this.ikon,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        child: Column(
          children: [
            Icon(
              ikon,
              color: warna,
              size: 27,
            ),

            const SizedBox(height: 12),

            Text(
              '$jumlah',
              style: tema.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              judul,
              textAlign: TextAlign.center,
              style: tema.textTheme.labelSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget baris informasi model
class _BarisInformasi extends StatelessWidget {
  final IconData ikon;
  final String label;
  final String nilai;

  const _BarisInformasi({
    required this.ikon,
    required this.label,
    required this.nilai,
  });

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          ikon,
          size: 20,
          color: warna.primary,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label),
        ),
        Flexible(
          child: Text(
            nilai,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
