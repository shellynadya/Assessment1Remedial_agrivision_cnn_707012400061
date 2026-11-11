import 'package:flutter/material.dart';

import '../models/hasil_deteksi.dart';

class DeteksiCard extends StatelessWidget {
  final HasilDeteksi hasil;
  final VoidCallback onHapus;

  const DeteksiCard({
    super.key,
    required this.hasil,
    required this.onHapus,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final skema = tema.colorScheme;

    // Menentukan warna dan ikon berdasarkan status
    late final Color warnaStatus;
    late final IconData ikonStatus;

    if (hasil.status == 'Sehat') {
      warnaStatus = const Color(0xFF388E3C);
      ikonStatus = Icons.check_circle_rounded;
    } else if (hasil.status == 'Tidak Pasti') {
      warnaStatus = const Color(0xFFEF6C00);
      ikonStatus = Icons.help_rounded;
    } else {
      warnaStatus = const Color(0xFFD32F2F);
      ikonStatus = Icons.warning_rounded;
    }

    // Format tanggal dan waktu
    final waktu = hasil.waktu;
    final tanggal =
        '${waktu.day.toString().padLeft(2, '0')}/'
        '${waktu.month.toString().padLeft(2, '0')}/'
        '${waktu.year} '
        '${waktu.hour.toString().padLeft(2, '0')}:'
        '${waktu.minute.toString().padLeft(2, '0')}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nama petak dan tombol hapus
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: skema.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.grass,
                    color: skema.onPrimaryContainer,
                    size: 24,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasil.petak,
                        style: tema.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        hasil.kelas,
                        style: tema.textTheme.bodySmall?.copyWith(
                          color: skema.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  tooltip: 'Hapus deteksi',
                  onPressed: onHapus,
                  icon: Icon(
                    Icons.delete_outline,
                    color: skema.error,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Label status deteksi
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: warnaStatus.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: warnaStatus.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    ikonStatus,
                    size: 17,
                    color: warnaStatus,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    hasil.status,
                    style: TextStyle(
                      color: warnaStatus,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Skor deteksi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Skor Deteksi',
                  style: tema.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${hasil.skor}%',
                  style: tema.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: skema.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (hasil.skor / 100).clamp(0.0, 1.0),
                minHeight: 10,
                backgroundColor: skema.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(
                  warnaStatus,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Rekomendasi penanganan
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: skema.secondaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.tips_and_updates_outlined,
                    color: skema.onSecondaryContainer,
                    size: 22,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rekomendasi Penanganan',
                          style: tema.textTheme.labelLarge?.copyWith(
                            color: skema.onSecondaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          hasil.rekomendasi,
                          style: tema.textTheme.bodyMedium?.copyWith(
                            color: skema.onSecondaryContainer,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Divider(
              color: skema.outlineVariant,
            ),

            const SizedBox(height: 8),

            // Petugas dan waktu deteksi
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 17,
                  color: skema.onSurfaceVariant,
                ),

                const SizedBox(width: 6),

                Expanded(
                  child: Text(
                    hasil.namaPetugas,
                    style: tema.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(width: 8),

                Icon(
                  Icons.schedule,
                  size: 17,
                  color: skema.onSurfaceVariant,
                ),

                const SizedBox(width: 5),

                Text(
                  tanggal,
                  style: tema.textTheme.labelSmall?.copyWith(
                    color: skema.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
