import 'package:flutter/material.dart';
import 'package:attendo/utils/theme/app_colors.dart';

class LeavePageView extends StatelessWidget {
  const LeavePageView({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Dummy data
    final totalCount = {
      'paidLeaveBalance': 5,
      'casualAndSickLeaveBalance': 3,
      'totalWFHbalance': 2,
    };

    final leaveTabs = ['Pending', 'Approved', 'Rejected'];
    String selectedTab = 'Pending';

    final leaveActivities = [
      {'name': 'Annual Leave', 'date': '12 Oct - 14 Oct', 'status': 'Pending'},
      {'name': 'Sick Leave', 'date': '5 Oct', 'status': 'Approved'},
    ];

    return Scaffold(
      backgroundColor: AppColors.kGrey50,
      appBar: AppBar(
        backgroundColor: AppColors.kGrey50,
        title: const Text(
          "All Leaves",
          style: TextStyle(
            color: AppColors.kBlue900,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh, color: AppColors.kBlue900),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: AppColors.kBlue900),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Overview Balances
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildOverviewCard(
                    "Paid",
                    "Leave",
                    totalCount['paidLeaveBalance'],
                    AppColors.kBlue900,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildOverviewCard(
                    "Casual/Sick",
                    "Leave",
                    totalCount['casualAndSickLeaveBalance'],
                    AppColors.kBlue600,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildOverviewCard(
                    "WFH",
                    "Balance",
                    totalCount['totalWFHbalance'],
                    AppColors.kOrange500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🔹 Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: leaveTabs.map((e) {
                final isSelected = e == selectedTab;
                return Expanded(
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(14),
                    child: Ink(
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.kBlue900
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.kBlue900
                              : AppColors.kBlue600.withOpacity(.3),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          e,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.kBlue900,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 14),

          // 🔹 Leave list
          Expanded(
            child: leaveActivities.isEmpty
                ? const Center(
                    child: Text(
                      "No Data Found",
                      style: TextStyle(color: AppColors.kGrey300),
                    ),
                  )
                : ListView.builder(
                    itemCount: leaveActivities.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemBuilder: (context, index) {
                      final item = leaveActivities[index];
                      final status = item['status'] ?? '';
                      Color statusColor;
                      if (status == 'Approved') {
                        statusColor = Colors.green;
                      } else if (status == 'Rejected') {
                        statusColor = Colors.redAccent;
                      } else {
                        statusColor = Colors.orange;
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.kBlue600.withOpacity(.2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.kBlue600.withOpacity(.08),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.kBlue600.withOpacity(.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.calendar_today_outlined,
                              color: AppColors.kBlue900,
                            ),
                          ),
                          title: Text(
                            item['name'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.kBlack900,
                            ),
                          ),
                          subtitle: Text(
                            item['date'] ?? '',
                            style: const TextStyle(color: AppColors.kGrey300),
                          ),
                          trailing: Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(
    String prefix,
    String label,
    int? count,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            prefix,
            style: const TextStyle(
              color: AppColors.kBlack900,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.kBlack900,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            (count ?? '-').toString(),
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
