import 'dart:math';
import 'package:flutter/material.dart';
import '../models/hasil_deteksi.dart';
import '../models/rekomendasi.dart';

class DeteksiModel extends ChangeNotifier {
  final List<HasilDeteksi> _data = [];

  List<HasilDeteksi> get data => _data;

  int get total => _data.length;

  int get jumlahSehat =>
      _data.where((d) => d.status == 'Sehat').length;

  int get jumlahTindakan =>
      _data.where((d) => d.status == 'Perlu Tindakan').length;

  void tambahData(HasilDeteksi hasil) {
    _data.add(hasil);
    notifyListeners();
  }

  void hapusData(HasilDeteksi hasil) {
    _data.remove(hasil);
    notifyListeners();
  }

  void hapusSemua() {
    _data.clear();
    notifyListeners();
  }

  List<HasilDeteksi> filterPetak(String petak) {
    if (petak == 'Semua') {
      return _data;
    }
    return _data.where((d) => d.petak == petak).toList();
  }

  Map<String, int> get jumlahPerKelas {
    final hasil = <String, int>{};
    for (final kelas in rekomendasiKelas.keys) {
      hasil[kelas] = _data.where((d) => d.kelas == kelas).length;
    }
    return hasil;
  }

  void buatDataSimulasi() {
    final random = Random();
    final kelasList = rekomendasiKelas.keys.toList();
    final petakList = ['Petak 1', 'Petak 2'];

    final dataBaru = List.generate(10, (index) {
      return HasilDeteksi(
        petak: petakList[random.nextInt(2)],
        kelas: kelasList[random.nextInt(kelasList.length)],
        skor: 30 + random.nextInt(70),
        namaPetugas: 'Petugas ${index + 1}',
        waktu: DateTime.now(),
      );
    });

    _data.addAll(dataBaru);
    notifyListeners();
  }
}