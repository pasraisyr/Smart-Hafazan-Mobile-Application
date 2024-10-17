part of '../home_screen.dart';

class _AyahBottom extends StatelessWidget {
  const _AyahBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "“Bacalah al-Quran kerana sesungguhnya \n ia akan datang pada hari Kiamat\n sebagai syafaat kepada para pembacanya.”\n\n\n",
            textAlign: TextAlign.center,
            style: AppText.b2!.copyWith(
              color: AppTheme.c!.text,
            ),
          ),
          Space.y!,
          Text(
            " [Riwayat Muslim (804)]\n\n",
            style: AppText.l1!.copyWith(
              color: AppTheme.c!.text,
            ),
          ),
        ],
      ),
    );
  }
}
