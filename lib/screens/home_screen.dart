import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:webtoon/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true, // 안드로이드는 중앙정렬 되지만 ios 중앙정렬 안될 수 있음
        elevation: 2, // 상단 바 밑에 그림자 주기
        backgroundColor: Colors.white, // 배경 색
        foregroundColor: Colors.green, // 글씨 색
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500, // 폰트 두께
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          //snapsht 은 바로 위의 future 의 상태
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ); // scaffold는 screen을 위한 기본적인 레이아웃과 설정을 제공함.
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index]; // 보여지는 것만 불러옴
        return Webtoon(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
      },
      separatorBuilder: (context, index) => const SizedBox(
          // title 사이의 공간 구분 해줌
          width: 40),
    );
  }
}
