import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/auth_controller.dart';

class RequestController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthController _authController = Get.find<AuthController>();

  // Form fields
  final title = ''.obs;
  final description = ''.obs;
  final selectedType = ''.obs;
  final selectedPriority = ''.obs;
  final status = 'pending'.obs;

  // Dropdown options
  final requestTypes = [
    'Leave Request',
    'Equipment Request',
    'Training Request',
    'Other'
  ];

  final priorityLevels = [
    'Low',
    'Medium',
    'High',
    'Urgent'
  ];

  // Form validation
  bool get isFormValid => 
    title.value.isNotEmpty && 
    description.value.isNotEmpty && 
    selectedType.value.isNotEmpty && 
    selectedPriority.value.isNotEmpty;

  // Submit request to Firestore
  Future<void> submitRequest() async {
    try {
      if (!isFormValid) {
        Get.snackbar(
          'Error',
          'Please fill in all fields',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final user = _authController.user.value;
      if (user == null) {
        Get.snackbar(
          'Error',
          'User not authenticated',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      await _firestore.collection('requests').add({
        'title': title.value,
        'description': description.value,
        'type': selectedType.value,
        'priority': selectedPriority.value,
        'status': status.value,
        'userId': user.uid,
        'userEmail': user.email,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar(
        'Success',
        'Request submitted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Reset form
      title.value = '';
      description.value = '';
      selectedType.value = '';
      selectedPriority.value = '';
      status.value = 'pending';

      // Navigate back
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit request: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
} 