import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/enums/expense_type_enum.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/models/group.dart';
import 'package:projet_picsou/models/participant.dart';
import 'package:projet_picsou/services/expense_service.dart';
import 'package:projet_picsou/services/friend_service.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:projet_picsou/widgets/expense/create_expense_step_1_widget.dart';
import 'package:provider/provider.dart';
import '../../core/custom_navigator.dart';
import '../../main.dart';
import '../../models/contributor.dart';
import '../../models/expense.dart';
import '../../models/friend.dart';
import '../../models/user.dart';
import '../../services/group_service.dart';
import '../../widgets/expense/create_expense_step_2_widget.dart';
import '../../widgets/expense/create_expense_step_3_widget.dart';
import '../../widgets/expense/create_expense_step_4_widget.dart';

enum CreateExpenseStep {
  step1(1),
  step2(2),
  step3(3),
  step4(4);

  final int number;
  const CreateExpenseStep(this.number);

  static CreateExpenseStep fromIndex(int index) {
    return CreateExpenseStep.values.firstWhere(
          (step) => step.number == index,
      orElse: () => CreateExpenseStep.step1,
    );
  }

  Widget get page {
    switch (this) {
      case CreateExpenseStep.step1:
        return CreateExpenseStep1Widget();
      case CreateExpenseStep.step2:
        return CreateExpenseStep2Widget();
      case CreateExpenseStep.step3:
        return CreateExpenseStep3Widget();
      case CreateExpenseStep.step4:
        return CreateExpenseStep4Widget();
    }
  }
}

class CreateExpenseController with ChangeNotifier {
  //services
  final UserService userService;
  final FriendService friendService;
  final GroupService groupService;
  final ExpenseService expenseService;

  //values
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  Group? selectedGroup;
  User? selectedFriend;

  ExpenseTypeEnum expenseType = ExpenseTypeEnum.stock;

  List<Contributor> contributors = [];
  List<Participant> participants = [];
  List<UserWithStatus> groupMembers = [];
  List<Group> groups = [];
  List<Group> discussions = [];
  List<User> friends = [];
  bool isDiscussion = false;
  int totalAmount = 0;
  int currentStepIndex = 1;
  DateTime date = DateTime.now();

  CreateExpenseController(
    this.userService,
    this.friendService,
    this.groupService,
      this.expenseService
  );

  void selectGroup(Group group, {bool discussion = false}) {
    selectedFriend = null;
    selectedGroup = group;
    isDiscussion = discussion;
    notifyListeners();
  }

  void selectFriend(User friend) {
    selectedGroup = null;
    selectedFriend = friend;
    notifyListeners();
  }

  void toggleContributor(UserWithStatus user) {
    if (isContributor(user)) {
      contributors.removeWhere((c) => c.groupUserId == user.groupUserId);
    } else {
      contributors.add(Contributor(null, 0.0, user.groupUserId, null));
    }
    notifyListeners();
  }

  void updateAmountForContributor(UserWithStatus user, double amount) {
    int index = contributors.indexWhere(
      (c) => c.groupUserId == user.groupUserId,
    );
    if (index != -1) {
      contributors[index] = Contributor(
        contributors[index].id,
        amount,
        user.groupUserId,
        contributors[index].expenseId,
      );
    }
    notifyListeners();
  }

  bool isContributor(UserWithStatus user) {
    return contributors.any((c) => c.groupUserId == user.groupUserId);
  }

  void addParticipant(UserWithStatus user) {
    if (!participants.any((p) => p.groupUserId == user.groupUserId)) {
      participants.add(
        Participant(
          null,
          0.0,
          user.groupUserId,
          0,
          null,
        ),
      );
      increaseParticipantPartNumber(user);
    }
    notifyListeners();
  }

  void toggleParticipant(UserWithStatus user) {
    if (isParticipant(user)) {
      removeParticipant(user);
    } else {
      addParticipant(user);
    }
    notifyListeners();
  }

  bool isParticipant(UserWithStatus user) {
    return participants.any((p) => p.groupUserId == user.groupUserId);
  }

