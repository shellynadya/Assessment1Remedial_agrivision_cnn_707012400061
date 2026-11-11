import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../state/deteksi_model.dart';

class HalamanStatistik extends StatelessWidget {
  const HalamanStatistik({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    final model = context.watch<DeteksiModel>();
    final statistik = model.jumlahPerKelas;
    final kelas = statistik.keys.toList();

    final nilai = kelas
        .map((nama) => statistik[nama] ?? 0)
        .toList();

    final nilaiTertinggi = nilai.isEmpty
        ? 0
        : nilai.reduce(math.max);

    final batasGrafik =
        math.max(5, nilaiTertinggi + 2).toDouble();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        // Header Statistik
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
                Icons.bar_chart_rounded,
                size: 38,
                color: Colors.white,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Statistik Deteksi',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Analisis jumlah hasil deteksi '
                      'berdasarkan kelas penyakit padi.',
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

        const SizedBox(height: 24),

        // Ringkasan jumlah data
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: warna.primaryContainer,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.analytics_outlined,
                    size: 28,
                    color: warna.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Hasil Deteksi',
                        style: tema.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${model.total} Data',
                        style:
                            tema.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: warna.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 26),

        Text(
          'Jumlah Deteksi per Kelas',
          style: tema.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              12, 24, 16, 18,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 290,
                  child: BarChart(
                    BarChartData(
                      minY: 0,
                      maxY: batasGrafik,

                      alignment:
                          BarChartAlignment.spaceAround,

                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: warna.outlineVariant,
                            strokeWidth: 1,
                          );
                        },
                      ),

                      borderData: FlBorderData(
                        show: false,
                      ),

                      barGroups: List.generate(
                        kelas.length,
                        (index) {
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: nilai[index].toDouble(),
                                width: 24,
                                color: warna.primary,
                                borderRadius:
                                    BorderRadius.circular(6),
                              ),
                            ],
                          );
                        },
                      ),

                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),

                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),

                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              if (value != value.roundToDouble()) {
                                return const SizedBox();
                              }

                              return Text(
                                '${value.toInt()}',
                                style:
                                    tema.textTheme.labelSmall,
                              );
                            },
                          ),
                        ),

                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 35,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();

                              if (index < 0 ||
                                  index >= kelas.length) {
                                return const SizedBox();
                              }

                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                ),
                                child: Text(
                                  'K${index + 1}',
                                  style: tema.textTheme.labelSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'Grafik diperbarui otomatis '
                  'berdasarkan data yang tersimpan.',
                  style: tema.textTheme.bodySmall?.copyWith(
                    color: warna.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        Text(
          'Keterangan Kelas',
          style: tema.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: List.generate(
              kelas.length,
              (index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            warna.primaryContainer,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: warna.onPrimaryContainer,
                          ),
                        ),
                      ),
                      title: Text(
                        'K${index + 1} - ${kelas[index]}',
                      ),
                      trailing: Text(
                        '${nilai[index]}',
                        style: tema.textTheme.titleMedium
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    if (index < kelas.length - 1)
                      const Divider(height: 1),
                  ],
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 24),

        if (model.total == 0)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: warna.secondaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              'Belum ada data deteksi. '
              'Buka Pengaturan dan tekan '
              'Muat Data Simulasi untuk melihat grafik.',
              style: TextStyle(
                color: warna.onSecondaryContainer,
              ),
            ),
          ),
      ],
    );
  }
}
