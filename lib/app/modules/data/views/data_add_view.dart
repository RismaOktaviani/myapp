import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/data_controller.dart';

class DataAddView extends GetView<DataController> {
  const DataAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Barang'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.namaBarang,
              decoration: const InputDecoration(
                labelText: "Nama Barang",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.kodeBarang,
              decoration: const InputDecoration(
                labelText: "Kode Barang",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.hargaBarang,
              decoration: const InputDecoration(
                labelText: "Harga Barang",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (controller.namaBarang.text.isNotEmpty &&
                    controller.kodeBarang.text.isNotEmpty &&
                    controller.hargaBarang.text.isNotEmpty) {
                  controller.add(
                    controller.hargaBarang.text,
                    controller.kodeBarang.text,
                    controller.namaBarang.text,
                  );
                } else {
                  Get.defaultDialog(
                    title: "Error",
                    middleText: "Semua field harus diisi.",
                  );
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
