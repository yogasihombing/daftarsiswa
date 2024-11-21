import 'package:daftar_siswa2/repository.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class TambahSiswa extends StatefulWidget {
  const TambahSiswa({super.key});

  @override
  State<TambahSiswa> createState() => _TambahSiswaState();
}

class _TambahSiswaState extends State<TambahSiswa> {
  Repository repository = Repository();
  final _nisController =
      TextEditingController(); // ini adalah imput textnya si title
  final _namaController = TextEditingController();
  final _jenis_kelaminController = TextEditingController();
  final _teleponController = TextEditingController();
  final _alamatController = TextEditingController();
  // controller untuk mendapatkan isi dari textfieldnya

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => {Navigator.of(context).popAndPushNamed('/home')},
          ),
          title: Text('Tambah Siswa'),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                TextField(
                  controller: _nisController,
                  decoration: InputDecoration(hintText: 'nis'),
                ),
                TextField(
                  controller: _namaController,
                  decoration: InputDecoration(hintText: 'nama'),
                ),
                TextField(
                  controller: _jenis_kelaminController,
                  decoration: InputDecoration(hintText: 'Jenis Kelamin'),
                ),
                TextField(
                  controller: _teleponController,
                  decoration: InputDecoration(hintText: 'Telepon'),
                ),
                TextField(
                  controller:
                      _alamatController, // untuk mendapatkan data isi velue
                  decoration: InputDecoration(hintText: 'Alamat'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      bool response = await repository.postData(
                          _nisController.text,
                          _namaController.text,
                          _jenis_kelaminController.text,
                          _teleponController.text,
                          _alamatController.text);

                      if (response) {
                        Navigator.of(context).popAndPushNamed('/home');
                      } else {
                        print("Post Data Gagal");
                      } // untuk menambahkan datanya kehalaman home
                    },
                    // variabel untuk menamkap respons data
                    child: Text('Simpan')),
                // ini akan mengarahkan ke home
              ],
            ),
          ),
        ));
  }
}
