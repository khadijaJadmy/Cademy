import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItems{

final VideoPlayerController videoPlayerController;
final bool looping;
final bool autoplay;


VideoItems({
  @required this.videoPlayerController,
  this.looping, this.autoplay,
  Key key,
}) ;

}
