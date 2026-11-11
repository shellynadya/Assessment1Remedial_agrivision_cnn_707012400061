import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/deteksi_model.dart';
import 'halaman_beranda.dart';
import 'halaman_riwayat_deteksi.dart';
import 'halaman_statistik.dart';
import 'halaman_pengaturan.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() =>
      _KerangkaNavigasiState();
}

class _KerangkaNavigasiState
    extends State<KerangkaNavigasi> {
  int indeks = 0;

  final List<String> judul = const [
    'Beranda',
    'Deteksi',
    'Statistik',
    'Pengaturan',
  ];

  final List<Widget> halaman = const [
    HalamanBeranda(),
    HalamanRiwayatDeteksi(),
    HalamanStatistik(),
    HalamanPengaturan(),
  ];

  @override
  Widget build(BuildContext context) {
    final jumlahTindakan =
        context.watch<DeteksiModel>().jumlahTindakan;

    return Scaffold(
      appBar: AppBar(
        title: Text('AgriVision - ${judul[indeks]}'),
      ),

      body: IndexedStack(
        index: indeks,
        children: halaman,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: indeks,
        onDestinationSelected: (nilai) {
          setState(() {
            indeks = nilai;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),

          NavigationDestination(
            icon: Badge(
              isLabelVisible: jumlahTindakan > 0,
              label: Text('$jumlahTindakan'),
              child: const Icon(Icons.search_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: jumlahTindakan > 0,
              label: Text('$jumlahTindakan'),
              child: const Icon(Icons.search),
            ),
            label: 'Deteksi',
          ),

          const NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),

          const NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
