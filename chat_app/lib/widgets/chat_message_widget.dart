import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  const ChatMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return Center(
            child: Text('No Message Found ..!'),
          );
        }
        if (chatSnapshots.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }

        final loadedMessage = chatSnapshots.data!.docs;
        return ListView.builder(
            itemCount: loadedMessage.length,
            itemBuilder: (ctx, index) =>
                Text(loadedMessage[index].data()['text']));
      },
    );
  }
}
