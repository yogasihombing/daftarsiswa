import 'package:daftar_siswa2/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdateSiswa extends StatefulWidget {
  const UpdateSiswa({super.key});

  @override
  State<UpdateSiswa> createState() => _UpdateSiswaState();
}

class _UpdateSiswaState extends State<UpdateSiswa> {
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
    final args = ModalRoute.of(context)?.settings.arguments
        as List<String>; //untuk memanggil data yang mau di update
    if (args[0].isNotEmpty) {
      _nisController.text = args[0];
    }
    if (args[1].isNotEmpty) {
      _namaController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      _jenis_kelaminController.text = args[2];
    }
    if (args[3].isNotEmpty) {
      _teleponController.text = args[3];
    }
    if (args[4].isNotEmpty) {
      _alamatController.text = args[4];
    }
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => {Navigator.of(context).popAndPushNamed('/home')},
          ),
          title: Text('Update Siswa'),
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
                      bool response = await repository.updateData(
                        args[0],
                        _namaController.text,
                        _jenis_kelaminController.text,
                        _teleponController.text,
                        _alamatController.text,
                      );

                      if (response) {
                        Navigator.of(context).popAndPushNamed('/home');
                      } else {
                        print("Update Data Gagal");
                      } // untuk menambahkan datanya kehalaman home
                    },
                    // variabel untuk menamkap respons data
                    child: Text('Update Data Siswa')),
                // ini akan mengarahkan ke home
              ],
            ),
          ),
        ));
  }
}
