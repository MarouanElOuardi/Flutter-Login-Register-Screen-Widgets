import 'package:flutter/material.dart';

class UserModel{
  final String firstName;
  final String lastName;
  final String gender;
  final String profession;

 const UserModel({
  required this.firstName,
  required this.lastName,
  required this.gender,
  required this.profession,
 });
 toJson(){
  return {
    "FirstName": firstName,
    "LastName" : lastName,
    "Gender": gender,
    "Profession": profession,
  };
 }
}