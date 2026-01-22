import 'package:disan/features/admin/time_lines/story/models/story_model.dart';
import 'package:disan/features/user/home/view_models/cubit/story_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

// Cubit to manage story state
class StoryCubit extends Cubit<Object> {
  final List<StoryModel> stories;
  int _currentIndex;
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  VideoPlayerController? _videoPlayerController;
  bool _isContentLoaded = false;
  final Map<int, bool> _isExpanded = {};
  StoryStatus _status = StoryStatus.initial;
  String? _error;

  // Getters
  int get currentIndex => _currentIndex;
  PageController get pageController => _pageController;
  AnimationController get animationController => _animationController;
  VideoPlayerController? get videoPlayerController => _videoPlayerController;
  bool get isContentLoaded => _isContentLoaded;
  Map<int, bool> get isExpanded => _isExpanded;
  StoryStatus get status => _status;
  String? get error => _error;
  List<StoryModel> get storyList => stories;

  StoryCubit({
    required this.stories,
    required TickerProvider vsync,
    int initialIndex = 0,
  })  : _currentIndex = initialIndex,
        super(Object()) {
    _animationController = AnimationController(vsync: vsync);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (stories.isNotEmpty && initialIndex < stories.length) {
        _pageController.jumpToPage(initialIndex);
        loadStory(story: stories[initialIndex], animateToPage: false);
      } else {
        _status = StoryStatus.error;
        _error = 'No stories available or invalid initial index';
        emit(Object());
      }
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();
        if (_currentIndex + 1 < stories.length) {
          _currentIndex += 1;
          loadStory(story: stories[_currentIndex]);
        } else {
          _status = StoryStatus.completed;
          emit(Object());
        }
      }
    });
  }

  @override
  Future<void> close() {
    _animationController.dispose();
    _videoPlayerController?.dispose();
    _pageController.dispose();
    return super.close();
  }

  void handleTap(TapDownDetails details, BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 3) {
      if (_currentIndex - 1 >= 0) {
        _currentIndex -= 1;
        loadStory(story: stories[_currentIndex]);
        emit(Object());
      }else{
        loadStory(story: stories[_currentIndex]);
        emit(Object());
      }
    } else if (dx > 2 * screenWidth / 3) {
      if (_currentIndex + 1 < stories.length) {
        _currentIndex += 1;
        loadStory(story: stories[_currentIndex]);
      } else {
        // _status = StoryStatus.completed;
        // emit(Object());
      }
      emit(Object());
    } else {
      if (stories[_currentIndex].type == MediaType.video && _videoPlayerController != null) {
        if (_videoPlayerController!.value.isPlaying) {
          _videoPlayerController!.pause();
          _status = StoryStatus.paused;
          _animationController.stop();
        } else {
          _videoPlayerController!.play();
          _status = StoryStatus.playing;
          _animationController.forward();
        }
        emit(Object());
      }
    }
  }

  void handleLongPress() {
    if (_isContentLoaded) {
      _animationController.stop();
      if (stories[_currentIndex].type == MediaType.video && _videoPlayerController != null) {
        _videoPlayerController!.pause();
        _status = StoryStatus.paused;
      }
      emit(Object());
    }
  }

  void handleLongPressEnd() {
    if (_isContentLoaded) {
      _animationController.forward();
      if (stories[_currentIndex].type == MediaType.video && _videoPlayerController != null) {
        _videoPlayerController!.play();
        _status = StoryStatus.playing;
      }
      emit(Object());
    }
  }

  void toggleExpand(int index) {
    _isExpanded[index] = !(_isExpanded[index] ?? false);
    emit(Object());
  }

  void likeStory(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Liked the story ❤️')),
    );
  }

  bool isValidUrl(String? url) {
    if (url == null || url.isEmpty || url == 'file:///') {
      return false;
    }
    try {
      final uri = Uri.parse(url);
      return uri.scheme.isNotEmpty && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  void loadStory({required StoryModel story, bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset();
    _isContentLoaded = false;
    _status = StoryStatus.loading;
    emit(Object());

    if (story.type == MediaType.text) {
      _videoPlayerController?.dispose();
      _videoPlayerController = null;
      _animationController.duration = story.duration;
      _isContentLoaded = true;
      _status = StoryStatus.playing;
      _animationController.forward();
      emit(Object());
    } else if (story.type == MediaType.image) {
      _videoPlayerController?.dispose();
      _videoPlayerController = null;
      if (!isValidUrl(story.url)) {
        _status = StoryStatus.error;
        _error = 'Invalid image URL';
        _isContentLoaded = true;
        emit(Object());
        return;
      }
      _animationController.duration = story.duration;
      // Animation starts in StoryContent after image loads
      emit(Object());
    } else if (story.type == MediaType.video) {
      _videoPlayerController?.dispose();
      if (!isValidUrl(story.url)) {
        _videoPlayerController = null;
        _status = StoryStatus.error;
        _error = 'Invalid video URL';
        _isContentLoaded = true;
        emit(Object());
        return;
      }
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(story.url!))
        ..initialize().then((_) {
          _animationController.duration = _videoPlayerController!.value.duration;
          _videoPlayerController!.play();
          _isContentLoaded = true;
          _status = StoryStatus.playing;
          _animationController.forward();
          emit(Object());
        }).catchError((error) {
          _status = StoryStatus.error;
          _error = error.toString();
          _isContentLoaded = true;
          _animationController.forward();
          emit(Object());
        });
    }

    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void onImageLoaded() {
    _isContentLoaded = true;
    _status = StoryStatus.playing;
    _animationController.forward();
    emit(Object());
  }
}
