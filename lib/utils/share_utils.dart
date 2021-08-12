import 'package:share_plus/share_plus.dart';

share(String title, String desc) {
  Share.share("$title\n$desc");
}
