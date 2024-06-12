import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    List<Widget> stars = List.generate(5, (index) {
      if (index < fullStars) {
        return const Icon(Icons.star_rounded, color: Colors.amber);
      } else if (index == fullStars && hasHalfStar) {
        return const Icon(Icons.star_half_rounded, color: Colors.amber);
      } else {
        return const Icon(Icons.star_border_rounded, color: Colors.amber);
      }
    });

    return Row(
      children: [
        ...stars,
        Text(' (${rating.toStringAsFixed(1)})'),
      ],
    );
  }
}