  void removeParticipant(UserWithStatus user) {
    updatePartNumberForParticipant(user, 0);
    participants.removeWhere((p) => p.groupUserId == user.groupUserId);
    notifyListeners();
  }

  int getPartNumberForParticipant(UserWithStatus user) {
    int index = participants.indexWhere(
      (p) => p.groupUserId == user.groupUserId,
    );
    if (index != -1) {
      return participants[index].partNumber ?? 1;
    }
    return 1; // Default part number if not found
  }

  double getAmountForParticipant(UserWithStatus user) {
    int index = participants.indexWhere(
      (p) => p.groupUserId == user.groupUserId,
    );
    if (index != -1) {
      return participants[index].amountParticipated;
    }
    return 0.0; // Default amount if not found
  }

  void increaseParticipantPartNumber(UserWithStatus user) {
    if (expenseType == ExpenseTypeEnum.amount) {
      return;
    }
    int index = participants.indexWhere(
      (p) => p.groupUserId == user.groupUserId,
    );
    if (index != -1) {
      updatePartNumberForParticipant(
          user,
          participants[index].partNumber != null ? participants[index].partNumber! +1 : 1
      );
      notifyListeners();
    }
  }

  void decreaseParticipantPartNumber(UserWithStatus user) {
    if (expenseType == ExpenseTypeEnum.amount) {
      return;
    }

    int index = participants.indexWhere(
      (p) => p.groupUserId == user.groupUserId,
    );
    if (index != -1) {
      //on descend pas en dessous de 1 part
      if (participants[index].partNumber != null &&
          participants[index].partNumber == 1) {
        return;
      }
      updatePartNumberForParticipant(
          user,
          participants[index].partNumber != null ? participants[index].partNumber! -1 : 1
      );
      notifyListeners();
    }
  }

  void updatePartNumberForParticipant(UserWithStatus user, int partNumber) {
    if (expenseType == ExpenseTypeEnum.amount) {
      return;
    }
    int index = participants.indexWhere(
          (p) => p.groupUserId == user.groupUserId,
    );
    if (index != -1) {
      participants[index] = Participant(
        participants[index].id,
        participants[index].amountParticipated, // temporaire, recalculé après
        user.groupUserId,
        partNumber,
        participants[index].expenseId,
      );

      // Recalcul du montant pour chaque participant selon le nombre de parts
      int totalParts = participants.fold(0, (sum, p) => sum + (p.partNumber ?? 0));
      if (totalParts > 0) {
        for (int i = 0; i < participants.length; i++) {
          final p = participants[i];
          double amount = ((totalAmount * (p.partNumber ?? 0)) / totalParts * 100).round() / 100;
          participants[i] = Participant(
            p.id,
            amount,
            p.groupUserId,
            p.partNumber,
            p.expenseId,
          );
        }
      }
    }
    notifyListeners();
  }

  void updateAmountForParticipant(UserWithStatus user, double amount) {
    if (expenseType == ExpenseTypeEnum.stock) {
      return;
    }
    int index = participants.indexWhere(
      (p) => p.groupUserId == user.groupUserId,
    );
    if (index != -1) {
      participants[index] = Participant(
        participants[index].id,
        amount,
        user.groupUserId,
        participants[index].partNumber,
        participants[index].expenseId,
      );
    }
    notifyListeners();
  }

  void setExpenseType(ExpenseTypeEnum type) {
    expenseType = type;
    notifyListeners();
  }

  void setDate(DateTime newDate) {
    date = newDate;
    notifyListeners();
  }

