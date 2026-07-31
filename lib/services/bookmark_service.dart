import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/video.dart';

class BookmarkService extends ChangeNotifier {
  BookmarkService._();

  static final BookmarkService instance = BookmarkService._();

  static const _key = "bookmarks";

  final List<Video> _bookmarks = [];

  List<Video> get bookmarks => List.unmodifiable(_bookmarks);

  bool _loaded = false;

  bool isBookmarked(Video video) {
    return _bookmarks.any((e) => e.id == video.id);
  }

  Future<void> load(List<Video> allVideos) async {
    if (_loaded) return;

    final prefs = await SharedPreferences.getInstance();

    final saved = prefs.getStringList(_key) ?? [];

    _bookmarks.clear();

    for (final id in saved) {
      try {
        final video = allVideos.firstWhere(
          (e) => e.id == int.parse(id),
        );

        _bookmarks.add(video);
      } catch (_) {}
    }

    _loaded = true;
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      _key,
      _bookmarks.map((e) => e.id.toString()).toList(),
    );
  }

  Future<void> toggle(Video video) async {
    if (isBookmarked(video)) {
      _bookmarks.removeWhere((e) => e.id == video.id);
    } else {
      _bookmarks.add(video);
    }

    await _save();

    notifyListeners();
  }
}