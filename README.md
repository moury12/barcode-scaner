# barcode_scaner

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
[profile_page.dart#L44-64](textBlock;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/profile/presentation/pages/profile_page.dart#L44-64) 
add dynamic data [edit_profile_page.dart](file;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/profile/presentation/pages/edit_profile_page.dart) also show user data here nd give access to edit profile 
here is api:
endpoin for get: {{base_url}}/user/my-profile
response: {
  "success": true,
  "message": "My profile is retrieved successfully",
  "data": {
    "_id": "6aa77bd4339116f413a1d06a",
    "fullName": "Divar Owner",
    "email": "divar49259@crybio.com",
    "phone": "1234569078",
    "role": "owner",
    "profileImg": "",
    "status": "active",
    "blockedAt": null,
    "lastLoginAt": "2026-09-21T03:03:31.519Z",
    "createdAt": "2026-09-14T04:45:08.837Z"
  }
}
update profile endpoint: patch : {{base_url}}/user/update-profile
body: from data gave you as screen shot 
response: {
  "success": true,
  "message": "Profile is updated successfully",
  "data": {
    "acknowledged": true,
    "modifiedCount": 1,
    "upsertedId": null,
    "upsertedCount": 0,
    "matchedCount": 1
  }
}
_____
this wass for customer only



[shop_details_setup_page.dart#L155-155](textBlock;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/shop_setup/presentation/pages/shop_details_setup_page.dart#L155-155) 
during update when that shop has img he need to show that here also give user option to update it 

[scanner_page.dart](file;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/scanner/presentation/pages/scanner_page.dart) from here shop owner can scan customer qr code nd after get the  code need to hit api
for verify that id :
enpoint: {{base_url}}/redemption/verify-qr-code
body:{
    "qrCode": "HH-COFFEE-EBD834" //format: HH-COFFEE-XXXXXX
}
response: {
  "success": true,
  "message": "QR code verified successfully.",
  "data": null
}
after getting code by scaning go to this page auto fill that code text field 
[manual_code_entry_page.dart](file;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/scanner/presentation/pages/manual_code_entry_page.dart) thn hit that api on verify code [shop_dashboard_page.dart#L30-30](textBlock;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/dashboard/presentation/pages/shop_dashboard_page.dart#L30-30) 
nd here show redmption history first 3/4 thn view all take to this page 


[redemption_history_page.dart](file;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/customer_management/presentation/pages/redemption_history_page.dart) 
here and show here full list with functional pagination
endpoint: {{base_url}}/redemption/owner-redemptions
response: {
  "success": true,
  "message": "Redemptions are retrieved successfully.",
  "meta": {
    "page": 1,
    "limit": 10,
    "totalPages": 1,
    "total": 1
  },
  "data": [
    {
      "_id": "6aae57a67d823b57dd2d539f",
      "customerId": "6aa4d97b2305db36fa9c93fd",
      "customerName": "Osman Goni",
      "customerEmail": "gonidev715@gmail.com",
      "customerPhone": "01793837035",
      "customerImg": "",
      "qrCode": "HH-COFFEE-EBD834",
      "isUsed": false,
// based on this when its false give option owner to verify qr code 
otherwise show redeemed 
      "expiresAt": "2026-09-18T23:59:59.999Z",
      "createdAt": "2026-09-19T09:36:38.216Z",
      "updatedAt": "2026-09-19T09:36:53.995Z"
    }
  ]
}

this was all for shop owner 
now i need to show redeemption history to customer 
[history_page.dart](file;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/history/presentation/pages/history_page.dart) [home_page.dart#L93-93](textBlock;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/home/presentation/pages/home_page.dart#L93-93) 
show here history 
endpoint: {{base_url}}/redemption/customer-redemptions
params : searchTerm a string field give search option on that page 

response: {
    "success": true,
    "message": "Redemptions are retrieved successfully.",
    "meta": {
        "page": 1,
        "limit": 10,
        "totalPages": 1,
        "total": 1
    },
    "data": [
        {
            "_id": "6aae57a67d823b57dd2d539f",
            "shopName": "Urban Grind Cafe",
            "contactNumber": "12345645685",
            "address": "House 45, Road 11, Gulshan-1, Dhaka",
            "image": "https://res.cloudinary.com/dvtgqgnkg/image/upload/v1789368009/Coffee/shop/fi6muyksbgcvdwkyyr24.jpg",
            "qrCode": "HH-COFFEE-EBD834",
            "isUsed": false,
            "expiresAt": "2026-09-18T23:59:59.999Z",
            "createdAt": "2026-09-19T09:36:38.216Z",
            "updatedAt": "2026-09-19T09:36:53.995Z"
        }
    ]
}
  "isUsed": false, based on this if true show redeemed or show pending 

[help_support_page.dart](file;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/profile/presentation/pages/help_support_page.dart) in this page 
do this post api : 
endpoint: {{base_url}}/support/submit
body: {
    "title": "General issue.",
    "message": "I am not able to scan qr code."
}
response {
  "success": true,
  "message": "Your support message has been submitted successfully.",
  "data": {
    "userId": "6aa4d97b2305db36fa9c93fd",
    "title": "Login issue",
    "message": "Please contact with me",
    "replyMessage": "",
    "replyAt": null,
    "status": "new",
    "_id": "6aae6252f21fcaa58bc89f12",
    "createdAt": "2026-09-19T10:22:10.570Z",
    "updatedAt": "2026-09-19T10:22:10.570Z"
  }
}
add validation both felid 
add terms condition and privacy policy 
[profile_page.dart#L118-123](textBlock;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/profile/presentation/pages/profile_page.dart#L118-123) 
from here [shop_profile_tab.dart#L143-146](textBlock;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/profile/presentation/pages/shop_profile_tab.dart#L143-146) 
also route same page from here 
endpoint: {{base_url}}/content/content-by-type/terms-condition
{{base_url}}/content/content-by-type/privacy-policy
use html view 
response: {
  "success": true,
  "message": "Content retrieved successfully",
  "data": {
    "type": "privacy-policy",
    "content": "<p>This is privacy policy </p>",
    "updatedAt": "2026-09-19T05:23:50.789Z"
  }
}
response
: {
    "success": true,
    "message": "Content retrieved successfully",
    "data": {
        "type": "terms-condition",
        "content": "<p>This is Terms & Condition.</p>",
        "updatedAt": "2026-09-19T05:25:46.808Z"
    }
}

