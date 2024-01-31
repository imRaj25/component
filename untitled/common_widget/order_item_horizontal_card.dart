import 'package:haatinhandseller/common_widget/dotted_line.dart';
import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:haatinhandseller/constans/helpers/custom_date_time_helper.dart';
import 'package:flutter/material.dart';

class OrderItemHorizontalCard extends StatelessWidget {
  final double cardWidth;
  // 0.47
  const OrderItemHorizontalCard({
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
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  "Black Grape",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColorConstant.blackColor),
                                ),
                              ),
                              Text(
                                CustomDateTimeHelper
                                    .dateMonthYearFromMiliseconds(
                                        DateTime.now().millisecondsSinceEpoch),
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: AppColorConstant.normalGreyTwo),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order ID:",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: AppColorConstant.grayDark),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "#5623575673267325",
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColorConstant.primaryColor),
                                ),
                              )
                            ],
                          ),
                          const Row(
                            children: [
                              Text(
                                "Payment:",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: AppColorConstant.grayDark),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Online",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: AppColorConstant.greyColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned.fill(
                  child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {},
                      ))),
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
