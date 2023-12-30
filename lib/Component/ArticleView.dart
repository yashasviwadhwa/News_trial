import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:news_app/Provider/NewsProvider.dart';
import 'package:provider/provider.dart';

class ArticleView extends StatelessWidget {
  final String url;

  // Constructor to receive parameters
  ArticleView({required this.url});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, _) {
        // Use the provided 'url' parameter
        final selectedArticleUrl = url;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Article View'),
          ),
          body: WebView(
            initialUrl: selectedArticleUrl ?? '',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        );
      },
    );
  }
}
