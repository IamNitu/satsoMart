import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';
import 'package:sasto_mart/features/home/models/product_model.dart';

class PdpReviewsCard extends StatelessWidget {
  final Ratings ratings;

  const PdpReviewsCard({super.key, required this.ratings});

  Map<int, int> _computeStarCounts(double avg, int total) {
    if (total == 0) return {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    double p5 = 0.0, p4 = 0.0, p3 = 0.0, p2 = 0.0;
    if (avg >= 4.5) {
      p5 = 0.75; p4 = 0.18; p3 = 0.04; p2 = 0.02;
    } else if (avg >= 4.0) {
      p5 = 0.55; p4 = 0.30; p3 = 0.09; p2 = 0.04;
    } else if (avg >= 3.0) {
      p5 = 0.30; p4 = 0.35; p3 = 0.20; p2 = 0.10;
    } else {
      p5 = 0.10; p4 = 0.15; p3 = 0.25; p2 = 0.30;
    }
    final c5 = (total * p5).round();
    final c4 = (total * p4).round();
    final c3 = (total * p3).round();
    final c2 = (total * p2).round();
    final c1 = (total - (c5 + c4 + c3 + c2)).clamp(0, total);
    return {5: c5, 4: c4, 3: c3, 2: c2, 1: c1};
  }

  @override
  Widget build(BuildContext context) {
    final avg = ratings.average;
    final totalCount = ratings.count;
    final starCounts = _computeStarCounts(avg, totalCount);

    return Container(
      padding: EdgeInsets.all(context.wp(4)),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Customer Reviews",
                style: TextStyle(
                  fontSize: context.sp(14),
                  fontWeight: FontWeight.w900,
                  color: AppColors.textDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.navyBlue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "$totalCount Total",
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.navyBlue,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: context.hp(1.4)),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Big Score
              Column(
                children: [
                  Text(
                    avg.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: context.sp(32),
                      fontWeight: FontWeight.w900,
                      color: AppColors.navyBlue,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (i) {
                      return Icon(
                        Icons.star_rounded,
                        size: 13,
                        color: i < avg.round()
                            ? const Color(0xFFF59E0B)
                            : const Color(0xFFCBD5E1),
                      );
                    }),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    "out of 5",
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(width: context.wp(4)),

              Container(
                width: 1,
                height: context.hp(8.5),
                color: const Color(0xFFE2E8F0),
              ),

              SizedBox(width: context.wp(4)),

              // Dynamic Progress Breakdown
              Expanded(
                child: Column(
                  children: [
                    _buildRatingRow(5, starCounts[5] ?? 0, totalCount),
                    _buildRatingRow(4, starCounts[4] ?? 0, totalCount),
                    _buildRatingRow(3, starCounts[3] ?? 0, totalCount),
                    _buildRatingRow(2, starCounts[2] ?? 0, totalCount),
                    _buildRatingRow(1, starCounts[1] ?? 0, totalCount),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow(int star, int count, int total) {
    final double ratio = total > 0 ? (count / total) : 0.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            "$star",
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(width: 2),
          const Icon(Icons.star_rounded, size: 10, color: Color(0xFFF59E0B)),
          const SizedBox(width: 6),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: ratio.clamp(0.0, 1.0),
                minHeight: 5,
                backgroundColor: const Color(0xFFE2E8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFF59E0B),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 24,
            child: Text(
              "$count",
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 9.5,
                color: AppColors.textGrey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
