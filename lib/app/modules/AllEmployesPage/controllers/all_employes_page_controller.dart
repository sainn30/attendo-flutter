import 'package:get/get.dart';

class AllEmployesPageController extends GetxController {
  var teams = <String>["Development Team", "Design Team", "Marketing Team"].obs;
  var selectedTeam = "Development Team".obs;

  var isTeamLoading = false.obs;
  var isMemberLoading = false.obs;

  var members = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMembersbyTeams(selectedTeam.value);
  }

  void fetchAllTeams() async {
    isTeamLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 400));
    isTeamLoading.value = false;
  }

  void onTeamTap(String team) {
    selectedTeam.value = team;
    fetchMembersbyTeams(team);
  }

  void fetchMembersbyTeams(String team) async {
    isMemberLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));

    if (team.contains("Development")) {
      members.value = [
        {"name": "Alice Dev", "email": "alice.dev@email.com", "role": "Admin"},
        {"name": "Bob Code", "email": "bob.code@email.com", "role": "Employee"},
      ];
    } else if (team.contains("Design")) {
      members.value = [
        {"name": "Clara Art", "email": "clara.art@email.com", "role": "Manager"},
        {"name": "David Draw", "email": "david.draw@email.com", "role": "Employee"},
      ];
    } else {
      members.value = [
        {"name": "Evelyn Ads", "email": "evelyn.ads@email.com", "role": "Manager"},
      ];
    }

    isMemberLoading.value = false;
  }

  void addTeam(String teamName) {
    if (teamName.isNotEmpty) {
      teams.add(teamName);
      Get.back();
      Get.snackbar("Success", "Team '$teamName' added!");
    }
  }

  void addMember(String fullName, String email, String role) {
    if (fullName.isEmpty || email.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }
    members.add({"name": fullName, "email": email, "role": role});
    Get.back();
    Get.snackbar("Success", "Member '$fullName' added!");
  }
}
