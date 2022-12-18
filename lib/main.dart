import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:web_slider/controller/conts.dart';
import 'package:web_slider/controller/information_controller.dart';
import 'package:web_slider/model/information_model.dart';
import 'package:web_slider/widgets/arrow_bitton.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Slider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final data = InformationController();
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    for (var _ in data.data) {
      progress.add(0.0);
    }
    _watchingProgress();
  }

  @override
  void dispose() {
    super.dispose();
    t!.cancel();
  }

  _watchingProgress() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        if (progress[currentIndex] + 0.01 < 1) {
          progress[currentIndex] += 0.01;
        } else {
          progress[currentIndex] = 1;
          timer.cancel();
          pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.decelerate);
          if (currentIndex < data.data.length - 1) {
            currentIndex++;
            _watchingProgress();
          } else {
            for (var _ in data.data) {
              progress.add(0.0);
            }
            _watchingProgress();
          }
        }
      });
    });
  }

  void previousSlide() {
    if (currentIndex > 0) {
      progress[currentIndex - 1] = 0;
      progress[currentIndex] = 0;
      currentIndex--;
      pageController.previousPage(duration: Duration(milliseconds: 200), curve: Curves.decelerate);
    }
  }

  void nextSlide() {
    if (currentIndex < data.data.length - 1) {
      progress[currentIndex] = 1;
      currentIndex++;
      pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.decelerate);
    } else {
      progress[currentIndex] = 1;
      t!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 400,
          width: 700,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Color(0xff4D2C2F), Color(0xff2C293F)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.decal,
                  ),
                ),
              ),
              Positioned(
                top: positionTop,
                left: positionLeft,
                right: positionRight,
                child: TimerBar(data: data.data, percentage: progress),
              ),
              Positioned(
                top: positionTop + 20,
                left: 0,
                right: 0,
                bottom: positionBottom + 10,
                child: InformationLayout(
                    data: data.data,
                    previousArrowEvent: previousSlide,
                    nextArrowEvent: nextSlide,
                    pageController: pageController),
              ),
              Positioned(
                top: positionTop + 20,
                left: positionLeft + 10,
                child: PlayPause(
                  startStop: () {
                    // _watchingProgress();
                    // if (t!.isActive == false) {
                    // } else {
                    //   t!.cancel();
                    // }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InformationLayout extends StatefulWidget {
  final Function() previousArrowEvent;
  final Function() nextArrowEvent;
  final List<InformationModel> data;
  final PageController pageController;
  const InformationLayout({
    Key? key,
    required this.previousArrowEvent,
    required this.nextArrowEvent,
    required this.data,
    required this.pageController,
  }) : super(key: key);

  @override
  State<InformationLayout> createState() => _InformationLayoutState();
}

class _InformationLayoutState extends State<InformationLayout> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: Row(
        children: [
          ArrowButton(
            isHover: isHover,
            icon: Icons.chevron_left,
            onTap: widget.previousArrowEvent,
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: PageView.builder(
              itemCount: widget.data.length,
              controller: widget.pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (v) {
                setState(() {});
              },
              itemBuilder: (context, i) {
                return InformationCardTile(data: widget.data[i]);
              },
            ),
          ),
          const SizedBox(width: 5.0),
          ArrowButton(
            isHover: isHover,
            icon: Icons.chevron_right,
            onTap: widget.nextArrowEvent,
          ),
        ],
      ),
    );
  }
}

class InformationCardTile extends StatefulWidget {
  final InformationModel data;
  const InformationCardTile({Key? key, required this.data}) : super(key: key);

  @override
  State<InformationCardTile> createState() => _InformationCardTileState();
}

class _InformationCardTileState extends State<InformationCardTile> {
  bool linkHover = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.title.toString(),
                style: TextStyle(
                  color: Colors.white,
                  height: 1.3,
                  fontSize: 18,
                  wordSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.fade,
              ),
              const SizedBox(height: 50.0),
              Row(
                children: [
                  Text(
                    'Lear More:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  MouseRegion(
                    onEnter: (event) {
                      setState(() {
                        linkHover = true;
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        linkHover = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(horizontal: linkHover ? 12 : 10, vertical: linkHover ? 7 : 5),
                      decoration: BoxDecoration(
                        color: linkHover ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 0.5),
                      ),
                      child: Text(
                        widget.data.sourceUrl.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: GridView.custom(
              gridDelegate: SliverStairedGridDelegate(
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                startCrossAxisDirectionReversed: true,
                pattern: [
                  StairedGridTile(0.5, 1),
                  StairedGridTile(0.5, 1),
                  StairedGridTile(0.5, 1),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                  (context, i) => InfoImages(imagesData: widget.data.imagesData![i]),
                  childCount: widget.data.imagesData!.length),
            ),
          ),
        )
      ],
    );
  }
}

class InfoImages extends StatefulWidget {
  final ListOfImages imagesData;
  const InfoImages({Key? key, required this.imagesData}) : super(key: key);

  @override
  State<InfoImages> createState() => _InfoImagesState();
}

class _InfoImagesState extends State<InfoImages> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.imagesData.imageUrl.toString(),
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(horizontal: isHover ? 12 : 10, vertical: isHover ? 7 : 5),
            decoration: BoxDecoration(
              color: isHover ? Colors.black.withOpacity(0.3) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: isHover
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.imagesData.source.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Icon(
                        Icons.ads_click,
                        color: Colors.white,
                        size: 15,
                      )
                    ],
                  )
                : SizedBox(),
          )
        ],
      ),
    );
  }
}

class TimerBar extends StatefulWidget {
  final List<InformationModel> data;
  final List<double> percentage;
  const TimerBar({
    Key? key,
    required this.data,
    required this.percentage,
  }) : super(key: key);

  @override
  State<TimerBar> createState() => _TimerBarState();
}

class _TimerBarState extends State<TimerBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < widget.data.length; i++)
          Expanded(
            child: LinearPercentIndicator(
              progressColor: Colors.white,
              backgroundColor: Colors.white.withOpacity(0.5),
              lineHeight: 5,
              percent: widget.percentage[i],
              barRadius: const Radius.circular(50.0),
            ),
          )
      ],
    );
  }
}

class PlayPause extends StatefulWidget {
  final Function() startStop;
  final Function(TapDownDetails)? onTapDown;
  const PlayPause({Key? key, required this.startStop, this.onTapDown}) : super(key: key);

  @override
  State<PlayPause> createState() => _PlayPauseState();
}

class _PlayPauseState extends State<PlayPause> with SingleTickerProviderStateMixin {
  bool isPlay = false;
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  void _handleOnPressed() {
    setState(() {
      isPlay = !isPlay;
      isPlay ? _animationController.forward() : _animationController.reverse();
      widget.startStop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTapDown,
      onTap: _handleOnPressed,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: AnimatedIcon(
            icon: AnimatedIcons.pause_play,
            progress: _animationController,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
