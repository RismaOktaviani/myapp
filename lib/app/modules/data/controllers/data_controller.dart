import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DataController extends GetxController {
  //TODO: Implement MahasiswaController
  late TextEditingController hargaBarang;
  late TextEditingController kodeBarang;
  late TextEditingController namaBarang;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> GetData() async {
    CollectionReference barang = firestore.collection('barang_22312071');

    return barang.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference barang = firestore.collection('barang_22312071');
    return barang.snapshots();
  }

  void add(String hargaBarang, String kodeBarang, String namaBarang) async {
    CollectionReference products = firestore.collection("barang_22312071");

    try {
      await products.add({
        "harga_barang": hargaBarang,
        "kode_barang": kodeBarang,
        "nama_barang": namaBarang,
      });
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil menyimpan data barang",
          onConfirm: () {
            // hargaBarang.clear();
            // kodeBarang.clear();
            // namaBarang.clear();
            Get.back();
            Get.back();
            // ignore: unused_label
            textConfirm:
            "OK";
          });
    } catch (e) {
    print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Barang.",
      );
    }
  }

Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef = firestore.collection("barang_22312071").doc(id);

    return docRef.get();
  }

  void Update(String hargaBarang, String kodeBarang, String namaBarang, String id) async {
    DocumentReference barangById = firestore.collection("barang_22312071").doc(id);

    try {
      await barangById.update({
        "harga_barang": hargaBarang,
        "kode_barang": kodeBarang,
        "nama_barang": namaBarang,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil mengubah data Mahasiswa.",
        onConfirm: () {
          // hargaBarang.clear();
            // kodeBarang.clear();
            // namaBarang.clear();
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Barang.",
      );
    }
  }

    void delete(String id) {
    DocumentReference docRef = firestore.collection("barang_22312071").doc(id);

    try {
      Get.defaultDialog(
        title: "Info",
        middleText: "Apakah anda yakin menghapus data ini ?",
        onConfirm: () {
          docRef.delete();
          Get.back();
          Get.defaultDialog(
            title: "Sukses",
            middleText: "Berhasil menghapus data",
          );
        },
        textConfirm: "Ya",
        textCancel: "Batal",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        middleText: "Tidak berhasil menghapus data",
      );
    }
  }



@override
  void onInit() {
    // TODO: implement onInit
    hargaBarang = TextEditingController();
    kodeBarang = TextEditingController();
    namaBarang = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // // TODO: implement onClose
    // hargaBarang.dispose();
    // kodeBarang.dispose();
    // namaBarang.dispose();
    super.onClose();
  }

}
