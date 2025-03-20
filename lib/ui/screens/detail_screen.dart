import 'package:flutter/material.dart';
import 'package:pragma_test/models/responses/breed_response.dart';
import 'package:pragma_test/utils/extensions/color_extension.dart';

class DetailScreen extends StatelessWidget {
  final BreedResponse breed;

  const DetailScreen({
    super.key,
    required this.breed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            breed.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFD26934),
                  Color(0xFFFF9B44),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: AppColor.scaffoldBGColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ClipOval(
                  child: Image.network(
                    'https://cdn2.thecatapi.com/images/${breed.referenceImageId}.jpg',
                    width: size.width * 0.5,
                    height: size.width * 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
      
                      _sectionTitle('Description'),
                      _sectionText(breed.description),
      
                      _sectionTitle('Temperament'),
                      _sectionText(breed.temperament),
      
                      _sectionTitle('Origin'),
                      _sectionText(breed.origin),
      
                      _sectionTitle('Life Span'),
                      _sectionText(breed.lifeSpan),
      
                      _sectionTitle('Adaptability'),
                      _sectionText(breed.adaptability.toString()),
      
                      _sectionTitle('Affection'),
                      _sectionText(breed.affectionLevel.toString()),
      
                      _sectionTitle('Child Friendly'),
                      _sectionText(breed.childFriendly.toString()),
      
                      _sectionTitle('Dog Friendly'),
                      _sectionText(breed.dogFriendly.toString()),
      
                      _sectionTitle('Energy Level'),
                      _sectionText(breed.energyLevel.toString()),
      
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 6),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _sectionText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
    );
  }
}