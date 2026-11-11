import 'rekomendasi.dart';

class HasilDeteksi {
  final String petak;
  final String kelas;
  final int skor;
  final String namaPetugas;
  final DateTime waktu;

  HasilDeteksi({
    required this.petak,
    required this.kelas,
    required this.skor,
    required this.namaPetugas,
    required this.waktu,
  });

  String get status {
    if (kelas == 'Normal / Sehat') {
      return 'Sehat';
    } else if (skor < 50) {
      return 'Tidak Pasti';
    } else {
      return 'Perlu Tindakan';
    }
  }

  String get rekomendasi {
    if (status == 'Sehat') {
      return 'Lanjutkan pemantauan rutin';
    } else if (status == 'Tidak Pasti') {
      return 'Cek ulang oleh petugas';
    } else {
      return 'Segera tangani. ${rekomendasiKelas[kelas] ?? ''}';
    }
  }
}