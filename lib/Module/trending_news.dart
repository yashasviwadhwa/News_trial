import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Provider/NewsProvider.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: Consumer<NewsProvider>(
        builder: (context, newsProvider, _) {
          if (newsProvider.newsList.isEmpty) {
            newsProvider.fetchNews();
            return const Center(child: CircularProgressIndicator());
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Trending News'),
              ),
              body: ListView.builder(
                itemCount: newsProvider.newsList.length,
                itemBuilder: (context, index) {
                  final article = newsProvider.newsList[index];
                  return Column(
                    children: [
                      Container(
                        width: 400,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: article.urlToImage ?? "",
                            placeholder: (context, url) => Image.network(
                                'https://th.bing.com/th/id/OIG.oPJm5FMm2UKL6IFVVVGK?w=270&h=270&c=6&r=0&o=5&dpr=1.3&pid=ImgGn',
                                fit: BoxFit.fill),
                            errorWidget: (context, url, error) => Image.network(
                                'https://th.bing.com/th/id/OIG.oPJm5FMm2UKL6IFVVVGK?w=270&h=270&c=6&r=0&o=5&dpr=1.3&pid=ImgGn'),
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        article.title ?? "",
                        maxLines: 2,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        article.description ?? "",
                        maxLines: 3,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
