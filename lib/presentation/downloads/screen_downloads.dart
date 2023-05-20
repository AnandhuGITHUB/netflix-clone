import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/downloads/downloads_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  const ScreenDownloads({super.key});

  final _widgetList = const [_SmartDownloads(), _Section2(), _Section3()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarWidget(
          title: "Downloads",
        ),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext ctx, int index) => _widgetList[index],
          separatorBuilder: (BuildContext ctx, int index) => const SizedBox(
                height: 25,
              ),
          itemCount: _widgetList.length),
    );
  }
}

class _Section2 extends StatelessWidget {
  const _Section2({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });

    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        const Text(
          "Introducing Downloads for you",
          style: TextStyle(
              color: kWhiteColor, fontSize: 23, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        kHeight,
        const Text(
          "We will download a personalized selection of\nmovies and shows for you, so there's always something to watch on your\ndevice",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        kHeight,
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            return SizedBox(
              width: size.width,
              height: size.width,
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(.5),
                            radius: size.width * 0.4,
                          ),
                        ),
                        DownloadsImageWidget(
                          imageUrl:
                              "$appendImageUrl${state.downloads[0].posterPath}",
                          padding: const EdgeInsets.only(left: 170, top: 50),
                          angle: 25,
                          size: Size(size.width * 0.35, size.width * 0.55),
                        ),
                        DownloadsImageWidget(
                          imageUrl:
                              "$appendImageUrl${state.downloads[1].posterPath}",
                          padding: const EdgeInsets.only(right: 170, top: 50),
                          angle: -25,
                          size: Size(size.width * 0.35, size.width * 0.55),
                        ),
                        DownloadsImageWidget(
                          imageUrl:
                              "$appendImageUrl${state.downloads[2].posterPath}",
                          padding: const EdgeInsets.only(bottom: 20, top: 50),
                          size: Size(size.width * 0.4, size.width * 0.6),
                        )
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}

class _Section3 extends StatelessWidget {
  const _Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: kButtonColorBlue,
            onPressed: () {},
            child: const Text(
              "Set up",
              style: TextStyle(
                color: kWhiteColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        kHeight,
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          color: kButtonColorWhite,
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "See What You Can Download",
              style: TextStyle(
                color: kBlackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.settings,
          color: kWhiteColor,
        ),
        kWidth,
        Text("Smart Downloads")
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget({
    super.key,
    required this.imageUrl,
    this.angle = 0,
    required this.padding,
    required this.size,
  });
  final String imageUrl;
  final double angle;
  final EdgeInsets padding;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: kBlackColor,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}
