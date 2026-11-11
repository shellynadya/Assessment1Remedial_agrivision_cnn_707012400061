import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/deteksi_model.dart';
import '../state/theme_model.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  Future<void> konfirmasiHapus(
    BuildContext context,
  ) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning_amber_rounded,
            size: 38,
          ),
          title: const Text('Hapus Semua Data?'),
          content: const Text(
            'Seluruh riwayat hasil deteksi '
            'akan dihapus dari aplikasi. '
            'Apakah kamu yakin?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Ya, Hapus'),
            ),
          ],
        );
      },
    );

    if (!context.mounted || yakin != true) {
      return;
    }

    context.read<DeteksiModel>().hapusSemua();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Semua data berhasil dihapus'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    final model = context.watch<DeteksiModel>();
    final modelTema = context.watch<ThemeModel>();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        // Header Pengaturan
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
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.tune_rounded,
                color: Colors.white,
                size: 36,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pengaturan Aplikasi',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Kelola tampilan dan data '
                      'pemantauan AgriVision.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 26),

        Text(
          'Preferensi Tampilan',
          style: tema.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        // Switch Mode Gelap
        Card(
          margin: EdgeInsets.zero,
          child: SwitchListTile(
            secondary: Icon(
              modelTema.modeGelap
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: warna.primary,
            ),
            title: const Text('Mode Gelap'),
            subtitle: Text(
              modelTema.modeGelap
                  ? 'Tampilan gelap sedang aktif'
                  : 'Aktifkan tampilan gelap aplikasi',
            ),
            value: modelTema.modeGelap,
            onChanged: (nilai) {
              context.read<ThemeModel>().ubahTema(nilai);
            },
          ),
        ),

        const SizedBox(height: 28),

        Text(
          'Kelola Data Deteksi',
          style: tema.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: warna.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.storage_outlined,
                    color: warna.onPrimaryContainer,
                  ),
                ),
                title: const Text('Data Tersimpan'),
                subtitle: Text(
                  '${model.total} hasil deteksi tersimpan',
                ),
                trailing: Text(
                  '${model.total}',
                  style: tema.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: warna.primary,
                  ),
                ),
              ),

              const Divider(height: 1),

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16, 18, 16, 8,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      context
                          .read<DeteksiModel>()
                          .buatDataSimulasi();

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            '10 data simulasi berhasil ditambahkan',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.auto_awesome_outlined,
                    ),
                    label: const Text(
                      'Muat Data Simulasi',
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16, 6, 16, 16,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      konfirmasiHapus(context);
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: warna.error,
                    ),
                    label: Text(
                      'Hapus Semua Data',
                      style: TextStyle(
                        color: warna.error,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      side: BorderSide(
                        color: warna.error,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 26),

        Text(
          'Informasi Aplikasi',
          style: tema.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            leading: Icon(
              Icons.eco_outlined,
              color: warna.primary,
              size: 28,
            ),
            title: const Text('AgriVision CNN'),
            subtitle: const Text(
              'Pencatatan simulasi deteksi '
              'penyakit padi menggunakan '
              'EfficientNet-B0 untuk dua petak sawah.',
            ),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
