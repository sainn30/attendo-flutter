import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendo/utils/theme/app_colors.dart';
import '../controllers/all_employes_page_controller.dart';

class AllEmployesPageView extends GetView<AllEmployesPageController> {
  const AllEmployesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGrey50,
      body: RefreshIndicator(
        onRefresh: () async => controller.fetchAllTeams(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 🔹 Teams Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Teams",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.kBlue600,
                      ),
                ),
                IconButton(
                  onPressed: () => _showAddTeamSheet(context),
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppColors.kBlue600,
                ),
              ],
            ),
            const SizedBox(height: 8),

            Obx(() {
              if (controller.isTeamLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.teams.isEmpty) {
                return const Center(child: Text("No Teams Available"));
              }
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.teams.map((team) {
                  final isSelected = controller.selectedTeam.value == team;
                  return ChoiceChip(
                    label: Text(team),
                    selected: isSelected,
                    selectedColor: AppColors.kBlue900.withOpacity(0.15),
                    onSelected: (_) => controller.onTeamTap(team),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppColors.kBlue600
                          : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                    side: BorderSide(
                        color: isSelected
                            ? AppColors.kBlue600
                            : Colors.grey.shade300),
                    backgroundColor: Colors.white,
                  );
                }).toList(),
              );
            }),

            const SizedBox(height: 28),

            // 👥 Members Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Members",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.kBlue600,
                      ),
                ),
                IconButton(
                  onPressed: () => _showAddMemberSheet(context),
                  icon: const Icon(Icons.person_add_alt_1_outlined),
                  color: AppColors.kBlue600,
                ),
              ],
            ),
            const SizedBox(height: 8),

            Obx(() {
              if (controller.isMemberLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.members.isEmpty) {
                return const Center(child: Text("No Members Found"));
              }
              return Column(
                children: controller.members.map((member) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.kBlue900.withOpacity(0.15),
                        child: const Icon(
                          Icons.person_outline,
                          color: AppColors.kBlue600,
                        ),
                      ),
                      title: Text(
                        member["name"] ?? "-",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(member["email"] ?? "-"),
                          Text(
                            member["role"] ?? "-",
                            style: const TextStyle(
                              color: AppColors.kBlue600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert),
                        color: AppColors.kBlue600,
                        onPressed: () {},
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  // 🟦 Bottom Sheet: Add Team
  void _showAddTeamSheet(BuildContext context) {
    final nameController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add New Team",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.kBlue600),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Team name",
                  filled: true,
                  fillColor: AppColors.kGrey100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  controller.addTeam(nameController.text);
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kBlue600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text("Add Team"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // 🟦 Bottom Sheet: Add Member
  void _showAddMemberSheet(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    String role = "Employee";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add New Member",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.kBlue600),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Full name",
                  filled: true,
                  fillColor: AppColors.kGrey100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: AppColors.kGrey100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: role,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.kGrey100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: "Admin", child: Text("Admin")),
                  DropdownMenuItem(value: "Manager", child: Text("Manager")),
                  DropdownMenuItem(value: "Employee", child: Text("Employee")),
                ],
                onChanged: (val) => role = val ?? "Employee",
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  controller.addMember(
                    nameController.text,
                    emailController.text,
                    role,
                  );
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kBlue600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text("Add Member"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
