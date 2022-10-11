import 'package:djmusic/screens/bookmarkscreen.dart';
import 'package:djmusic/screens/mapscreen.dart';
import 'package:djmusic/screens/profilescreen.dart';
import 'package:get/get.dart';

class DjController extends GetxController {
  var Screens = [MapScreen(), ProfileScreen(), BookmarkScreen()].obs;
  var screenindex = 0.obs;
}
