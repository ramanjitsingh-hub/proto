import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proto/add_prod.dart'; // For formatting the date

class FarmerScreen extends StatefulWidget {
  const FarmerScreen({super.key});

  @override
  State<FarmerScreen> createState() => _FarmerScreenState();
}

class _FarmerScreenState extends State<FarmerScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    QuerySnapshot querySnapshot = await _firestore.collection('products').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  String formatDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat.yMMMd().add_jm().format(date); // Formatting the date
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.green[800]!,
                Colors.green[400]!,
              ],
            ),
          ),
          child: Center(
            child: Text(
              'Farmer',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Add_prod();
            }));
          },
          child: Container(
            height: 75,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green[700]!,
                  Colors.green[400]!,
                ],
              ),
            ),
            child: Center(
                child: Text(
              "Add Products",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 2,
        ),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No products found.');
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var product = snapshot.data![index];
                    var timestamp = product['doo'];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.green[100],
                        title: Text(
                          product['productName'],
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        subtitle: Text(
                          'Date of Harvest : $timestamp, \n' +
                              'Origin : ${product['origin']}, \n' +
                              'Farming Practices : ${product['farmingPractices']}, \n' +
                              'Farm : ${product['farm']}', // Displaying the product details
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ]),
    );
  }
}
