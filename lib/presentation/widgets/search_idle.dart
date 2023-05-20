import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/search/search_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/widgets/title.dart';

class SearchIdleWidget extends StatelessWidget {
  const SearchIdleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchTextTitle(title: "Top Searches"),
          kHeight,
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return const Center(child: Text("Error while getting data"));
              } else if (state.idleList.isEmpty) {
                return const Center(
                  child: Text("List is empty"),
                );
              }
              return Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      final movie = state.idleList[index];
                      return TopSearchItemTile(
                        title: movie.title ?? "No title Provided",
                        imageUrl: "$appendImageUrl${movie.posterPath}",
                      );
                    },
                    separatorBuilder: (ctx, index) => kHeight20,
                    itemCount: state.idleList.length),
              );
            },
          )
        ],
      ),
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItemTile(
      {super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          height: 65,
          width: screenWidth * 0.35,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        kWidth,
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: kWhiteColor),
          ),
        ),
        const CircleAvatar(
          backgroundColor: kWhiteColor,
          radius: 27,
          child: CircleAvatar(
            backgroundColor: kBlackColor,
            radius: 25,
            child: Icon(
              CupertinoIcons.play_fill,
              color: kWhiteColor,
            ),
          ),
        )
      ],
    );
  }
}
