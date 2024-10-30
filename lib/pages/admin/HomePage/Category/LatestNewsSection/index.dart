import 'package:flutter/material.dart';
import 'package:heart_attack_detection_fe/models/latestNews.d.dart';
import 'package:heart_attack_detection_fe/services/latestNewsApi.dart';
import 'package:url_launcher/url_launcher.dart';

class LatestNewsSection extends StatefulWidget {
  const LatestNewsSection({super.key});

  @override
  State<LatestNewsSection> createState() => _LatestNewsSectionState();
}

class _LatestNewsSectionState extends State<LatestNewsSection> {
  List<LatestNews> latestnews = [];
  String nullImageUrl =
      'https://media.istockphoto.com/id/1032637132/photo/a-cup-of-coffee-glasses-and-newspaper-titled-health-medical.jpg?s=612x612&w=0&k=20&c=W52Q_4CXrdJs24wI_5qt4t72Hcs1AzpzkoSzntByUoY=';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Latest news:',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontStyle: FontStyle.italic)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: latestnews.length,
                itemBuilder: (context, index) {
                  final latestnew = latestnews[index];
                  final image_url = latestnew.urlToImage ?? nullImageUrl;
                  final url = latestnew.url;
                  final title = latestnew.title;
                  final author = latestnew.author;
                  final description = latestnew.description;

                  return GestureDetector(
                    onTap: () async {
                      final Uri uri = Uri.parse(url!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch $uri';
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          )),
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: ListTile(
                        leading: Image.network(
                          image_url != null ? image_url : nullImageUrl,
                          height: 100,
                          width: 100,
                        ),
                        title: Text(
                          '$title by $author',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          description ?? 'No Description',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    await fetchAllNews();
  }

  Future<void> fetchAllNews() async {
    final response = await LatestNewsAPI.fetchAllNews();
    setState(() {
      latestnews = response;
    });
  }
}
