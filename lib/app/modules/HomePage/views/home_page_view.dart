import 'package:flutter/material.dart';
import 'package:attendo/utils/theme/app_colors.dart';
import 'package:attendo/widgets/swipebutton/swipe_button.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGrey50,
      body: ListView(
        children: [
          // 👤 User Profile
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  minRadius: 35,
                  backgroundColor: AppColors.kBlue900,
                  child: Icon(Icons.person, color: AppColors.white, size: 35),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Doe",
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.kBlue900,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      "Tech Company Inc.",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.kGrey300,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_active_outlined,
                    color: AppColors.kBlue900,
                  ),
                ),
              ],
            ),
          ),

          // 📅 Date Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(
                7,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: index == 0
                          ? AppColors.kBlue900
                          : AppColors.kGrey100,
                    ),
                    child: Text(
                      "Oct ${15 + index}",
                      style: TextStyle(
                        color: index == 0
                            ? AppColors.white
                            : AppColors.kBlack900,
                        fontWeight: index == 0
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 28),

          // ⏱ Today Attendance
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  "Today Attendance",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.kBlue900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.analytics_outlined,
                    color: AppColors.kBlue900,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 🕐 Check In & Out
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildBlueCard(
                    context,
                    Icons.login_rounded,
                    "Check In",
                    "08:15 AM",
                    "On time",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildBlueCard(
                    context,
                    Icons.logout_rounded,
                    "Check Out",
                    "05:30 PM",
                    "Completed",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ☕ Break Time & Total Days
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildBlueCard(
                    context,
                    Icons.free_breakfast_outlined,
                    "Break Time",
                    "00:30 min",
                    "Avg 25min",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildBlueCard(
                    context,
                    Icons.calendar_today_outlined,
                    "Total Days",
                    "22",
                    "Working Days/M",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ⏰ Total Working Time
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildBlueCard(
              context,
              Icons.work_history_outlined,
              "Total Working Hours",
              "08:40 hrs",
              "-",
            ),
          ),

          const SizedBox(height: 20),

          // 📋 Your Activity
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Your Activity",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.kBlue900,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Swipe Button Placeholder
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SwipeButton.expand(
              activeTrackColor: AppColors.kBlue900,
              activeThumbColor: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              height: 58,
              elevationThumb: 2,
              elevationTrack: 0,
              child: const Text(
                "Swipe to Check Out",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              thumb: const Icon(
                Icons.double_arrow_rounded,
                color: AppColors.kBlue900,
              ),  
            ),
          ),

          const SizedBox(height: 28),
        ],
      ),
    );
  }

  // 💠 Blue Card Component
  Widget _buildBlueCard(
    BuildContext context,
    IconData iconData,
    String title,
    String time,
    String description,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.kBlue600.withOpacity(.2)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.kBlue600.withOpacity(.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.kBlue600.withOpacity(.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(iconData, size: 20, color: AppColors.kBlue900),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.kBlack900,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            time,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.kBlue900,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.kGrey300),
          ),
        ],
      ),
    );
  }
}
