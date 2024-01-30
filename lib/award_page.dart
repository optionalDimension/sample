import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lecle_bubble_timeline/lecle_bubble_timeline.dart';
import 'package:lecle_bubble_timeline/models/timeline_item.dart';

class AwardPage extends StatefulWidget {
  const AwardPage({super.key});

  @override
  State<AwardPage> createState() => _AwardPageState();
}

class _AwardPageState extends State<AwardPage> {
  late FirebaseFirestore db;

  @override
  void initState() {
    db = FirebaseFirestore.instance;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Awards"),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: db.collection("awards").snapshots(),
            builder: (context, snapshot) {
              return Stack(
                children: [
                  BubbleTimeline(
                    bubbleSize: 120,
                    // List of Timeline Bubble Items
                    items: snapshot.data!.docs.map((e) => _card(e)).toList(),

                    stripColor: Colors.teal,
                    dividerCircleColor: Colors.white,
                  )
                ],
              );
            }));
  }

  TimelineItem _card(QueryDocumentSnapshot? doc) {
    return TimelineItem(
      title: doc!.get('title'),
      subtitle: doc.get('description'),
      icon: Text(
        doc.get('point').toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      bubbleColor: Colors.amber,
      titleStyle: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
      subtitleStyle:
          const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      descriptionStyle: const TextStyle(fontSize: 12.0),
    );
  }
}
