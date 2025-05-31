import 'dart:developer';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/auth_controller.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Observable variables for request counts
  final RxInt submittedCount = 0.obs;
  final RxInt rejectedCount = 0.obs;
  final RxInt approvedCount = 0.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchRequestCounts();
  }
  
  Future<void> fetchRequestCounts() async {
    try {
      // Get the current user's ID
      final String userId = Get.find<AuthController>().user.value?.uid ?? '';
      
      // Fetch counts from Firestore
      final QuerySnapshot submittedSnapshot = await _firestore
          .collection('requests')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'submitted')
          .get();
          
      final QuerySnapshot rejectedSnapshot = await _firestore
          .collection('requests')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'rejected')
          .get();
          
      final QuerySnapshot approvedSnapshot = await _firestore
          .collection('requests')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'approved')
          .get();
      
      // Update the counts
      submittedCount.value = submittedSnapshot.docs.length;
      rejectedCount.value = rejectedSnapshot.docs.length;
      approvedCount.value = approvedSnapshot.docs.length;
      
    } catch (e) {
      log('Error fetching request counts: $e');
      // You might want to show an error message to the user
    }
  }
} 