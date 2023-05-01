import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/add_image.dart';
import 'package:firebase_crud/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
            title: Row(
          children: [
            Text('HomePage'),
            SizedBox(
              width: 35,
            ),

            // for logut button
            MaterialButton(
              onPressed: () {
                setState(() {});
              },
              color: Colors.deepOrange,
              child: Text(
                'Refresh',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                color: Colors.deepOrange,
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        )),
        //for adding the floating action button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddImage()));
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: storage.downloadURL(),
          builder: (BuildContext context, AsyncSnapshot<Set> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return ListView.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 300,
                        height: 250,
                        child: Image.network(
                          snapshot.data!.elementAt(index),
                          fit: BoxFit.cover,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  });
            }
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                  color: Colors.white,
                ),
              );
            }
            return Container();
          },
        ));
  }
}
