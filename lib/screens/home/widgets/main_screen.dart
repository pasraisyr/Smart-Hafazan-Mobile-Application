part of '../home_screen.dart';

class _MainScreen extends StatelessWidget {
  const _MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    App.init(context);
    final appProvider = Provider.of<AppProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: appProvider.isDark ? Colors.grey[850] : Colors.white,
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const AppName(),
            const Calligraphy(),
            const QuranRail(),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Space.y1!,
                  AppButton(
                    title: 'Mula Hafal',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.hafalsurahs),
                  ),
                  Space.y1!,
                  AppButton(
                    title: 'Baca Surah',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.surah),
                  ),
                  Space.y1!,
                  AppButton(
                    title: 'Prestasi',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.dashboard),
                  ),               
                ],
              ),
            ),
            const _AyahBottom(),
          ],
        ),
      ),
    );
  }
}
