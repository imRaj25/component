import 'package:flutter/material.dart';
import 'package:haatinhandseller/common_widget/dotted_line.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';

class CartProductHorizontalCard extends StatelessWidget {
  final double cardWidth;
  // 0.47
  const CartProductHorizontalCard({
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
      ),
      padding: const EdgeInsets.all(0),
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
                      height: 100,
                      width: 100,
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
                          Text(
                            "Black Grape",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColorConstant.blackColor),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "\$10/kg",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColorConstant.greyColor),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "4 kg, ",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColorConstant.greyColor),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "\$40",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColorConstant.redColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border_outlined)),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.remove)),
                          const Text(
                            "4",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColorConstant.primaryColor),
                          ),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.add))
                        ],
                      )
                    ],
                  )
                ],
              ),
              Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(0),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {},
                        )),
                  )),
            ],
          ),
          Container(
            width: cardWidth,
            height: 5,
            color: Colors.white,
            child: const DottedLine(),
          )
        ],
      ),
    );
  }
}
