import 'dart:convert';
import 'dart:io';
import 'package:ayi_connect/utils/center_button.dart';
import 'package:ayi_connect/utils/common_textfield.dart';
import 'package:ayi_connect/utils/constants.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../utils/loading_dialog.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

TextEditingController fname = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController occupationController = TextEditingController();
TextEditingController companyController = TextEditingController();
TextEditingController aboutUsController = TextEditingController();

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  File? selectedImage;
  DateTime? firstDate;
  int activeIndex = 0;
  int selectGender = 0;
  bool isEnabled = false;
  String selectedLang = "";
  String selectedService = "";
  String? countryCode = '+62';
  var countText = "00";

  var formattedAddress = "";

  pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyView(),
    );
  }

  Widget bodyView() {
    return Column(
      children: [
        customStapper(),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: apppadding26,
              child: IndexedStack(
                index: activeIndex,
                children: [
                  trackPosition1(),
                  trackPosition2(),
                  trackPosition3(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget trackPosition1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        selectRoleWidget(
            onTaped: () {
              setState(() {
                activeIndex = 1;
              });
            },
            image: "assets/images/helper_v1.svg",
            text: "Are you seeking care for your\nlove one?",
            btnText: "Find a Helper",
            btnColor: const Color(0xFF00CCCC)),
        selectRoleWidget(
          onTaped: () {
            setState(() {
              activeIndex = 1;
            });
          },
          image: "assets/images/job_v2.svg",
          text: "Or you’re looking for a care,\nhouusekeeper, or tutor job?",
          btnText: "Find a Job",
          btnColor: const Color(0xFFFA9D6B),
        ),
      ],
    );
  }

  Widget trackPosition2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pick Image
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 16.h),
              child: selectedImage == null
                  ? SvgPicture.asset(
                      "assets/images/profilepic.svg",
                      height: 90.sp,
                      width: 90.sp,
                      fit: BoxFit.cover,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                        height: 90.sp,
                        width: 90.sp,
                      ),
                    ),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: 9.5.h, horizontal: 13.5.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: greyColor, width: 1),
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add profile photo",
                            style: blackRegular16.copyWith(
                                color: const Color(0XFF636366),
                                fontWeight: FontWeight.normal),
                          ),
                          const Icon(
                            Icons.add_circle_outline_outlined,
                            color: Color(0XFF8E8E93),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Add a profile to make it more personal. It makes a difference!",
                    style:
                        blackRegular16.copyWith(color: const Color(0XFF636366)),
                  ),
                ],
              ),
            )
          ],
        ),

        // Dividers
        Column(
          children: [
            SizedBox(height: 8.h),
            commonDivider,
            commonDivider,
            SizedBox(height: 8.h),
          ],
        ),

        // Add Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Full Name",
              style: blackRegular16,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 8.h, 0, 15.h),
              child:
                  CommonTextfield(controller: fname, hintText: "Your Fullname"),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Your Gender",
              style: blackRegular16,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 8.h, 0, 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectGender = 0;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 17.h, horizontal: 8.w),
                        decoration: BoxDecoration(
                            color: selectGender == 0
                                ? btnColor1
                                : transparentColor,
                            border: Border.all(
                                color:
                                    selectGender == 0 ? btnColor1 : greyColor,
                                width: 1),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Row(
                          children: [
                            Icon(
                                selectGender == 0
                                    ? Icons.radio_button_checked
                                    : Icons.circle_outlined,
                                color: selectGender == 0
                                    ? whiteColor
                                    : const Color(0XFFCACACA)),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                "Male",
                                style: TextStyle(
                                    color: selectGender == 0
                                        ? whiteColor
                                        : greyColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectGender = 1;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 17.h, horizontal: 8.w),
                        decoration: BoxDecoration(
                            color: selectGender == 1
                                ? btnColor1
                                : transparentColor,
                            border: Border.all(
                                color:
                                    selectGender == 1 ? btnColor1 : greyColor,
                                width: 1),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Row(
                          children: [
                            Icon(
                                selectGender == 1
                                    ? Icons.radio_button_checked
                                    : Icons.circle_outlined,
                                color: selectGender == 1
                                    ? whiteColor
                                    : const Color(0XFFCACACA)),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                "Female",
                                style: TextStyle(
                                    color: selectGender == 1
                                        ? whiteColor
                                        : greyColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectGender = 2;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 17.h, horizontal: 8.w),
                        decoration: BoxDecoration(
                            color: selectGender == 2
                                ? btnColor1
                                : transparentColor,
                            border: Border.all(
                                color:
                                    selectGender == 2 ? btnColor1 : greyColor,
                                width: 1),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Row(
                          children: [
                            Icon(
                                selectGender == 2
                                    ? Icons.radio_button_checked
                                    : Icons.circle_outlined,
                                color: selectGender == 2
                                    ? whiteColor
                                    : const Color(0XFFCACACA)),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                "Other",
                                style: TextStyle(
                                    color: selectGender == 2
                                        ? whiteColor
                                        : greyColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose Your Date of Birth ",
              style: blackRegular16,
            ),
            InkWell(
              onTap: () async {
                var seletedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1947, 1),
                    lastDate: DateTime.now());
                if (seletedDate != null) {
                  firstDate = seletedDate;
                  setState(() {});
                }
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(0, 8.h, 0, 15.h),
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 15.w),
                decoration: BoxDecoration(
                    border: Border.all(color: greyColor, width: 1),
                    borderRadius: BorderRadius.circular(8.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      firstDate != null
                          ? DateFormat('MM/dd/yyyy').format(firstDate!)
                          : "MM/DD/YYYY",
                      style: TextStyle(
                        color: firstDate != null ? blackColor : greyColor,
                        fontSize: 18.sp,
                      ),
                    ),
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: Color(0XFF8E8E93),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Phone Number",
              style: blackRegular16,
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 65.h,
                    margin: EdgeInsets.fromLTRB(0, 8.h, 0, 15.h),
                    padding:
                        EdgeInsets.symmetric(vertical: 18.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                        border: Border.all(color: greyColor, width: 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.r),
                            bottomLeft: Radius.circular(8.r))),
                    child: InkWell(
                      onTap: () {
                        showContryPicker(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            "$countryCode",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          SvgPicture.asset(
                            "assets/images/down_arrow.svg",
                            height: 10.sp,
                            width: 10.w,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 65.h,
                      margin: EdgeInsets.fromLTRB(0, 8.h, 0, 15.h),
                      padding:
                          EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: greyColor, width: 1),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r))),
                      child: TextFormField(
                        onChanged: (text) {
                          if (text.isNotEmpty) {
                            isEnabled = true;
                          } else {
                            isEnabled = false;
                          }
                        },
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          errorStyle:
                              const TextStyle(color: Colors.red, fontSize: 15),
                          hintText: "Phone Number",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.sp,
                          ),
                          suffixIcon: phoneController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    phoneController.clear();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Location*",
              style: blackRegular16,
            ),
            InkWell(
              onTap: () async {
                bool serviceEnabled;
                LocationPermission permission;

                serviceEnabled = await Geolocator.isLocationServiceEnabled();
                if (!serviceEnabled) {
                  return Future.error('Location services are disabled.');
                }

                permission = await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                  if (permission == LocationPermission.denied) {
                    return;
                  }
                }

                if (permission == LocationPermission.deniedForever) {
                  return;
                }
                showLoader(context);
                Position position = await Geolocator.getCurrentPosition();

                print("position ${position.latitude}");

                await getAddressFromLatAndLng(
                    position.latitude, position.longitude);
                Navigator.pop(context);
              },
              child: Container(
                height: 65.h,
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(0, 8.h, 0, 15.h),
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 15.w),
                decoration: BoxDecoration(
                    border: Border.all(color: greyColor, width: 1),
                    borderRadius: BorderRadius.circular(8.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        formattedAddress == ""
                            ? "Find your location here"
                            : formattedAddress,
                        style: TextStyle(
                            color:
                                formattedAddress == "" ? greyColor : blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400)),
                    SvgPicture.asset(
                      "assets/images/down_arrow.svg",
                      height: 10.sp,
                      width: 10.w,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),

        // BTN
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.h),
          child: CenterButton(
            ontap: () {
              setState(() {
                activeIndex = 2;
              });
            },
            text: "Next",
            fontsize: 18.sp,
            fontWeight: FontWeight.w600,
            bgColor: appColor,
          ),
        )
      ],
    );
  }

  getAddressFromLatAndLng(double lat, double lng) async {
    String host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$host?key=$googleApiKey&language=en&latlng=$lat,$lng';

    print("url $url");
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      var formattedAddress1 = data["results"][0]["formatted_address"];
      List address = formattedAddress1.split(",");
      if (mounted) {
        setState(() {
          formattedAddress =
              "${address[address.length - 2]} ${address[address.length - 1]}";
        });
      }
      return formattedAddress;
    } else {
      return null;
    }
  }

  Widget trackPosition3() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Occupation",
              style: blackRegular16,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 8.h, 0, 15.h),
              child: CommonTextfield(
                  controller: occupationController,
                  hintText: "Add your occupation "),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Company",
              style: blackRegular16,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 8.h, 0, 15.h),
              child: CommonTextfield(
                  controller: companyController,
                  hintText: "Add your company name"),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fluently spoken language(s) *",
              style: blackRegular16,
            ),
            PopupMenuButton(
                color: whiteColor,
                offset: const Offset(3, 60),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: greyColor, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
                itemBuilder: (_) => <PopupMenuItem<String>>[
                      PopupMenuItem<String>(
                          value: 'Spanish',
                          child: Container(
                            margin: EdgeInsets.zero,
                            width: 1.sw,
                            child: const Text(
                              "Spanish",
                            ),
                          )),
                      const PopupMenuItem<String>(
                          value: 'Mandarin',
                          child: Text(
                            "Mandarin",
                          )),
                      const PopupMenuItem<String>(
                          value: 'English',
                          child: Text(
                            "English",
                          )),
                    ],
                onSelected: (type) async {
                  if (type == "Spanish") {
                    // context.locale = const Locale('en', 'US');
                  } else if (type == "Mandarin") {
                    // context.locale = const Locale('en', 'US');
                  } else {
                    // context.locale = const Locale('en', 'US');
                  }
                  selectedLang = "$type";
                  setState(() {});
                },
                child: Container(
                  height: 65.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  margin: EdgeInsets.fromLTRB(0, 8.h, 0, 15.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: greyColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedLang == "" ? "Add language" : selectedLang,
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: selectedLang == "" ? greyColor : blackColor),
                      ),
                      const Icon(
                        Icons.add_circle_outline_outlined,
                        color: Color(0XFF8E8E93),
                      ),
                    ],
                  ),
                )),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Prefered Service",
              style: blackRegular16,
            ),
            PopupMenuButton(
                color: whiteColor,
                offset: const Offset(3, 60),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: greyColor, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
                itemBuilder: (_) => <PopupMenuItem<String>>[
                      PopupMenuItem<String>(
                          value: 'Child Care',
                          child: Container(
                            margin: EdgeInsets.zero,
                            width: 1.sw,
                            child: const Text(
                              "Child Care",
                            ),
                          )),
                      const PopupMenuItem<String>(
                          value: 'Senior Care',
                          child: Text(
                            "Senior Care",
                          )),
                      const PopupMenuItem<String>(
                          value: 'Home Care',
                          child: Text(
                            "Home Care",
                          )),
                      const PopupMenuItem<String>(
                          value: 'Other Services',
                          child: Text(
                            "Other Services",
                          )),
                    ],
                onSelected: (type) async {
                  if (type == "Child Care") {
                  } else if (type == "Senior Care") {
                  } else if (type == "Home Care,") {
                  } else {}
                  selectedService = "$type";
                  setState(() {});
                },
                child: Container(
                  height: 65.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  margin: EdgeInsets.fromLTRB(0, 8.h, 0, 15.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: greyColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedService == ""
                            ? "Add your prefered service"
                            : selectedService,
                        style: TextStyle(
                            fontSize: 18.sp,
                            color:
                                selectedService == "" ? greyColor : blackColor),
                      ),
                      SvgPicture.asset(
                        "assets/images/down_arrow.svg",
                        height: 10.sp,
                        width: 10.w,
                      )
                    ],
                  ),
                )),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tell us about you*",
              style: blackRegular16,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 8.h, 0, 15.h),
              child: CommonTextfield(
                  controller: aboutUsController,
                  maxLine: 5,
                  maxLength: 100,
                  counterText: "$countText/100",
                  onChange: (value) {
                    countText = value.length.toString();
                    setState(() {});
                  },
                  labelText: aboutUsController.text.length.toString(),
                  hintText:
                      "Provide some brief about yourself, so helper can get to know your a litle better before your connection."),
            ),
          ],
        ),

        // BTN
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.h),
          child: CenterButton(
            ontap: () {},
            text: "Submit",
            fontsize: 18.sp,
            fontWeight: FontWeight.w600,
            bgColor: appColor,
          ),
        )
      ],
    );
  }

  Widget customStapper() {
    return Container(
      color: appColor,
      height: 130.h,
      padding: EdgeInsets.symmetric(horizontal: 25.w).copyWith(bottom: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              stepItem(index: 0),
              Expanded(
                child: Container(
                  height: 2.h,
                  color: Colors.white,
                ),
              ),
              stepItem(index: 1),
              Expanded(
                child: Container(
                  height: 2.h,
                  color: Colors.white,
                ),
              ),
              stepItem(index: 2),
              SizedBox(
                width: 5.w,
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              stepItemTitle(title: "Select\nYour Role", index: 0),
              stepItemTitle(title: "Personal\nInformation", index: 1),
              stepItemTitle(title: "Personal\nInformation", index: 2),
            ],
          ),
        ],
      ),
    );
  }

  Widget selectRoleWidget(
      {var image,
      var text,
      var btnText,
      var onTaped,
      required Color btnColor}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.h).copyWith(bottom: 52),
      child: Column(
        children: [
          SvgPicture.asset(
            image,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 18.h),
            alignment: Alignment.center,
            child: Text(
              text,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
            ),
          ),
          CenterButton(
            ontap: onTaped,
            text: btnText,
            fontsize: 18.sp,
            fontWeight: FontWeight.w600,
            margin: 50,
            bgColor: btnColor,
          ),
        ],
      ),
    );
  }

  Widget stepItem({var index}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(100.r)),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 32.sp,
      width: 32.sp,
      alignment: Alignment.center,
      child: index < activeIndex
          ? Icon(
              Icons.check,
              size: 18.sp,
            )
          : Text(
              "${index + 1}",
              style: TextStyle(fontSize: 14.sp),
            ),
    );
  }

  Widget stepItemTitle({var title, var index}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 12.sp,
          color: index < activeIndex ? Colors.white : const Color(0XFFEBEBF0),
          fontWeight: index <= activeIndex ? FontWeight.w600 : FontWeight.w400),
    );
  }

  showContryPicker(context) {
    showCountryPicker(
        showPhoneCode: true,
        context: context,
        countryListTheme: const CountryListThemeData(
          flagSize: 20,
          bottomSheetHeight: 500,
          textStyle: TextStyle(
            fontSize: 16,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          inputDecoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Start typing to search',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        ),
        onSelect: (Country country) {
          countryCode = country.displayName.split('[')[1].split(']')[0];
        });
  }
}
