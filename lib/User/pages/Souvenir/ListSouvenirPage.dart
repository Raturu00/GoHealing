// File: ListSouvenirPage.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gohealing/User/pages/Detail/Souvenir/DetailSouvenirPage.dart';
import 'package:gohealing/User/pages/Detail/Wisata/DetailWisataPage.dart';
import 'package:gohealing/User/widgets/Card/WidgetCardSouvenir.dart';
import 'package:gohealing/data/DBsouvenir.dart';
import 'package:gohealing/User/pages/ProfilePage/ProfilePage.dart';
import 'package:google_fonts/google_fonts.dart';

class ListSouvenirPage extends StatefulWidget {
  const ListSouvenirPage({Key? key}) : super(key: key);

  @override
  State<ListSouvenirPage> createState() => _ListSouvenirPageState();
}

class _ListSouvenirPageState extends State<ListSouvenirPage> {
  TextEditingController searchC = TextEditingController();
  final DBsouvenir _dbSouvenir = DBsouvenir();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _dbSouvenir.getWisataStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var _data = snapshot.data!.docs;

          return Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * (0.06),
                right: MediaQuery.of(context).size.width * (0.06),
                top: 40),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 80,
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Temukan",
                              style: TextStyle(
                                  fontSize: 24, color: Color(0xFF2839CD)),
                            ),
                            Text(
                              "Souvenir Anda",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                  fontFamily: GoogleFonts.kanit().fontFamily,
                                  height: 1,
                                  color: Color(0xFF2839CD)),
                            ),
                          ],
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://awsimages.detik.net.id/community/media/visual/2019/02/19/42393387-9c5c-4be4-97b8-49260708719e.jpeg?w=600&q=90"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: 75,
                  child: TextField(
                    controller: searchC,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Cari di sini",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      fillColor: Color(0xFF7E88E1),
                      filled: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            30.0), // Atur radius border di sini
                        borderSide: BorderSide.none, // Hilangkan border
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          WidgetCardSouvenir(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailSouvenirPage(
                                    dataSouvenir: _data[index].data(),
                                  ),
                                ),
                              );
                            },
                            judulSouvenir: _data[index]
                                    .data()?["judulSouvenir"]
                                    .toString() ??
                                "",
                            harga:
                                _data[index].data()?["harga"].toString() ?? "",
                            gambar:
                                _data[index].data()?["gambar"].toString() ?? "",
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
