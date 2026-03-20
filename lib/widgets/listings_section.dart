import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../main.dart';

/// Opens listing or portfolio URL in the browser (Homes.com, etc.).
Future<void> launchListingUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class ListingsSection extends StatelessWidget {
  const ListingsSection({super.key});

  /// Curated featured listings: paste each home’s **Homes.com property URL** into [listingUrl]
  /// and the listing **image URL** into [thumbnailUrl] (right‑click image → copy address).
  /// Until then, cards can share [AppContent.homesAgentListingsUrl].
  static const _listings = [
    _Listing(
      price: '\$1,285,000',
      address: '4213 Maple Crest Dr, Fairfax, VA',
      beds: '4',
      baths: '3',
      sqft: '3,250',
      status: 'For Sale',
      thumbnailUrl: 'https://picsum.photos/600/420?house1',
      listingUrl: AppContent.homesAgentListingsUrl,
    ),
    _Listing(
      price: '\$949,000',
      address: '9820 Green River Ln, Vienna, VA',
      beds: '3',
      baths: '2.5',
      sqft: '2,640',
      status: 'Coming Soon',
      thumbnailUrl: 'https://picsum.photos/600/420?house2',
      listingUrl: AppContent.homesAgentListingsUrl,
    ),
    _Listing(
      price: '\$1,650,000',
      address: '7202 Oak Hollow Ct, McLean, VA',
      beds: '5',
      baths: '4.5',
      sqft: '4,100',
      status: 'For Sale',
      thumbnailUrl: 'https://picsum.photos/600/420?house3',
      listingUrl: AppContent.homesAgentListingsUrl,
    ),
    _Listing(
      price: '\$789,000',
      address: '5508 Liberty Bell Dr, Arlington, VA',
      beds: '3',
      baths: '2',
      sqft: '2,120',
      status: 'Pending',
      thumbnailUrl: 'https://picsum.photos/600/420?house4',
      listingUrl: AppContent.homesAgentListingsUrl,
    ),
    _Listing(
      price: '\$1,120,000',
      address: '1933 Stonebrook Way, Reston, VA',
      beds: '4',
      baths: '3.5',
      sqft: '3,040',
      status: 'For Lease',
      thumbnailUrl: 'https://picsum.photos/600/420?house5',
      listingUrl: AppContent.homesAgentListingsUrl,
    ),
    _Listing(
      price: '\$674,000',
      address: '14507 Pinecrest Ave, Falls Church, VA',
      beds: '2',
      baths: '2',
      sqft: '1,760',
      status: 'For Sale',
      thumbnailUrl: 'https://picsum.photos/600/420?house6',
      listingUrl: AppContent.homesAgentListingsUrl,
    ),
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
                onPressed: () => launchListingUrl(AppContent.homesAgentListingsUrl),
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
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: () => launchListingUrl(widget.data.listingUrl),
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
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.data.thumbnailUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.surface,
                          alignment: Alignment.center,
                          child: Icon(Icons.home_work_outlined, color: AppColors.textSecondary),
                        ),
                      ),
                      Positioned(
                        right: AppSpacing.sm,
                        top: AppSpacing.sm,
                        child: Material(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.open_in_new, size: 14, color: Colors.white),
                                SizedBox(width: 4),
                                Text(
                                  'View',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.35)),
                        ),
                        child: Text(
                          widget.data.status,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      const SizedBox(height: 8),
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
      ),
    );
  }
}

class _Listing {
  const _Listing({
    required this.price,
    required this.address,
    required this.beds,
    required this.baths,
    required this.sqft,
    required this.status,
    required this.thumbnailUrl,
    required this.listingUrl,
  });

  final String price;
  final String address;
  final String beds;
  final String baths;
  final String sqft;
  final String status;
  /// Listing hero/thumbnail image (paste Homes.com image URL or host your own).
  final String thumbnailUrl;
  /// Full URL opened when the card is tapped (property detail or agent page).
  final String listingUrl;
}
