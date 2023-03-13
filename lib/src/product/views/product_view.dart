import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store/src/core/presentation/theme.dart';
import 'package:fake_store/src/product/models/product.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    required this.product,
    super.key,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
          )
        ],
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: MediaQuery.of(context).viewPadding,
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              product.title,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  Theme.of(context).smallTitlePrimaryTextStyle,
                            ),
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          Text(
                            product.price.toString(),
                            style: Theme.of(context).smallTitlePrimaryTextStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text('Rating : ${product.rating.rate}'),
                      SizedBox(
                        height: 1.h,
                      ),
                      Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title: const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: <Widget>[
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                product.description,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 42.w,
                      height: 7.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.favorite_border),
                            SizedBox(
                              width: 1.w,
                            ),
                            const Text('WISHLIST'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 42.w,
                      height: 7.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          elevation: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_bag_outlined),
                            SizedBox(
                              width: 1.w,
                            ),
                            const Text('BUY NOW'),
                          ],
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
    );
  }
}
