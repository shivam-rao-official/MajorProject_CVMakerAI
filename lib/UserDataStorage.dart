import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDataStorage extends GetxController {
 var name="".obs;
 var _email="".obs;
 var _phone="".obs;
 var _linkedInUrl="".obs;
 var _id="".obs;

 void saveUserData(String name, String email, String phone, String linkedInUrl, String id) {
   this.name.value = name;
   _email.value = email;
   _phone.value = phone;
   _linkedInUrl.value = linkedInUrl;
   _id.value = id;
 }

 String retrieveName() {
   return name.value;
 }
 String retrieveId() {
   return _id.value;
 }
 String retrieveEmail() {
   return _email.value;
 }
 String retrievePhone() {
   return _phone.value;
 }
 String retrieveLinkedInUrl() {
   return _linkedInUrl.value;
 }
}