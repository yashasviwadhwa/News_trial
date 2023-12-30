import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Component/ArticleView.dart';
import 'package:news_app/Provider/NewsProvider.dart';
import 'package:provider/provider.dart';

class NewsContainer extends StatelessWidget {
  const NewsContainer({Key? key}) : super(key: key);

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
            return SizedBox(
              height: 800,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      final selectedNews = newsProvider.newsList[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleView(
                            url: selectedNews.url ?? '',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: newsProvider
                                              .newsList[index].urlToImage ??
                                          "",
                                      placeholder: (context, url) => Image.network(
                                          'https://th.bing.com/th/id/OIG.oPJm5FMm2UKL6IFVVVGK?w=270&h=270&c=6&r=0&o=5&dpr=1.3&pid=ImgGn'),
                                      errorWidget: (context, url, error) =>
                                          Image.network(
                                              'https://th.bing.com/th/id/OIG.oPJm5FMm2UKL6IFVVVGK?w=270&h=270&c=6&r=0&o=5&dpr=1.3&pid=ImgGn'),
                                      fit: BoxFit.fill,
                                      height: 120,
                                      width: 120,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: Text(
                                          newsProvider.newsList[index].title ??
                                              '',
                                          maxLines: 1,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 7.0),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                        child: Text(
                                          newsProvider.newsList[index]
                                                  .description ??
                                              '',
                                          maxLines: 3,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 13),
              ),
            );
          }
        },
      ),
    );
  }
}
