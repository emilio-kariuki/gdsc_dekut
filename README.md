<!--
title: 'AWS NodeJS Example'
description: 'This template demonstrates how to deploy a NodeJS function running on AWS Lambda using the traditional Serverless Framework.'
layout: Doc
framework: v3
platform: AWS
language: nodeJS
priority: 1
authorLink: 'https://github.com/serverless'
authorName: 'Serverless, inc.'
authorAvatar: 'https://avatars1.githubusercontent.com/u/13742415?s=200&v=4'
-->
# GDSC DeKUT
GDSC DeKUT is a community based mobile application built on the flutter framework to help unite the tech Community in `Dedan Kimathi University` by helping the get access to upcoming events, resources, news, tech groups, and the leads contacts to allow them to contact them incase of any challenge in their learning process.
> The app is built courtesy of [GDSC (Google Developer Students Club)](https://gdsc.community.dev/dedan-kimathi-university-of-technology/)

> **Note**
> The app is not built only for GDSC but the whole tech community or anybody that feels they need to get access to resources to help them learn new and cool things

**The app is on PlayStore**

You can find the application here

*[![Play Store Badge](https://developer.android.com/images/brand/en_app_rgb_wo_60.png)](https://play.google.com/store/apps/details?id=com.gdsc.gdsc_app&hl=en&gl=US)*

[![Buy Me a Coffee](https://img.shields.io/badge/buy%20me%20a%20coffee-donate-orange.svg)](https://www.buymeacoffee.com/emiliokariuki)



## Technologies Used in the project
> The mobile application is completely built on the the `flutter` framework and `firebase` platform
 1. Flutter 
 2. Firebase
 
    . Cloud Messaging
    
    . Firebase Storage
    
    . Firebase Firestore
    
    . Authentication
    
## Project Set up
### 1. Initialize firebase
To initialize firebase we are going to use `FlutterFire` for this work as it will do all the dirty work for us

You can check more about `flutterfire` from its [docs](https://firebase.flutter.dev/docs/cli/)

> **Note**
> Yoo need to have a Firebase account, incase you dont have you can create one [here](https://firebase.google.com/) 

After you have fully installed `flutterfire` you can now enable flutterfire for your project now

### 2. Enable FlutterFire for your Flutter Project
To get started, you need to run the following command in the terminal of your ide of your project's directory
```
// paste in your terminal
dart pub global activate flutterfire_cli
```
## 3. Login to Firebase from your account
> **Note**
> To get started, you need to install this you need to have [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm/)(node package manager installed) for you to install the `firebase tools`
```
// paste this
firebase login
```
## 4. Configure Flutterfire to your project
The FlutterFire CLI extracts information from your Firebase project and selected project applications to generate all the configuration for a specific platform.

In the root of your `application`, run the configure command:

```
// paste this
flutterfire configure
```

After you install, all the configurations in your `build.gradle` file are added and the `google-service.json` are added in the android folder and `Firebase` will be integrated in your system this will save you all the trouble of having to install all the configurations one by one and this may cause some of the things to be oeverlooked.

### 5. Home Page
The `home page` tries to feature all the sub sections of the application from the events announcements, groups, twitter and even the profile page.
<div style="display: flex;">
    <img src="gdsc-dekut-mobile/Assets/home_page1.png" alt="Event" width= 300 height= 600>
    <img src="gdsc-dekut-mobile/Assets/home_page2.png" alt="Event" width= 300 height= 600>
</div>



### 6. Event Page
All the events that are upcoming in the tech community can be found in the `event page`

 
<div style="display: flex;">
    <img src="gdsc-dekut-mobile/Assets/event_page.png" alt="Event" width= 300 height= 600>
    <img src="gdsc-dekut-mobile/Assets/event_dialog.png" alt="Event" width= 300 height= 600>
</div>

### 7. Resources Page
All the resources that the members of the tech community will be found `here`

In the `resources` page the members are given the ability to post new reources if they have any to share with the other members

<div style="display: flex;">
    <img src="gdsc-dekut-mobile/Assets/resource_page.png" alt="Event" width= 300 height= 600>
    <img src="gdsc-dekut-mobile/Assets/resource_dialog.png" alt="Event" width= 300 height= 600>
</div>

### 8. Groups Page
All the tech groups in the community will be found  `here`

In the `news` page the members are given the ability to get acess to the groups in the tech comunity and also the newly posted news in Community

<div style="display: flex;">
    <img src="gdsc-dekut-mobile/Assets/group_page.png" alt="Event" width= 300 height= 600>
    <img src="gdsc-dekut-mobile/Assets/group_dialog.png" alt="Event" width= 300 height= 600>
</div>



# Serverless Framework AWS NodeJS Example

This template demonstrates how to deploy a NodeJS function running on AWS Lambda using the traditional Serverless Framework. The deployed function does not include any event definitions as well as any kind of persistence (database). For more advanced configurations check out the [examples repo](https://github.com/serverless/examples/) which includes integrations with SQS, DynamoDB or examples of functions that are triggered in `cron`-like manner. For details about configuration of specific `events`, please refer to our [documentation](https://www.serverless.com/framework/docs/providers/aws/events/).

## Usage

### Deployment

In order to deploy the example, you need to run the following command:

```
$ serverless deploy
```

After running deploy, you should see output similar to:

```bash
Deploying aws-node-project to stage dev (us-east-1)

✔ Service deployed to stack aws-node-project-dev (112s)

functions:
  hello: aws-node-project-dev-hello (1.5 kB)
```

### Invocation

After successful deployment, you can invoke the deployed function by using the following command:

```bash
serverless invoke --function hello
```

Which should result in response similar to the following:

```json
{
    "statusCode": 200,
    "body": "{\n  \"message\": \"Go Serverless v3.0! Your function executed successfully!\",\n  \"input\": {}\n}"
}
```

### Local development

You can invoke your function locally by using the following command:

```bash
serverless invoke local --function hello
```

Which should result in response similar to the following:

```
{
    "statusCode": 200,
    "body": "{\n  \"message\": \"Go Serverless v3.0! Your function executed successfully!\",\n  \"input\": \"\"\n}"
}
```

### Feel Free to contribute
You can `fork` the repo and feel free to contribute 

> **Note**
> You can reach me up on email `emilio113kariuki@gmail.com` or twitter `@EG_Kariuki`


