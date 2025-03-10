import 'package:flutter/material.dart';
import 'package:wanted/game.dart';

class WantedPoster extends StatefulWidget{
  final ValueNotifier<String> imageNotifier;
  final MainGame game;
  const WantedPoster({super.key, required this.imageNotifier, required this.game});

  @override
  State<StatefulWidget> createState() => _wantedPoster();
}

class _wantedPoster extends State<WantedPoster>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RawImage(image: widget.game.images.fromCache(widget.imageNotifier.value), scale: 0.25,),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.imageNotifier.addListener(_updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    widget.imageNotifier.removeListener(_updateImage);
  }

  void _updateImage(){
    setState(() {});
  }
}