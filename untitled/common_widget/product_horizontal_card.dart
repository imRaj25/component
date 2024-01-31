import 'package:haatinhandseller/common_widget/custom_button.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:flutter/material.dart';

class ProductHorizontalCard extends StatelessWidget {
  final double cardWidth;
  // 0.47
  const ProductHorizontalCard({
    super.key,
    required this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
          color: AppColorConstant.whiteColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: AppColorConstant.greyColor,
              blurRadius: 4,
              spreadRadius: 0.0,
              offset: Offset(0.0, 0.0),
            ),
          ]),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: 150,
                      width: cardWidth * 0.4,
                      color: AppColorConstant.itemBgColor,
                      child: Image.network(
                        "http://naturecircle3.demo.towerthemes.com/image/cache/catalog/Products/Organic/3-600x600.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$50.00",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: AppColorConstant.redTextColor),
                              ),
                              Text(
                                "\$65.00",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppColorConstant.normalGreyTwo,
                                    decoration: TextDecoration.lineThrough),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Popular Black Grape Product",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColorConstant.blackColor),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 5,
                left: 5,
                child: Container(
                  height: 30,
                  width: cardWidth * 0.2,
                  decoration: BoxDecoration(
                    color: AppColorConstant.redTextColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Text(
                      "10% Off",
                      style: TextStyle(
                          fontSize: 12, color: AppColorConstant.redTextColor),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {},
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: cardWidth * 0.48,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SizedBox(
                        height: 35.0,
                        width: cardWidth * 0.55,
                        child: CustomButton(func: () {}, label: "Add To Cart"),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
