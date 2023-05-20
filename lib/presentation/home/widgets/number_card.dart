import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';

class NumberCard extends StatelessWidget {
  final int index;
  const NumberCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 200,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 130,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: kRadius10,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/xjsx6rGEgHl2tUqkimo6Bz2KzVo.jpg"),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 13,
          bottom: -30,
          child: BorderedText(
            strokeColor: kWhiteColor,
            strokeWidth: 10.0,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                  color: kBlackColor,
                  decoration: TextDecoration.none,
                  decorationColor: kBlackColor,
                  fontSize: 150,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
    ;
  }
}
