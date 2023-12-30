import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app/Model/NewsModel.dart';

class NewsProvider extends ChangeNotifier {
  List<Articles> _newsList = [];
  List<Articles> get newsList => _newsList;
  Articles? _selectedNews;
  Articles? get selectedNews => _selectedNews;
  String? _selectedArticleUrl;
  String? get selectedArticleUrl => _selectedArticleUrl;

  Future<void> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=in&apiKey=7aa037550b9946769cf455d607765de3"));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['articles'];
        _newsList = data.map((item) => Articles.fromJson(item)).toList();
        notifyListeners(); // Notify listeners that the state has changed
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }

  void setSelectedNews(Articles news) {
    _selectedNews = news;
    notifyListeners();
  }

  void setSelectedArticleUrl(String url) {
    _selectedArticleUrl = url;
    notifyListeners();
  }
}
