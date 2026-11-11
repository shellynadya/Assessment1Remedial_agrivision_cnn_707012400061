import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String judul;
  final int jumlah;
  final IconData ikon;
  final Color warna;

  const StatCard({
    super.key,
    required this.judul,
    required this.jumlah,
    required this.ikon,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final skema = tema.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 118,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 6,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: warna.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                ikon,
                color: warna,
                size: 24,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              '$jumlah',
              style: tema.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: skema.onSurface,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              judul,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: tema.textTheme.labelSmall?.copyWith(
                color: skema.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
