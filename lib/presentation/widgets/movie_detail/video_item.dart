import 'package:flutter/material.dart';
import '../../../data/models/movie_video.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoItem extends StatelessWidget {
  final ResultVideo result;

  const VideoItem({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchURL(result.key);
      },
      child: Container(
        margin: EdgeInsets.only(right: 25, top: 10),
        width: 320,
        height: 180,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                "https://img.youtube.com/vi/${result.key}/sddefault.jpg",
              ),
              fit: BoxFit.cover),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }

  void _launchURL(String key) async {
    String url = 'https://www.youtube.com/watch?v=$key';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