  Future<void> nextStep() async {
    if (currentStepIndex < CreateExpenseStep.values.length) {
      if (currentStepIndex == 1) {
        DialogBuilder.loading();
        groupMembers = await groupService.getUserFromGroup(selectedGroup!.id!);
        DialogBuilder.closeCurrentDialog();
      }
      if (currentStepIndex == 2) {
        totalAmount = contributors.fold(
          0,
          (sum, c) => sum + c.amountContributed.toInt(),
        );
      }
      currentStepIndex++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (currentStepIndex > 1) {
      currentStepIndex--;
      notifyListeners();
    }
  }

  bool canGoToNextStep() {
    switch (currentStepIndex) {
      case 1:
        return selectedGroup != null;
      case 2:
        return contributors.isNotEmpty &&
            contributors.every((c) => c.amountContributed > 0);
      case 3:
        return participants.isNotEmpty &&
            participants.every((c) => c.amountParticipated > 0) &&
            ((participants.fold(0.0, (sum, c) => sum + c.amountParticipated) - totalAmount).abs() <= 0.1);
      case 4:
        return true; // Final step, always can go next
      default:
        return false;
    }
  }

  bool canGoToPreviousStep() {
    return currentStepIndex > 1;
  }

  Future<void> createDiscussion() async {
    if (selectedFriend == null) {
      return;
    }

    DialogBuilder.loading();

    try {
      GroupWithUser newGroup = GroupWithUser(
        Group(
          null,
          "discussion-${selectedFriend!.id}-${User.getCurrentUserInstance().id}",
          "https://s.yimg.com/ny/api/res/1.2/Onq1adoghZAHhpsXXmF8Pw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyNDI7aD05MzE-/https://media.zenfs.com/en/insider_articles_922/c6ce8d0b9a7b28f9c2dee8171da98b8f",
        ),
        [
          UserIdWithStatus(User.getCurrentUserInstance().id, UserStatus.owner),
          UserIdWithStatus(selectedFriend!.id, UserStatus.trustedDelegate),
        ],
      );
      await groupService.createGroup(newGroup);
      await initData();
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }
  }

  Future<void> createExpense() async {
    if (nameController.text.isEmpty) {
      DialogBuilder.warning("Nom vide", "Veuillez entrer un nom pour la dépense.");
      return;
    }

    if (date.isAfter(DateTime.now())) {
      DialogBuilder.warning("Date future", "La date de la dépense ne peut pas être dans le futur.");
      return;
    }

    for (int i = 0; i < participants.length; i++) {
      final p = participants[i];
      participants[i] = Participant(
        p.id,
        p.amountParticipated,
        p.groupUserId,
        0,
        p.expenseId,
      );
    }

    DetailedExpense expense = DetailedExpense(
      Expense(
        null,
        nameController.text,
        descriptionController.text,
        date,
        totalAmount.toDouble(),
          0 //participants.fold(0, (sum, p) => sum + (p.partNumber ?? 0))
      ),
      contributors,
      participants,
      null
    );

    DialogBuilder.loading();

    try {
      await expenseService.createExpense(expense, selectedGroup!.id!);
      DialogBuilder.closeCurrentDialog();
      CustomNavigator.back();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (e) {
      print(e);
      DialogBuilder.appError();
    }
  }

  void reset() {
    nameController.clear();
    descriptionController.clear();
    selectedGroup = null;
    selectedFriend = null;
    expenseType = ExpenseTypeEnum.stock;
    contributors = [];
    participants = [];
    groupMembers = [];
    groups = [];
    discussions = [];
    friends = [];
    isDiscussion = false;
    totalAmount = 0;
    currentStepIndex = 1;
    date = DateTime.now();
    notifyListeners();
  }

  Future<void> initData() async {
    DialogBuilder.loading();
    try {
      friends = [];
      discussions = [];
      contributors = [];
      participants = [];
      friends = await friendService.getAllFriendsAsUser();
      groups = await groupService.getAllGroups();
      List<Group> toRemove = [];
      for (Group group in groups) {
        List<UserWithStatus> discussionUsers = await groupService
            .getUserFromGroup(group.id!);
        if (discussionUsers.length == 2) {
          discussions.add(groupService.groupDataFromDiscussion(group, discussionUsers));
          friends.removeWhere(
            (f) => discussionUsers.any((u) => u.user.id == f.id),
          );
          toRemove.add(group);
        }
      }
      groups.removeWhere((g) => toRemove.contains(g));
      DialogBuilder.closeCurrentDialog();
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (e) {
      print(e);
      DialogBuilder.appError();
    }
  }
}
