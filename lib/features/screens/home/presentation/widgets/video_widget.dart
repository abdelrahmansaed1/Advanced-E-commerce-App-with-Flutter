// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:video_player/video_player.dart';

// // // // // class VideoWidget extends StatefulWidget {
// // // // //   final String url;

// // // // //   const VideoWidget({super.key, required this.url});

// // // // //   @override
// // // // //   State<VideoWidget> createState() => _VideoWidgetState();
// // // // // }

// // // // // class _VideoWidgetState extends State<VideoWidget> {
// // // // //   late VideoPlayerController _controller;
// // // // //   bool isInitialized = false;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();

// // // // //     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
// // // // //       ..initialize().then((_) {
// // // // //         setState(() {
// // // // //           isInitialized = true;
// // // // //         });

// // // // //         _controller
// // // // //           ..setLooping(true)
// // // // //           ..play();
// // // // //       });
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _controller.dispose();
// // // // //     super.dispose();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     if (!isInitialized) {
// // // // //       return Container(
// // // // //         color: const Color(0xffECF3FA),
// // // // //         child: const Center(child: CircularProgressIndicator()),
// // // // //       );
// // // // //     }

// // // // //     return FittedBox(
// // // // //       fit: BoxFit.cover,
// // // // //       child: SizedBox(
// // // // //         width: _controller.value.size.width,
// // // // //         height: _controller.value.size.height,
// // // // //         child: VideoPlayer(_controller),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
// // // // import 'package:flutter/material.dart';
// // // // import 'package:video_player/video_player.dart';

// // // // class VideoWidget extends StatefulWidget {
// // // //   final String url;

// // // //   const VideoWidget({super.key, required this.url});

// // // //   @override
// // // //   State<VideoWidget> createState() => _VideoWidgetState();
// // // // }

// // // // class _VideoWidgetState extends State<VideoWidget> {
// // // //   VideoPlayerController? _controller;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();

// // // //     if (widget.url.isNotEmpty) {
// // // //       _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
// // // //         ..initialize().then((_) {
// // // //           if (!mounted) return;
// // // //           setState(() {});
// // // //           _controller?.setLooping(true);
// // // //           _controller?.play();
// // // //         });
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     if (_controller == null || !_controller!.value.isInitialized) {
// // // //       return Container(color: const Color(0xffECF3FA));
// // // //     }

// // // //     return SizedBox.expand(
// // // //       child: FittedBox(
// // // //         fit: BoxFit.cover,
// // // //         child: SizedBox(
// // // //           width: _controller!.value.size.width,
// // // //           height: _controller!.value.size.height,
// // // //           child: VideoPlayer(_controller!),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _controller?.dispose();
// // // //     super.dispose();
// // // //   }
// // // // }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SmartVideoWidget extends StatefulWidget {
  final String url;
  final double height;

  const SmartVideoWidget({super.key, required this.url, required this.height});

  @override
  State<SmartVideoWidget> createState() => _SmartVideoWidgetState();
}

class _SmartVideoWidgetState extends State<SmartVideoWidget> {
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
    return VisibilityDetector(
      key: Key(widget.url),
      onVisibilityChanged: (info) => _handleVisibility(info.visibleFraction),
      child: SizedBox(
        width: double.infinity,
        height: widget.height,
        child: _controller == null || !_controller!.value.isInitialized
            ? Container(color: const Color(0xffECF3FA))
            : VideoPlayer(_controller!), // VideoPlayer fills its parent
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:visibility_detector/visibility_detector.dart';

// class SmartVideoWidget extends StatefulWidget {
//   final String url;

//   const SmartVideoWidget({super.key, required this.url});

//   @override
//   State<SmartVideoWidget> createState() => _SmartVideoWidgetState();
// }

// class _SmartVideoWidgetState extends State<SmartVideoWidget> {
//   VideoPlayerController? _controller;
//   bool _isVisible = false;

//   @override
//   void initState() {
//     super.initState();

//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
//       ..initialize().then((_) {
//         if (!mounted) return;
//         setState(() {});
//       });
//   }

//   void _handleVisibility(double visibleFraction) {
//     if (_controller == null || !_controller!.value.isInitialized) return;

//     if (visibleFraction > 0.6 && !_isVisible) {
//       _controller!.play();
//       _controller!.setLooping(true);
//       _isVisible = true;
//     } else if (visibleFraction < 0.6 && _isVisible) {
//       _controller!.pause();
//       _isVisible = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return VisibilityDetector(
//       key: Key(widget.url),
//       onVisibilityChanged: (info) {
//         _handleVisibility(info.visibleFraction);
//       },
//       child: SizedBox.expand(
//         child: _controller == null || !_controller!.value.isInitialized
//             ? Container(color: const Color(0xffECF3FA))
//             : FittedBox(
//                 fit: BoxFit.cover, // يمنع تجاوز الحجم
//                 child: SizedBox(
//                   width: _controller!.value.size.width,
//                   height: _controller!.value.size.height,
//                   child: VideoPlayer(_controller!),
//                 ),
//               ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
// }
