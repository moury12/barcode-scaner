[customer_verified_page.dart#L19-24](textBlock;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/scanner/presentation/pages/customer_verified_page.dart#L19-24) this info need to be dynamic [manual_code_entry_page.dart#L27-66](textBlock;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/scanner/presentation/pages/manual_code_entry_page.dart#L27-66) 
here u will get response like this {
  "success": true,
  "message": "QR code verified successfully.",
  "data": {
    "customerId": "6aa4d97b2305db36fa9c93fd",
    "customerName": "Osman Goni",
    "customerEmail": "gonidev715@gmail.com",
    "customerPhone": "01793837035",
    "customerImg": "https://res.cloudinary.com/dvtgqgnkg/image/upload/v1789963537/Coffee/user/q5avpdkv2sx8uopm9btp.png",
    "qrCode": "HH-COFFEE-42C046",
    "isRedeemed": true,
    "expiresAt": "2026-09-22T23:59:59.999Z",
    "createdAt": "2026-09-22T04:09:23.816Z"
  }
}
u need show this info in this page [customer_verified_page.dart](file;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/scanner/presentation/pages/customer_verified_page.dart) 
by qr code both customer owner will get details of their opposite user 
endpoint: {{base_url}}/redemption/single-redemption/{{qrID}}
response : for customer 
{
  "success": true,
  "message": "Redemption is retrieved successfully.",
  "data": {
    "_id": "6aae57a67d823b57dd2d539f",
    "shopId": "6aa79475856dc6c66ea5d71d",
    "shopName": "Urban Grind Cafe",
    "contactNumber": "12345645685",
    "address": "House 45, Road 11, Gulshan-1, Dhaka",
    "image": "https://res.cloudinary.com/dvtgqgnkg/image/upload/v1789368009/Coffee/shop/fi6muyksbgcvdwkyyr24.jpg",
    "qrCode": "HH-COFFEE-EBD834",
    "isRedeemed": false,
    "expiresAt": "2026-09-18T23:59:59.999Z",
    "createdAt": "2026-09-19T09:36:38.216Z",
    "updatedAt": "2026-09-19T09:36:53.995Z"
  }
}
for shop owner 
{
  "success": true,
  "message": "Redemption is retrieved successfully.",
  "data": {
    "_id": "6ab1ff736d76800067e058d3",
    "customerId": "6aa4d97b2305db36fa9c93fd",
    "customerName": "Osman Goni",
    "customerEmail": "gonidev715@gmail.com",
    "customerPhone": "01793837035",
    "customerImg": "https://res.cloudinary.com/dvtgqgnkg/image/upload/v1789963537/Coffee/user/q5avpdkv2sx8uopm9btp.png",
    "qrCode": "HH-COFFEE-42C046",
    "isRedeemed": false,
    "expiresAt": "2026-09-22T23:59:59.999Z",
    "createdAt": "2026-09-22T04:09:23.816Z",
    "updatedAt": "2026-09-22T04:09:23.816Z"
  }
}[qr_code_page.dart](file;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/redemption/presentation/pages/qr_code_page.dart) 
here u can show shop owner details if 
nd for see customers qr code reddemed or not 
here is api for single shop get the status [home_page.dart#L63-109](textBlock;file:///Users/dayshiftuser/Documents/moury_flutter_projects/barcode_scaner/lib/src/features/home/presentation/pages/home_page.dart#L63-109) 
manage isRedeemed by using this api 
enpoint: {{base_url}}/membership/single-membership/{{shopID}}

