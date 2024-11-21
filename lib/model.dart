class Blog {
  final String nis;
  final String nama;
  final String jenis_kelamin;
  final String telp;
  final String alamat;

  Blog(
      {required this.nis,
      required this.nama,
      required this.jenis_kelamin,
      required this.telp,
      required this.alamat});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
        nis: json['nis'],
        nama: json['nama'],
        jenis_kelamin: json['jenis_kelamin'],
        telp: json['telp'],
        alamat: json['alamat']);
  }
}
