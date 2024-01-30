import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:sample/db_manager.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  bool isListVisible = false;
  late FirebaseFirestore db;
  late Reference storageRef;

  @override
  void initState() {
    db = FirebaseFirestore.instance;
    storageRef = FirebaseStorage.instance.ref();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: db.collection("waiting_help").snapshots(),
            builder: (context, snapshot) {
              return Stack(
                children: [
                  FlutterMap(
                    options: const MapOptions(
                      initialCenter:
                          LatLng(45.01591920165998, 78.38373502487535),
                      initialZoom: 12.2,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: snapshot.data != null
                            ? snapshot.data!.docs
                                .map(
                                  (doc) => Marker(
                                    point:
                                        LatLng(doc.get('lat'), doc.get('lon')),
                                    width: 60,
                                    height: 60,
                                    child: GestureDetector(
                                      onTap: () {
                                        log('Babulya');
                                      },
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                        child: FutureBuilder(
                                            future: DBManager().getData(doc.id),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError) {
                                                return const Text(
                                                  "Something went wrong",
                                                );
                                              }
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                log(snapshot.data.toString());
                                                return Image.network(
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (context, object, s) {
                                                    return const Icon(
                                                      Iconsax.image,
                                                      color: Colors.white,
                                                    );
                                                  },
                                                  height: 64,
                                                  width: 64,
                                                  snapshot.data.toString(),
                                                );
                                              }
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }),
                                      ),
                                    ),
                                  ),
                                )
                                .toList()
                            : [],
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isListVisible,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[50]),
                      child: ListView.builder(
                          itemCount: snapshot.data?.docs.length ?? 0,
                          itemBuilder: (context, index) {
                            return _card(snapshot.data?.docs[index]);
                          }),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24, left: 16),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isListVisible = !isListVisible;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              color: Colors.amber,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Text(isListVisible ? 'Map' : 'List'),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }));
  }

  _card(QueryDocumentSnapshot? doc) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(doc!.get('name')), Text(doc.get('address'))],
                ),
                FutureBuilder(
                    future: DBManager().getData(doc.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text(
                          "Something went wrong",
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        log(snapshot.data.toString());
                        return Image.network(
                          errorBuilder: (context, object, s) {
                            return const Icon(Iconsax.image);
                          },
                          height: 64,
                          width: 64,
                          fit: BoxFit.cover,
                          snapshot.data.toString(),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    })
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              doc.get('description'),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [Text('Grocceries')],
                  ),
                  const Text('April'),
                  const PrimerProgressBar(segments: [
                    Segment(
                        value: 80, color: Colors.purple, label: Text("Food")),
                    Segment(
                        value: 20, color: Colors.amber, label: Text("Cloth"))
                  ]),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(12)),
                      alignment: Alignment.center,
                      child: const Text(
                        'To help',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
