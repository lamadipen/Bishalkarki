import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../main.dart';
import 'section_heading.dart';

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
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Curated opportunities',
                title: 'Featured Listings',
                description:
                    'A selection of standout homes across Northern Virginia and the greater DMV.',
                centered: true,
              ),
              const SizedBox(height: AppSpacing.xxl),
              AnimationLimiter(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _listings.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                    mainAxisExtent: width < 600 ? 420 : 410,
                  ),
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: columns,
                      duration: const Duration(milliseconds: 450),
                      child: SlideAnimation(
                        verticalOffset: 20,
                        child: FadeInAnimation(
                            child: _ListingCard(data: _listings[index])),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton(
                onPressed: () =>
                    launchListingUrl(AppContent.homesAgentListingsUrl),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.black,
                ),
                child: const Text('Browse All Listings'),
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
            borderRadius: BorderRadius.circular(20),
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
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 220,
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
                          child: Icon(Icons.home_work_outlined,
                              color: AppColors.textSecondary),
                        ),
                      ),
                      Positioned(
                        left: AppSpacing.sm,
                        top: AppSpacing.sm,
                        child: Material(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(999),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 11, vertical: 6),
                            child: Text(
                              widget.data.status.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                              ),
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
                      Text(
                        widget.data.price,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary, fontSize: 22),
                      ),
                      const SizedBox(height: 6),
                      Text(widget.data.address),
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.md,
                        runSpacing: AppSpacing.xs,
                        children: [
                          _PropertyDetail(
                            icon: Icons.king_bed_outlined,
                            label: '${widget.data.beds} beds',
                          ),
                          _PropertyDetail(
                            icon: Icons.bathtub_outlined,
                            label: '${widget.data.baths} baths',
                          ),
                          _PropertyDetail(
                            icon: Icons.square_foot,
                            label: '${widget.data.sqft} sqft',
                          ),
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

class _PropertyDetail extends StatelessWidget {
  const _PropertyDetail({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 17, color: AppColors.primary),
        const SizedBox(width: 5),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
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
