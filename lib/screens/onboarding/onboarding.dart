import 'package:smart_hafazan/app_routes.dart';
import 'package:smart_hafazan/configs/app.dart';
import 'package:smart_hafazan/configs/configs.dart';
import 'package:smart_hafazan/providers/onboarding_provider.dart';
import 'package:smart_hafazan/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'widgets/indicator.dart';
part 'widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  List<Widget> pages = [
    const _OnBoardingPage(
      image: StaticAssets.gradLogo,
      text:
          "Smart Hafazan\n\n\"InshaAllah membantu kalian untuk menghafal.\"\n",
    ),
    const _OnBoardingPage(
      image: StaticAssets.ui,
      text:
          "Semoga Allah S.W.T permudahkan segala urusan kita\n\nInilah hasil yang terdaya untuk membantu anda!\n",
    ),
    const _OnBoardingPage(
      image: StaticAssets.easyNav,
      text:
          "Anda juga boleh membaca Al-Quran di applikasi ini\n\nBacalah Al-Quran walaupun sebaris ayat sehari :)\n",
    ),
    const _OnBoardingPage(
      image: StaticAssets.drawer3d,
      text:
          "Selamat menghafal sahabat !.\n\nAnda manusia hebat.Alhamdulillah\n",
    ),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OnBoardingProvider>(context, listen: false).index = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final onBoardingProvider = Provider.of<OnBoardingProvider>(context);

    Object? args = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              onPageChanged: (int value) => onBoardingProvider.index = value,
              controller: _pageController,
              children: pages.asMap().entries.map((e) {
                return e.value;
              }).toList(),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: Space.hf(0.5),
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      AppTheme.c!.accent,
                    ),
                  ),
                  child: const Text('Skip'),
                  onPressed: () {
                    if (args != null && (args as Map)['route'] == 'drawer') {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          Space.x2!,
          ...pages.asMap().entries.map(
                (e) => _Indicator(
                  isSelected: onBoardingProvider.index == e.key,
                ),
              ),
          Space.xm!,
          FloatingActionButton(
            backgroundColor: AppTheme.c!.accent,
            child: onBoardingProvider.index == pages.length - 1
                ? const Icon(Icons.check)
                : const Icon(
                    Icons.arrow_forward,
                  ),
            onPressed: () {
              if (onBoardingProvider.index == pages.length - 1) {
                if (args != null && (args as Map)['route'] == 'drawer') {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                }
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
