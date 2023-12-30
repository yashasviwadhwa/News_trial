import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Provider/NewsProvider.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart' as CarouselSliderPackage;

class MyCustomCarouselSlider extends StatelessWidget {
  const MyCustomCarouselSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder: (context, newsProvider, _) {
      if (newsProvider.newsList.isEmpty) {
        newsProvider.fetchNews();
        return const Center(child: CircularProgressIndicator());
      } else {
        return CarouselSliderPackage.CarouselSlider.builder(
          itemCount: 5,
          itemBuilder: (context, index, realIndex) {
            return Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.shade500,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: newsProvider.newsList[index].urlToImage ?? "",
                    placeholder: (context, url) => Image.network(
                        'https://th.bing.com/th/id/OIG.oPJm5FMm2UKL6IFVVVGK?w=270&h=270&c=6&r=0&o=5&dpr=1.3&pid=ImgGn',
                        fit: BoxFit.fill),
                    errorWidget: (context, url, error) => Image.network(
                        'https://th.bing.com/th/id/OIG.oPJm5FMm2UKL6IFVVVGK?w=270&h=270&c=6&r=0&o=5&dpr=1.3&pid=ImgGn'),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(top: 140),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    newsProvider.newsList[index].title ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
          ),
        );
      }
    });
  }
}
