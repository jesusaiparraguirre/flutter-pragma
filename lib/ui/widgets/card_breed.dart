import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:pragma_test/utils/extensions/color_extension.dart';

class CardBreed extends StatelessWidget {
  final String name;
  final String origin;
  final String description;
  final int intelligence;
  final String imageId;
  
    const CardBreed({
      super.key, 
      required this.name, 
      required this.origin, 
      required this.description, 
      required this.intelligence,
      required this.imageId
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               ClipOval(
                child: CachedNetworkImage(
                  imageUrl: 'https://cdn2.thecatapi.com/images/$imageId.jpg',
                  httpHeaders: {
                    'x-api-key': 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'
                  },
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.error, size: 30),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                      text: 'Nombre: ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                      children: [
                        TextSpan(
                          text: name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          )
                        )
                      ]
                    )),
                    RichText(text: TextSpan(
                      text: 'Origen: ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                      children: [
                        TextSpan(
                          text: origin,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          )
                        )
                      ]
                    ))
                  ],
                ),
              )
            ],
          ), 
          SizedBox(height: 18),
          ExpandableText(
            description,
            expandText: 'Leer mas',
            collapseText: 'Leer menos',
            maxLines: 1,
            linkColor: AppColor.primaryColor,
          ),
        ],
      ),
    );
  }
}