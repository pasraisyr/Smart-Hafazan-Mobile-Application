import 'package:smart_hafazan/app_routes.dart';
import 'package:iconsax/iconsax.dart';

class DrawerUtils {
  static const List items = [
    {
      'title': 'Log Masuk',
      'icon': Iconsax.login5,
      'route': AppRoutes.sign,
    },
     {
      'title': 'Mula Hafal',
      'icon': Iconsax.teacher,
      'route': AppRoutes.hafalsurahs,
    },
    {
      'title': 'Baca Surah',
      'icon': Iconsax.book4,
      'route': AppRoutes.surah,
    },
   
    {
      'title': 'Nota Tajwid',
      'icon': Iconsax.note,
      'route': AppRoutes.nota,
    },
    {
      'title': 'Tanda Bacaan',
      'icon': Iconsax.book_saved,
      'route': AppRoutes.bookmarks,
    },
    {
      'title': 'Smart Hafazan',
      'icon': Iconsax.story,
      'route': AppRoutes.onboarding,
    },
    
  ];
}
