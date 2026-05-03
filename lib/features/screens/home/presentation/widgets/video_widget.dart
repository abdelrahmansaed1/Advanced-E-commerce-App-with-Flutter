import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SmartVideoWidget extends StatefulWidget {
  final String url;
  // final double height;

  const SmartVideoWidget({super.key, required this.url});

  @override
  State<SmartVideoWidget> createState() => _SmartVideoWidgetState();
}

class _SmartVideoWidgetState extends State<SmartVideoWidget>
    with AutomaticKeepAliveClientMixin {
  VideoPlayerController? _controller;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        // auto play when initialized if already visible
        if (_isVisible) {
          _controller?.play();
          _controller?.setLooping(true);
        }
      });
  }

  void _handleVisibility(double visibleFraction) {
    if (_controller == null || !_controller!.value.isInitialized) return;

    if (visibleFraction > 0.6 && !_isVisible) {
      _controller!.play();
      _controller!.setLooping(true);
      _isVisible = true;
    } else if (visibleFraction < 0.6 && _isVisible) {
      _controller!.pause();
      _isVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return VisibilityDetector(
      key: Key(widget.url),
      onVisibilityChanged: (info) => _handleVisibility(info.visibleFraction),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _controller == null || !_controller!.value.isInitialized
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/thumbnail.png', fit: BoxFit.cover),
                  Container(color: Colors.black12),
                  const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.backgroundColor,
                    ),
                  ),
                ],
              )
            : VideoPlayer(_controller!),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
