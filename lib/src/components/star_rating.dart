import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../theme/theme.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double starSize;
  final int? numberOfRatings; // Optional field for number of ratings

  const StarRating({super.key, required this.rating, this.starSize = 24.0, this.numberOfRatings});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    List<Widget> stars = List.generate(5, (index) {
      if (index < fullStars) {
        return Icon(Icons.star_rounded, color: Colors.amber, size: starSize);
      } else if (index == fullStars && hasHalfStar) {
        return Icon(Icons.star_half_rounded, color: Colors.amber, size: starSize);
      } else {
        return Icon(Icons.star_border_rounded, color: Colors.amber, size: starSize);
      }
    });

    return Row(
      children: [
        ...stars,
              if (numberOfRatings == null) 
                Text(
                  ' (${rating.toStringAsFixed(1)})',
                  style: TextStyle(fontSize: starSize * 0.5),
                ) 
              else 
                Text(
                  ' ($numberOfRatings ratings)',
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).themeData == darkMode ? Colors.lightBlue[200] : Colors.blue,
                    fontSize: starSize * 0.5,
                  ),
                ),
            ],
     );
  }
}
