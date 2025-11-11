
import 'package:manarat_amjad/core/resources/cashed_image.dart';
import 'package:manarat_amjad/features/cart/data/models/response/cart_dto.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeCart extends StatelessWidget {
  const SkeCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Skeletonizer(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: _cartItems.length,
          itemBuilder: (context, index) {
            // Pass colors to the builder method
            return _buildCartItemCard(
              item: _cartItems[index],
              index: index,

            );
          },
        ),
      ),
    );
  }
  Widget _buildCartItemCard({
    required CartItems item,
    required int index,

  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4F8),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]!, width: 1),
                ),
                child: CustomImage(
                  url: item.product?.imgCover ?? '',
                  width: 50,
                  height: 50,

                ),
              ),
              // if (item.isSuggestion)
              //   Positioned(
              //     bottom: 0,
              //     left: 0,
              //     right: 0,
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(
              //         vertical: 2,
              //         horizontal: 4,
              //       ),
              //       decoration: BoxDecoration(
              //         color: primaryColor.withOpacity(0.8),
              //         borderRadius: const BorderRadius.only(
              //           bottomLeft: Radius.circular(10),
              //           bottomRight: Radius.circular(10),
              //         ),
              //       ),
              //       child: const Text(
              //         'Suggestion',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(color: Colors.white, fontSize: 8),
              //       ),
              //     ),
              //   ),
            ],
          ),
          const SizedBox(width: 8),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.product?.title??'',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,

                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '${item.product?.priceAfterDiscount?.toStringAsFixed(2)}ريال',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    if (item.product?.price != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        '${item.product?.price!.toStringAsFixed(0)}da',
                        style: TextStyle(
                          fontSize: 12,

                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Quantity Selector
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  // onTap: () => _decreaseQuantity(index),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 6.0,
                    ),
                    child: Icon(Icons.remove, size: 18, color: Colors.white),
                  ),
                ),
                Container(
                  color: Colors.white.withOpacity(0.5),
                  width: 1,
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6.0,
                  ),
                  child: Text(
                    '${item.quantity}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white.withOpacity(0.5),
                  width: 1,
                  height: 20,
                ),
                InkWell(
                  // onTap: () => _increaseQuantity(index),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 6.0,
                    ),
                    child: Icon(Icons.add, size: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final List<CartItems> _cartItems = [
  CartItems(
      quantity: 1,
      product: Product(
        description: 'ppppppppppppp',
        category: 5,
        price: 0,
        discount: 0,
        imgCover: "9903مثلثات المراعي.webp",
        title: "ppppppppppppp",
        priceAfterDiscount: 0.0,
      )
  ),
  CartItems(
      quantity: 1,
      product: Product(
        description: 'ppppppppppppp',
        category: 5,
        price: 0,
        discount: 0,
        imgCover: "9903مثلثات المراعي.webp",
        title: "ppppppppppppp",
        priceAfterDiscount: 0.0,
      )
  ),
  CartItems(
      quantity: 1,
      product: Product(
        description: 'ppppppppppppp',
        category: 5,
        price: 0,
        discount: 0,
        imgCover: "9903مثلثات المراعي.webp",
        title: "ppppppppppppp",
        priceAfterDiscount: 0.0,
      )
  ),
  CartItems(
      quantity: 1,
      product: Product(
        description: 'ppppppppppppp',
        category: 5,
        price: 0,
        discount: 0,
        imgCover: "9903مثلثات المراعي.webp",
        title: "ppppppppppppp",
        priceAfterDiscount: 0.0,
      )
  ),
  CartItems(
      quantity: 1,
      product: Product(
        description: 'ppppppppppppp',
        category: 5,
        price: 0,
        discount: 0,
        imgCover:"9903مثلثات المراعي.webp",
        title: "ppppppppppppp",
        priceAfterDiscount: 0.0,
      )
  ),
  CartItems(
      quantity: 1,
      product: Product(
        description: 'ppppppppppppp',
        category: 5,
        price: 0,
        discount: 0,
        imgCover:"9903مثلثات المراعي.webp",
        title: "ppppppppppppp",
        priceAfterDiscount: 0.0,
      )
  ),
  CartItems(
      quantity: 1,
      product: Product(
        description: 'ppppppppppppp',
        category: 5,
        price: 0,
        discount: 0,
        imgCover: "9903مثلثات المراعي.webp",
        title: "ppppppppppppp",
        priceAfterDiscount: 0.0,
      )
  ),
  CartItems(
      quantity: 1,
      product: Product(
        description: 'ppppppppppppp',
        category: 5,
        price: 0,
        discount: 0,
        imgCover: "9903مثلثات المراعي.webp",
        title: "ppppppppppppp",
        priceAfterDiscount: 0.0,
      )
  ),
  CartItems(
      quantity: 1,
      product: Product(
        description: 'ppppppppppppp',
        category: 5,
        price: 0,
        discount: 0,
        imgCover: "9903مثلثات المراعي.webp",
        title: "ppppppppppppp",
        priceAfterDiscount: 0.0,
      )
  ),
  CartItems(
      quantity: 1,
      product: Product(
        description: 'ppppppppppppp',
        category: 5,
        price: 0,
        discount: 0,
        imgCover:"9903مثلثات المراعي.webp",
        title: "ppppppppppppp",
        priceAfterDiscount: 0.0,
      )
  ),
  CartItems(
      quantity: 1,
      product: Product(
        description: 'ppppppppppppp',
        category: 5,
        price: 0,
        discount: 0,
        imgCover:"9903مثلثات المراعي.webp",
        title: "ppppppppppppp",
        priceAfterDiscount: 0.0,
      )
  ),
];
