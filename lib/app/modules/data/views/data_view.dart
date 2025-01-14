import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/data_controller.dart';
import '../views/data_add_view.dart';
import '../views/data_update_view.dart';

class DataView extends GetView<DataController> {
  void showAddDialog() async {
    await Get.dialog(
      SimpleDialog(
        title: const Text('Tambah Data Barang'),
        children: [
          ListTile(
            onTap: () {
              Get.back();
              Get.to(() => const DataAddView()); // Navigasi ke halaman tambah data
            },
            title: const Text('Tambah Barang Baru'),
          ),
          ListTile(
            onTap: () => Get.back(),
            title: const Text('Close'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void showOption(String id) async {
    await Get.dialog(
      SimpleDialog(
        title: const Text('Opsi Data Barang'),
        children: [
          ListTile(
            onTap: () {
              Get.back();
              Get.to(
                const DataUpdateView(),
                arguments: id, // Kirim ID barang untuk diupdate
              );
            },
            title: const Text('Update'),
          ),
          ListTile(
            onTap: () {
              Get.back();
              Get.put(DataController()).delete(id); // Hapus data
            },
            title: const Text('Delete'),
          ),
          ListTile(
            onTap: () => Get.back(),
            title: const Text('Close'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Barang'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: showAddDialog, // Tampilkan dialog tambah
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: Get.put(DataController()).streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDocs = snapshot.data?.docs ?? [];
            return listAllDocs.isNotEmpty
                ? ListView.builder(
                    itemCount: listAllDocs.length,
                    itemBuilder: (context, index) {
                      var data =
                          listAllDocs[index].data() as Map<String, dynamic>;
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                          backgroundColor:
                              const Color.fromARGB(255, 248, 248, 248),
                        ),
                        title: Text("${data["nama_barang"] ?? 'Tidak Ada'}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Kode: ${data["kode_barang"] ?? 'Tidak Ada'}"),
                            Text("Harga: ${data["harga_barang"] ?? 'Tidak Ada'}"),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () => showOption(listAllDocs[index].id),
                          icon: const Icon(Icons.more_vert),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("Data Kosong"),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
