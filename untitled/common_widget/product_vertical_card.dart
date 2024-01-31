import 'package:get/get.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:flutter/material.dart';
import 'package:haatinhandseller/constans/helpers/navigation.dart';
import 'package:haatinhandseller/controllers/product_controller.dart';
import 'package:haatinhandseller/screens/product_details/product_details_screen.dart';
// import 'package:haatinhandseller/constans/helpers/navigation.dart';

class ProductVerticalCard extends StatefulWidget {
  final double cardWidth;
  final int index;
  // 0.47
  const ProductVerticalCard({
    super.key,
    required this.index,
    required this.cardWidth,
  });

  @override
  State<ProductVerticalCard> createState() => _ProductVerticalCardState();
}

class _ProductVerticalCardState extends State<ProductVerticalCard> {
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: widget.cardWidth,
        decoration: BoxDecoration(
            color: AppColorConstant.whiteColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColorConstant.greyColor)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 4.0, top: 4.0, right: 4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: SizedBox(
                      height: 150,
                      width: widget.cardWidth,
                      child: Image.network(
                        productController
                            .searchProductList[widget.index].image![0],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text(
                    productController.searchProductList[widget.index].name ??
                        "",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(color: AppColorConstant.blackColor),
                  ),
                ),
                const Spacer(),
              ],
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    nextPage(
                      context: context,
                      widget: ProductDetailsScreen(index: widget.index),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
