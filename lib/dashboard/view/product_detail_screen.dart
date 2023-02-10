import 'package:flutter/material.dart';
import 'package:flutter_challenge_ronisetiawan/dashboard/model/product.dart';
import 'package:flutter_challenge_ronisetiawan/dashboard/widgets/product_description.dart';
import 'package:flutter_challenge_ronisetiawan/dashboard/widgets/product_detail.dart';
import 'package:flutter_challenge_ronisetiawan/dashboard/widgets/product_insight.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentImage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final List<String>? productImages = widget.product.images;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.product.brand),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: PageView.builder(
                  itemCount: productImages!.length,
                  controller: _pageController,
                  pageSnapping: true,
                  onPageChanged: ((value) {
                    setState(() {
                      _currentImage = value;
                    });
                  }),
                  itemBuilder: (context, imagePosition) {
                    bool active = imagePosition == _currentImage;
                    return imageSlider(productImages, imagePosition, active);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageIndicator(productImages.length, _currentImage),
              ),
              const SizedBox(height: 40),
              ProductInsight(
                imageNetwork: widget.product.thumbnail!,
                title: widget.product.title,
                brand: widget.product.brand,
                category: widget.product.category,
                child: Row(
                  children: [
                    const SizedBox(height: 3),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Rating        :   ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: widget.product.rating.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    StarRating(
                      rating: widget.product.rating!,
                      onRatingChanged: (rating) => setState(
                        () => rating = widget.product.rating!.toDouble(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ProductDetail(
                price: '\$ ${widget.product.price.toString()}',
                discountPercentage:
                    '${widget.product.discountPercentage.toString()}%',
                priceAfterDiscount:
                    '\$ ${(widget.product.price - (widget.product.price * widget.product.discountPercentage!) / 100).toStringAsFixed(2)}',
                stock: widget.product.stock.toString(),
              ),
              const SizedBox(height: 30),
              ProductDesctiption(
                description: widget.product.description ?? '-',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer imageSlider(images, imagePosition, active) {
    double margin = active ? 10 : 20;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      child: Image.network(
        images[imagePosition],
      ),
    );
  }

  List<Widget> imageIndicator(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: currentIndex == index ? Colors.blue : Colors.grey,
          shape: BoxShape.circle,
        ),
      );
    });
  }
}

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final Function(double rating) onRatingChanged;
  final Color? color;

  const StarRating({
    super.key,
    this.starCount = 5,
    this.rating = .0,
    required this.onRatingChanged,
    this.color,
  });

  Widget buildStar(BuildContext context, int index) {
    if (index >= rating) {
      return const Icon(
        Icons.star_border,
        color: Colors.amber,
        size: 12,
      );
    } else if (index > rating - 1 && index < rating) {
      return Icon(
        Icons.star_half,
        color: color ?? Colors.amber,
        size: 12,
      );
    } else {
      return Icon(
        Icons.star,
        color: color ?? Colors.amber,
        size: 12,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(starCount, (index) => buildStar(context, index)),
    );
  }
}
