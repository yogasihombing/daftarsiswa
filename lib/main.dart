// import 'dart:js';

import 'package:daftar_siswa2/model.dart';
import 'package:daftar_siswa2/repository.dart';
import 'package:daftar_siswa2/tambah-siswa.dart';
import 'package:daftar_siswa2/update-siswa.dart';
import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Siswa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => MyHomePage(title: 'Daftar Siswa'),
        '/tambah-siswa': (context) => TambahSiswa(),
        'Update': (context) => UpdateSiswa() //untuk menerapkan navigasinya
      },
      home: MyHomePage(title: 'Daftar Siswa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Blog> listBlog = [];
  Repository repository = Repository();

  getData() async {
    //ini untuk menampilkan kembali data nya, langsung refresh page
    listBlog = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add), // icon button untuk input navigasinya
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/tambah-siswa'),
          )
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listBlog[index].nama,
                        ),
                        Text(
                          listBlog[index].nis,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: 55,
                        child: Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                          color: Colors.blue,
                          onPressed: () async {
                            Navigator.popAndPushNamed(context, 'Update',
                                arguments: [
                                  listBlog[index].nis,
                                  listBlog[index].nama,
                                  listBlog[index].jenis_kelamin,
                                  listBlog[index].telp,
                                  listBlog[index].alamat
                                ]);
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          color: Colors.red,
                          onPressed: () async {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Hapus Data'),
                                    content: Text(
                                        'Peringatan: Data yang di pilih akan di hapus secara permanent.'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: Text('Batal')),
                                      TextButton(
                                          onPressed: () async {
                                            bool response =
                                                await repository.deleteData(
                                                    listBlog[index].nis);
                                            if (response) {
                                              Navigator.pop(context, true);
                                            } else {
                                              Navigator.pop(context, false);
                                            }
                                            getData();
                                          },
                                          child: Text('Ya'))
                                    ],
                                  );
                                });
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: listBlog.length),
    );
  }
}
