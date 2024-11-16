// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `My job`
  String get myJob {
    return Intl.message(
      'My job',
      name: 'myJob',
      desc: '',
      args: [],
    );
  }

  /// `No Blog found`
  String get noBlogFound {
    return Intl.message(
      'No Blog found',
      name: 'noBlogFound',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don’t have an account?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your Password`
  String get yourPassword {
    return Intl.message(
      'Your Password',
      name: 'yourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login with Email`
  String get loginWithEmail {
    return Intl.message(
      'Login with Email',
      name: 'loginWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `Login with your registered Email ID & password to continue.`
  String get loginWithYourRegisteredEmailIdPasswordToContinue {
    return Intl.message(
      'Login with your registered Email ID & password to continue.',
      name: 'loginWithYourRegisteredEmailIdPasswordToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Login to continue`
  String get loginToContinue {
    return Intl.message(
      'Login to continue',
      name: 'loginToContinue',
      desc: '',
      args: [],
    );
  }

  /// `STEP {count}`
  String stepCount(Object count) {
    return Intl.message(
      'STEP $count',
      name: 'stepCount',
      desc: '',
      args: [count],
    );
  }

  /// `Tell us Your Details`
  String get tellUsYourDetails {
    return Intl.message(
      'Tell us Your Details',
      name: 'tellUsYourDetails',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email ID`
  String get enterEmailId {
    return Intl.message(
      'Enter Email ID',
      name: 'enterEmailId',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enterPassword {
    return Intl.message(
      'Enter Password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enterYourName {
    return Intl.message(
      'Enter your name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Phone no.`
  String get phoneNo {
    return Intl.message(
      'Phone no.',
      name: 'phoneNo',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Married`
  String get married {
    return Intl.message(
      'Married',
      name: 'married',
      desc: '',
      args: [],
    );
  }

  /// `Unmarried`
  String get unmarried {
    return Intl.message(
      'Unmarried',
      name: 'unmarried',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get others {
    return Intl.message(
      'Others',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `Tell us Your Education`
  String get tellUsYourEducation {
    return Intl.message(
      'Tell us Your Education',
      name: 'tellUsYourEducation',
      desc: '',
      args: [],
    );
  }

  /// `Enter your highest education`
  String get enterYourHighestEducation {
    return Intl.message(
      'Enter your highest education',
      name: 'enterYourHighestEducation',
      desc: '',
      args: [],
    );
  }

  /// `Course name`
  String get courseName {
    return Intl.message(
      'Course name',
      name: 'courseName',
      desc: '',
      args: [],
    );
  }

  /// `University name`
  String get universityName {
    return Intl.message(
      'University name',
      name: 'universityName',
      desc: '',
      args: [],
    );
  }

  /// `Year of passing`
  String get yearOfPassing {
    return Intl.message(
      'Year of passing',
      name: 'yearOfPassing',
      desc: '',
      args: [],
    );
  }

  /// `Job preference`
  String get jobPreference {
    return Intl.message(
      'Job preference',
      name: 'jobPreference',
      desc: '',
      args: [],
    );
  }

  /// `Job 1`
  String get job1 {
    return Intl.message(
      'Job 1',
      name: 'job1',
      desc: '',
      args: [],
    );
  }

  /// `Enter your job`
  String get enterYourJob {
    return Intl.message(
      'Enter your job',
      name: 'enterYourJob',
      desc: '',
      args: [],
    );
  }

  /// `No job found`
  String get noJobFound {
    return Intl.message(
      'No job found',
      name: 'noJobFound',
      desc: '',
      args: [],
    );
  }

  /// `Job 2`
  String get job2 {
    return Intl.message(
      'Job 2',
      name: 'job2',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message(
      'Read more',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `Read less`
  String get readLess {
    return Intl.message(
      'Read less',
      name: 'readLess',
      desc: '',
      args: [],
    );
  }

  /// `STEP`
  String get step {
    return Intl.message(
      'STEP',
      name: 'step',
      desc: '',
      args: [],
    );
  }

  /// `Send otp`
  String get sendOtp {
    return Intl.message(
      'Send otp',
      name: 'sendOtp',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive the code?`
  String get didntReceiveTheCode {
    return Intl.message(
      'Didn\'t receive the code?',
      name: 'didntReceiveTheCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the otp that has been sent to your`
  String get pleaseEnterTheOtpThatHasBeenSentToYour {
    return Intl.message(
      'Please enter the otp that has been sent to your',
      name: 'pleaseEnterTheOtpThatHasBeenSentToYour',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP`
  String get verifyOtp {
    return Intl.message(
      'Verify OTP',
      name: 'verifyOtp',
      desc: '',
      args: [],
    );
  }

  /// `Register to continue`
  String get registerToContinue {
    return Intl.message(
      'Register to continue',
      name: 'registerToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Provide with your email & verify OTP to Register.`
  String get provideWithYourEmailVerifyOtpToRegister {
    return Intl.message(
      'Provide with your email & verify OTP to Register.',
      name: 'provideWithYourEmailVerifyOtpToRegister',
      desc: '',
      args: [],
    );
  }

  /// `email ID`
  String get emailId {
    return Intl.message(
      'email ID',
      name: 'emailId',
      desc: '',
      args: [],
    );
  }

  /// `Enter new password`
  String get enterNewPassword {
    return Intl.message(
      'Enter new password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Designation`
  String get designation {
    return Intl.message(
      'Designation',
      name: 'designation',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Responsibility`
  String get responsibility {
    return Intl.message(
      'Responsibility',
      name: 'responsibility',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Organisation`
  String get organisation {
    return Intl.message(
      'Organisation',
      name: 'organisation',
      desc: '',
      args: [],
    );
  }

  /// `*required`
  String get required {
    return Intl.message(
      '*required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email id.`
  String get invalidEmailId {
    return Intl.message(
      'Invalid email id.',
      name: 'invalidEmailId',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone no.`
  String get invalidPhoneNo {
    return Intl.message(
      'Invalid phone no.',
      name: 'invalidPhoneNo',
      desc: '',
      args: [],
    );
  }

  /// `Please enter pin to continue`
  String get pleaseEnterPinToContinue {
    return Intl.message(
      'Please enter pin to continue',
      name: 'pleaseEnterPinToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Please enter new password & confirm it to reset password`
  String get pleaseEnterNewPasswordConfirmItToResetPassword {
    return Intl.message(
      'Please enter new password & confirm it to reset password',
      name: 'pleaseEnterNewPasswordConfirmItToResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordIsRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Length should be more than 8 & Must contain digit, symbols and mix case letters`
  String get lengthShouldBeMoreThan8MustContainDigitSymbols {
    return Intl.message(
      'Length should be more than 8 & Must contain digit, symbols and mix case letters',
      name: 'lengthShouldBeMoreThan8MustContainDigitSymbols',
      desc: '',
      args: [],
    );
  }

  /// `Passwords didn't match.`
  String get passwordsDidntMatch {
    return Intl.message(
      'Passwords didn\'t match.',
      name: 'passwordsDidntMatch',
      desc: '',
      args: [],
    );
  }

  /// `Provide your Email address & set a password to proceed.`
  String get provideYourEmailAddressSetAPasswordToProceed {
    return Intl.message(
      'Provide your Email address & set a password to proceed.',
      name: 'provideYourEmailAddressSetAPasswordToProceed',
      desc: '',
      args: [],
    );
  }

  /// `Personal Details`
  String get personalDetails {
    return Intl.message(
      'Personal Details',
      name: 'personalDetails',
      desc: '',
      args: [],
    );
  }

  /// `Marital Status`
  String get maritalStatus {
    return Intl.message(
      'Marital Status',
      name: 'maritalStatus',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Education Details`
  String get educationDetails {
    return Intl.message(
      'Education Details',
      name: 'educationDetails',
      desc: '',
      args: [],
    );
  }

  /// `Highest Education`
  String get highestEducation {
    return Intl.message(
      'Highest Education',
      name: 'highestEducation',
      desc: '',
      args: [],
    );
  }

  /// `Course`
  String get course {
    return Intl.message(
      'Course',
      name: 'course',
      desc: '',
      args: [],
    );
  }

  /// `University`
  String get university {
    return Intl.message(
      'University',
      name: 'university',
      desc: '',
      args: [],
    );
  }

  /// `Employment Details`
  String get employmentDetails {
    return Intl.message(
      'Employment Details',
      name: 'employmentDetails',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Primary Job Preference`
  String get primaryJobPreference {
    return Intl.message(
      'Primary Job Preference',
      name: 'primaryJobPreference',
      desc: '',
      args: [],
    );
  }

  /// `Secondary Job Preference`
  String get secondaryJobPreference {
    return Intl.message(
      'Secondary Job Preference',
      name: 'secondaryJobPreference',
      desc: '',
      args: [],
    );
  }

  /// `Logout?`
  String get logout {
    return Intl.message(
      'Logout?',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to logout?`
  String get areYouSureWantToLogout {
    return Intl.message(
      'Are you sure want to logout?',
      name: 'areYouSureWantToLogout',
      desc: '',
      args: [],
    );
  }

  /// `Choose from a source`
  String get chooseFromASource {
    return Intl.message(
      'Choose from a source',
      name: 'chooseFromASource',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Please allow permission to upload image.`
  String get pleaseAllowPermissionToUploadImage {
    return Intl.message(
      'Please allow permission to upload image.',
      name: 'pleaseAllowPermissionToUploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Crop Your Image`
  String get cropYourImage {
    return Intl.message(
      'Crop Your Image',
      name: 'cropYourImage',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Connection lost`
  String get connectionLost {
    return Intl.message(
      'Connection lost',
      name: 'connectionLost',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get reload {
    return Intl.message(
      'Reload',
      name: 'reload',
      desc: '',
      args: [],
    );
  }

  /// `Empty`
  String get empty {
    return Intl.message(
      'Empty',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Language`
  String get chooseYourLanguage {
    return Intl.message(
      'Choose Your Language',
      name: 'chooseYourLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Referral`
  String get referral {
    return Intl.message(
      'Referral',
      name: 'referral',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Enter refer code`
  String get enterReferCode {
    return Intl.message(
      'Enter refer code',
      name: 'enterReferCode',
      desc: '',
      args: [],
    );
  }

  /// `Referral program`
  String get referralProgram {
    return Intl.message(
      'Referral program',
      name: 'referralProgram',
      desc: '',
      args: [],
    );
  }

  /// `Refer and earn`
  String get referAndEarn {
    return Intl.message(
      'Refer and earn',
      name: 'referAndEarn',
      desc: '',
      args: [],
    );
  }

  /// `Introduce & refer us to\nyour friends & get rewarded`
  String get introduceReferUsTonyourFriendsGetRewarded {
    return Intl.message(
      'Introduce & refer us to\nyour friends & get rewarded',
      name: 'introduceReferUsTonyourFriendsGetRewarded',
      desc: '',
      args: [],
    );
  }

  /// `How it works:`
  String get howItWorks {
    return Intl.message(
      'How it works:',
      name: 'howItWorks',
      desc: '',
      args: [],
    );
  }

  /// `Your referral code`
  String get yourReferralCode {
    return Intl.message(
      'Your referral code',
      name: 'yourReferralCode',
      desc: '',
      args: [],
    );
  }

  /// `Code copied to clipboard.`
  String get codeCopiedToClipboard {
    return Intl.message(
      'Code copied to clipboard.',
      name: 'codeCopiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `TAP TO COPY`
  String get tapToCopy {
    return Intl.message(
      'TAP TO COPY',
      name: 'tapToCopy',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Good Morning`
  String get goodMorning {
    return Intl.message(
      'Good Morning',
      name: 'goodMorning',
      desc: '',
      args: [],
    );
  }

  /// `Good Afternoon`
  String get goodAfternoon {
    return Intl.message(
      'Good Afternoon',
      name: 'goodAfternoon',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening`
  String get goodEvening {
    return Intl.message(
      'Good Evening',
      name: 'goodEvening',
      desc: '',
      args: [],
    );
  }

  /// `Good Night`
  String get goodNight {
    return Intl.message(
      'Good Night',
      name: 'goodNight',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Applied`
  String get applied {
    return Intl.message(
      'Applied',
      name: 'applied',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Some error occurred`
  String get someErrorOccurred {
    return Intl.message(
      'Some error occurred',
      name: 'someErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `No notifications found`
  String get noNotificationsFound {
    return Intl.message(
      'No notifications found',
      name: 'noNotificationsFound',
      desc: '',
      args: [],
    );
  }

  /// `Featured Jobs`
  String get featuredJobs {
    return Intl.message(
      'Featured Jobs',
      name: 'featuredJobs',
      desc: '',
      args: [],
    );
  }

  /// `Featured job`
  String get featuredJob {
    return Intl.message(
      'Featured job',
      name: 'featuredJob',
      desc: '',
      args: [],
    );
  }

  /// `My applications`
  String get myApplications {
    return Intl.message(
      'My applications',
      name: 'myApplications',
      desc: '',
      args: [],
    );
  }

  /// `No jobs found`
  String get noJobsFound {
    return Intl.message(
      'No jobs found',
      name: 'noJobsFound',
      desc: '',
      args: [],
    );
  }

  /// `No active jobs found`
  String get noActiveJobsFound {
    return Intl.message(
      'No active jobs found',
      name: 'noActiveJobsFound',
      desc: '',
      args: [],
    );
  }

  /// `Recommended for you`
  String get recommendedForYou {
    return Intl.message(
      'Recommended for you',
      name: 'recommendedForYou',
      desc: '',
      args: [],
    );
  }

  /// `Introduce Myjob to your friends,\nfamily & colleagues and get a chance\nto win awesome rewards`
  String get introduceMyjobToYourFriendsFamilyColleaguesAndGetA {
    return Intl.message(
      'Introduce Myjob to your friends,\nfamily & colleagues and get a chance\nto win awesome rewards',
      name: 'introduceMyjobToYourFriendsFamilyColleaguesAndGetA',
      desc: '',
      args: [],
    );
  }

  /// `My Application`
  String get myApplication {
    return Intl.message(
      'My Application',
      name: 'myApplication',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Login now to continue.`
  String get loginNowToContinue {
    return Intl.message(
      'Login now to continue.',
      name: 'loginNowToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone no`
  String get enterPhoneNo {
    return Intl.message(
      'Enter phone no',
      name: 'enterPhoneNo',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP`
  String get enterOtp {
    return Intl.message(
      'Enter OTP',
      name: 'enterOtp',
      desc: '',
      args: [],
    );
  }

  /// `Your profile is {percentage}% Complete`
  String yourProfileIsPercentageComplete(Object percentage) {
    return Intl.message(
      'Your profile is $percentage% Complete',
      name: 'yourProfileIsPercentageComplete',
      desc: '',
      args: [percentage],
    );
  }

  /// `Register now to\ncontinue.`
  String get registerNowToncontinue {
    return Intl.message(
      'Register now to\ncontinue.',
      name: 'registerNowToncontinue',
      desc: '',
      args: [],
    );
  }

  /// `Please specify the user type to proceed`
  String get pleaseSpecifyTheUserTypeToProceed {
    return Intl.message(
      'Please specify the user type to proceed',
      name: 'pleaseSpecifyTheUserTypeToProceed',
      desc: '',
      args: [],
    );
  }

  /// `Job Seeker`
  String get jobSeeker {
    return Intl.message(
      'Job Seeker',
      name: 'jobSeeker',
      desc: '',
      args: [],
    );
  }

  /// `Organization`
  String get organization {
    return Intl.message(
      'Organization',
      name: 'organization',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Applications`
  String get applications {
    return Intl.message(
      'Applications',
      name: 'applications',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get viewAll {
    return Intl.message(
      'View all',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Hello,`
  String get hello {
    return Intl.message(
      'Hello,',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get newValue {
    return Intl.message(
      'New',
      name: 'newValue',
      desc: '',
      args: [],
    );
  }

  /// `Based on your profile`
  String get basedOnYourProfile {
    return Intl.message(
      'Based on your profile',
      name: 'basedOnYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `Recommended jobs`
  String get recommendedJobs {
    return Intl.message(
      'Recommended jobs',
      name: 'recommendedJobs',
      desc: '',
      args: [],
    );
  }

  /// `Top companies`
  String get topCompanies {
    return Intl.message(
      'Top companies',
      name: 'topCompanies',
      desc: '',
      args: [],
    );
  }

  /// `Recently looked jobs`
  String get recentlyLookedJobs {
    return Intl.message(
      'Recently looked jobs',
      name: 'recentlyLookedJobs',
      desc: '',
      args: [],
    );
  }

  /// `Our blogs`
  String get ourBlogs {
    return Intl.message(
      'Our blogs',
      name: 'ourBlogs',
      desc: '',
      args: [],
    );
  }

  /// `Please select your profile picture`
  String get pleaseSelectYourProfilePicture {
    return Intl.message(
      'Please select your profile picture',
      name: 'pleaseSelectYourProfilePicture',
      desc: '',
      args: [],
    );
  }

  /// `No history found`
  String get noHistoryFound {
    return Intl.message(
      'No history found',
      name: 'noHistoryFound',
      desc: '',
      args: [],
    );
  }

  /// `Please search something`
  String get pleaseSearchSomething {
    return Intl.message(
      'Please search something',
      name: 'pleaseSearchSomething',
      desc: '',
      args: [],
    );
  }

  /// `Recent searches`
  String get recentSearches {
    return Intl.message(
      'Recent searches',
      name: 'recentSearches',
      desc: '',
      args: [],
    );
  }

  /// `Type something to search...`
  String get typeSomethingToSearch {
    return Intl.message(
      'Type something to search...',
      name: 'typeSomethingToSearch',
      desc: '',
      args: [],
    );
  }

  /// `Search for jobs`
  String get searchForJobs {
    return Intl.message(
      'Search for jobs',
      name: 'searchForJobs',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get accepted {
    return Intl.message(
      'Accepted',
      name: 'accepted',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `My job membership provides you with premium featured profile and improve your visibility to the active recruiter.`
  String get myJobMembershipProvidesYouWithPremiumFeaturedProfileAnd {
    return Intl.message(
      'My job membership provides you with premium featured profile and improve your visibility to the active recruiter.',
      name: 'myJobMembershipProvidesYouWithPremiumFeaturedProfileAnd',
      desc: '',
      args: [],
    );
  }

  /// `Cancel membership`
  String get cancelMembership {
    return Intl.message(
      'Cancel membership',
      name: 'cancelMembership',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to cancel\nTransaction?`
  String get areYouSureToCancelntransaction {
    return Intl.message(
      'Are you sure to cancel\nTransaction?',
      name: 'areYouSureToCancelntransaction',
      desc: '',
      args: [],
    );
  }

  /// `Pricing Structure`
  String get pricingStructure {
    return Intl.message(
      'Pricing Structure',
      name: 'pricingStructure',
      desc: '',
      args: [],
    );
  }

  /// `Normal Price`
  String get normalPrice {
    return Intl.message(
      'Normal Price',
      name: 'normalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Months`
  String get months {
    return Intl.message(
      'Months',
      name: 'months',
      desc: '',
      args: [],
    );
  }

  /// `Offer Price:`
  String get offerPrice {
    return Intl.message(
      'Offer Price:',
      name: 'offerPrice',
      desc: '',
      args: [],
    );
  }

  /// `Pay now`
  String get payNow {
    return Intl.message(
      'Pay now',
      name: 'payNow',
      desc: '',
      args: [],
    );
  }

  /// `My Job,\nMembership`
  String get myJobnmembership {
    return Intl.message(
      'My Job,\nMembership',
      name: 'myJobnmembership',
      desc: '',
      args: [],
    );
  }

  /// `Premium subscription for\nyour premium version.`
  String get premiumSubscriptionFornyourPremiumVersion {
    return Intl.message(
      'Premium subscription for\nyour premium version.',
      name: 'premiumSubscriptionFornyourPremiumVersion',
      desc: '',
      args: [],
    );
  }

  /// `Verified`
  String get verified {
    return Intl.message(
      'Verified',
      name: 'verified',
      desc: '',
      args: [],
    );
  }

  /// `Premium Advantage`
  String get premiumAdvantage {
    return Intl.message(
      'Premium Advantage',
      name: 'premiumAdvantage',
      desc: '',
      args: [],
    );
  }

  /// `Get a premium featured profile and improve\nyour visibility to the active recruiter.`
  String get getAPremiumFeaturedProfileAndImprovenyourVisibilityToThe {
    return Intl.message(
      'Get a premium featured profile and improve\nyour visibility to the active recruiter.',
      name: 'getAPremiumFeaturedProfileAndImprovenyourVisibilityToThe',
      desc: '',
      args: [],
    );
  }

  /// `Rank at the top in the search result`
  String get rankAtTheTopInTheSearchResult {
    return Intl.message(
      'Rank at the top in the search result',
      name: 'rankAtTheTopInTheSearchResult',
      desc: '',
      args: [],
    );
  }

  /// `Profile enhancement by Myjob Specialist for\nbetter response`
  String get profileEnhancementByMyjobSpecialistFornbetterResponse {
    return Intl.message(
      'Profile enhancement by Myjob Specialist for\nbetter response',
      name: 'profileEnhancementByMyjobSpecialistFornbetterResponse',
      desc: '',
      args: [],
    );
  }

  /// `Computerized refresh to boost your visibility`
  String get computerizedRefreshToBoostYourVisibility {
    return Intl.message(
      'Computerized refresh to boost your visibility',
      name: 'computerizedRefreshToBoostYourVisibility',
      desc: '',
      args: [],
    );
  }

  /// `Priority customer support`
  String get priorityCustomerSupport {
    return Intl.message(
      'Priority customer support',
      name: 'priorityCustomerSupport',
      desc: '',
      args: [],
    );
  }

  /// `Carrier tips and resume building handbook`
  String get carrierTipsAndResumeBuildingHandbook {
    return Intl.message(
      'Carrier tips and resume building handbook',
      name: 'carrierTipsAndResumeBuildingHandbook',
      desc: '',
      args: [],
    );
  }

  /// `Premium Payment failed.`
  String get premiumPaymentFailed {
    return Intl.message(
      'Premium Payment failed.',
      name: 'premiumPaymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Subscription`
  String get cancelSubscription {
    return Intl.message(
      'Cancel Subscription',
      name: 'cancelSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Remaining`
  String get remaining {
    return Intl.message(
      'Remaining',
      name: 'remaining',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Current subscription:`
  String get currentSubscription {
    return Intl.message(
      'Current subscription:',
      name: 'currentSubscription',
      desc: '',
      args: [],
    );
  }

  /// `complete`
  String get complete {
    return Intl.message(
      'complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `View Membership`
  String get viewMembership {
    return Intl.message(
      'View Membership',
      name: 'viewMembership',
      desc: '',
      args: [],
    );
  }

  /// `My Job Membership`
  String get myJobMembership {
    return Intl.message(
      'My Job Membership',
      name: 'myJobMembership',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Payment Failed`
  String get paymentFailed {
    return Intl.message(
      'Payment Failed',
      name: 'paymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Get profile boosting, career advice\n& many more features advantage.`
  String get getProfileBoostingCareerAdvicenManyMoreFeaturesAdvantage {
    return Intl.message(
      'Get profile boosting, career advice\n& many more features advantage.',
      name: 'getProfileBoostingCareerAdvicenManyMoreFeaturesAdvantage',
      desc: '',
      args: [],
    );
  }

  /// `Your Subscription has been\ncancelled Please renew`
  String get yourSubscriptionHasBeenncancelledPleaseRenew {
    return Intl.message(
      'Your Subscription has been\ncancelled Please renew',
      name: 'yourSubscriptionHasBeenncancelledPleaseRenew',
      desc: '',
      args: [],
    );
  }

  /// `Please click here to update your payment`
  String get pleaseClickHereToUpdateYourPayment {
    return Intl.message(
      'Please click here to update your payment',
      name: 'pleaseClickHereToUpdateYourPayment',
      desc: '',
      args: [],
    );
  }

  /// `at just`
  String get atJust {
    return Intl.message(
      'at just',
      name: 'atJust',
      desc: '',
      args: [],
    );
  }

  /// `Renew`
  String get renew {
    return Intl.message(
      'Renew',
      name: 'renew',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get changeLanguage {
    return Intl.message(
      'Change language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `View jobs`
  String get viewJobs {
    return Intl.message(
      'View jobs',
      name: 'viewJobs',
      desc: '',
      args: [],
    );
  }

  /// `Complete now`
  String get completeNow {
    return Intl.message(
      'Complete now',
      name: 'completeNow',
      desc: '',
      args: [],
    );
  }

  /// `Subscription successful`
  String get subscriptionSuccessful {
    return Intl.message(
      'Subscription successful',
      name: 'subscriptionSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Back to Home`
  String get backToHome {
    return Intl.message(
      'Back to Home',
      name: 'backToHome',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email ID(Optional)`
  String get enterEmailIdoptional {
    return Intl.message(
      'Enter Email ID(Optional)',
      name: 'enterEmailIdoptional',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get signup {
    return Intl.message(
      'Signup',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get rejected {
    return Intl.message(
      'Rejected',
      name: 'rejected',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `years experience`
  String get yearsExperience {
    return Intl.message(
      'years experience',
      name: 'yearsExperience',
      desc: '',
      args: [],
    );
  }

  /// `Opening`
  String get opening {
    return Intl.message(
      'Opening',
      name: 'opening',
      desc: '',
      args: [],
    );
  }

  /// `On pay roll`
  String get onPayRoll {
    return Intl.message(
      'On pay roll',
      name: 'onPayRoll',
      desc: '',
      args: [],
    );
  }

  /// `Off pay roll`
  String get offPayRoll {
    return Intl.message(
      'Off pay roll',
      name: 'offPayRoll',
      desc: '',
      args: [],
    );
  }

  /// `Direct recruitment`
  String get directRecruitment {
    return Intl.message(
      'Direct recruitment',
      name: 'directRecruitment',
      desc: '',
      args: [],
    );
  }

  /// `Please Login to continue`
  String get pleaseLoginToContinue {
    return Intl.message(
      'Please Login to continue',
      name: 'pleaseLoginToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Go to Login`
  String get goToLogin {
    return Intl.message(
      'Go to Login',
      name: 'goToLogin',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'or', countryCode: 'IN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
