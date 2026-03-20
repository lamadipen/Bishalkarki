import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main.dart';

class ListingsSection extends StatelessWidget {
  const ListingsSection({super.key});

  static const _listings = [
    _Listing('\$1,285,000', '4213 Maple Crest Dr, Fairfax, VA', '4', '3', '3,250',
        'https://picsum.photos/600/420?house1'),
    _Listing('\$949,000', '9820 Green River Ln, Vienna, VA', '3', '2.5', '2,640',
        'https://picsum.photos/600/420?house2'),
    _Listing('\$1,650,000', '7202 Oak Hollow Ct, McLean, VA', '5', '4.5', '4,100',
        'https://picsum.photos/600/420?house3'),
    _Listing('\$789,000', '5508 Liberty Bell Dr, Arlington, VA', '3', '2', '2,120',
        'https://picsum.photos/600/420?house4'),
    _Listing('\$1,120,000', '1933 Stonebrook Way, Reston, VA', '4', '3.5', '3,040',
        'https://picsum.photos/600/420?house5'),
    _Listing('\$674,000', '14507 Pinecrest Ave, Falls Church, VA', '2', '2', '1,760',
        'https://picsum.photos/600/420?house6'),
  ];

  @override
  Widget build(BuildContext context) {
    final keys = context.read<ScrollSectionController>();
    final width = MediaQuery.of(context).size.width;
    final columns = width < 600 ? 1 : (width < 1024 ? 2 : 3);

    return Container(
      key: keys.listingsKey,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.section,
      ),
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            children: [
              Text('Featured Listings', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: AppSpacing.xl),
              AnimationLimiter(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _listings.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: columns,
                      duration: const Duration(milliseconds: 450),
                      child: SlideAnimation(
                        verticalOffset: 20,
                        child: FadeInAnimation(child: _ListingCard(data: _listings[index])),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.black,
                ),
                child: const Text('View All Listings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListingCard extends StatefulWidget {
  const _ListingCard({required this.data});
  final _Listing data;

  @override
  State<_ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<_ListingCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.diagonal3Values(
          hovering ? 1.015 : 1.0,
          hovering ? 1.015 : 1.0,
          1.0,
        ),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
          boxShadow: hovering
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.18),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  widget.data.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.price,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(height: 6),
                    Text(widget.data.address),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        const Icon(Icons.king_bed_outlined, size: 18),
                        const SizedBox(width: 4),
                        Text(widget.data.beds),
                        const SizedBox(width: 12),
                        const Icon(Icons.bathtub_outlined, size: 18),
                        const SizedBox(width: 4),
                        Text(widget.data.baths),
                        const SizedBox(width: 12),
                        const Icon(Icons.square_foot, size: 18),
                        const SizedBox(width: 4),
                        Text('${widget.data.sqft} sqft'),
                      ],
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

class _Listing {
  const _Listing(
    this.price,
    this.address,
    this.beds,
    this.baths,
    this.sqft,
    this.image,
  );

  final String price;
  final String address;
  final String beds;
  final String baths;
  final String sqft;
  final String image;
}
