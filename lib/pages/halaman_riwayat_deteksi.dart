import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_routes.dart';
import '../state/deteksi_model.dart';
import '../widgets/deteksi_card.dart';
import '../widgets/stat_card.dart';

class HalamanRiwayatDeteksi extends StatefulWidget {
  const HalamanRiwayatDeteksi({super.key});

  @override
  State<HalamanRiwayatDeteksi> createState() =>
      _HalamanRiwayatDeteksiState();
}

class _HalamanRiwayatDeteksiState
    extends State<HalamanRiwayatDeteksi> {
  String filter = 'Semua';

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DeteksiModel>();
    final daftar = model.filterPetak(filter);
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Riwayat Deteksi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: 0.18,
                      ),
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Riwayat Deteksi',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Pantau kesehatan padi '
                          'di setiap petak sawah',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Filter Petak
            Text(
              'Filter Petak Sawah',
              style: tema.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                'Semua',
                'Petak 1',
                'Petak 2',
              ].map((pilihan) {
                return ChoiceChip(
                  label: Text(pilihan),
                  selected: filter == pilihan,
                  selectedColor: warna.primaryContainer,
                  checkmarkColor: warna.onPrimaryContainer,
                  onSelected: (_) {
                    setState(() {
                      filter = pilihan;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 18),

            // Tiga Kartu Statistik
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    judul: 'Total',
                    jumlah: model.total,
                    ikon: Icons.analytics_outlined,
                    warna: warna.primary,
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: StatCard(
                    judul: 'Sehat',
                    jumlah: model.jumlahSehat,
                    ikon: Icons.check_circle_outline,
                    warna: Colors.green,
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: StatCard(
                    judul: 'Perlu Tindakan',
                    jumlah: model.jumlahTindakan,
                    ikon: Icons.warning_amber_rounded,
                    warna: Colors.deepOrange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // Judul Daftar Deteksi
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Daftar Deteksi',
                    style:
                        tema.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: warna.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${daftar.length} data',
                    style: TextStyle(
                      color: warna.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Daftar Hasil Deteksi
            Expanded(
              child: daftar.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: warna.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.inbox_outlined,
                              size: 46,
                              color: warna.onPrimaryContainer,
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            'Belum ada data',
                            style: tema.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Tambahkan hasil deteksi '
                            'untuk mulai memantau kondisi padi.',
                            textAlign: TextAlign.center,
                            style:
                                tema.textTheme.bodyMedium?.copyWith(
                              color: warna.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                        bottom: 100,
                      ),
                      itemCount: daftar.length,
                      itemBuilder: (context, index) {
                        final hasil = daftar[index];

                        return DeteksiCard(
                          hasil: hasil,
                          onHapus: () {
                            context
                                .read<DeteksiModel>()
                                .hapusData(hasil);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.inputDeteksi,
          );
        },
        icon: const Icon(Icons.add_circle_outline),
        label: const Text('Deteksi Baru'),
      ),
    );
  }
}
