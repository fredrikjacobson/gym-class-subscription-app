# Gym Subscription App

Flutter app for managing Gym classes. Part of [Medium Article](https://medium.com/@fredrik.jacobson/creating-a-subscription-bot-for-gym-classes-f00c33958894) on how to generate automatic weekly bookings.

# Configuration

The app needs access to Firestore which is retrieved via two environment variables supplied via a `.env` file. Copy `.env.example` and replace user and password with correct values.

In addition `firebase_options.dart` needs to be updated correctly (Preferably using FlutterFire CLI)