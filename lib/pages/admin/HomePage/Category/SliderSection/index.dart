import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderSection extends StatefulWidget {
  const SliderSection({super.key});

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  final CarouselController b = CarouselController();

  final List<String> imgList = [
    'https://www.globalsign.com/application/files/4716/4187/7830/IoT_Banner_IoTinHealthcare_3_APAC_2022_01_06.jpg',
    'https://www.karexpert.com/wp-content/uploads/2022/06/22.png',
    'https://www.tigahealth.com/wp-content/uploads/2021/06/iot-tech-tools.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUqtjh8FvQ3HvzKrrNo6Swi8pnx_Dz3Q0yxWGGWnxRUCY_UqMBeS0yMFQSi0-5c7DXA-o&usqp=CAU',
    'https://imageio.forbes.com/specials-images/imageserve/651bbeb1c78cc403f92a6abd/The-10-Biggest-Trends-Revolutionizing-Healthcare-In-2024/0x0.jpg?crop=2500,1405,x0,y0,safe&height=399&width=711&fit=bounds',
    'https://www.opentext.com/assets/images/products-solutions/solution-industry-category/opentext-image-ov-healthcare-en.jpg'
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider(
              items: imgList
                  .map((e) => Center(
                        child: Image.network(
                          e,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                  initialPage: 0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (value, _) {
                    setState(() {
                      _currentPage = value;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: buildCarouselIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < imgList.length; i++)
          Container(
            margin: const EdgeInsets.all(5),
            height: i == _currentPage ? 7 : 5,
            width: i == _currentPage ? 7 : 5,
            decoration: BoxDecoration(
              color: i == _currentPage ? Colors.white : Colors.black,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}
