# Google Authentication Setup Guide for Flutter (ezo)

This guide walks you through setting up the Google Sign-In client for your Flutter application.

## Prerequisites
- A Google Cloud Platform (GCP) account.
- The `google_sign_in` package (already added to your `pubspec.yaml`).

## Step 1: Create a Google Cloud Project
1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Click the project dropdown in the top bar and select **New Project**.
3. Enter a project name (e.g., `ezo-flutter-app`) and click **Create**.
4. Once created, select the project from the notification or dropdown.

## Step 2: Configure OAuth Consent Screen
1. In the left sidebar, navigate to **APIs & Services > OAuth consent screen**.
2. Select **External** (unless you are a G Suite user and want internal only) and click **Create**.
3. **App Information**:
   - **App name**: ezo (or your app name)
   - **User support email**: Your email
   - **Logo**: Optional
4. **Developer Contact Information**: Enter your email.
5. Click **Save and Continue**.
6. **Scopes**: You can skip this for basic sign-in (email, profile, openid are default). Click **Save and Continue**.
7. **Test Users**: Add your own email address to test the login before verification. Click **Save and Continue**.
8. Review and click **Back to Dashboard**.

## Step 3: Create OAuth Client IDs

### For Android
1. Go to **APIs & Services > Credentials**.
2. Click **+ CREATE CREDENTIALS** > **OAuth client ID**.
3. **Application type**: Select **Android**.
4. **Name**: `ezo-android` (or similar).
5. **Package name**: Open `android/app/build.gradle` to find your `applicationId` (usually `com.example.ezo` or similar).
6. **SHA-1 Certificate Fingerprint**:
   - Run the following command in your terminal project root:
     ```bash
     cd android
     ./gradlew signingReport
     ```
   - Look for the `SHA1` under `Task :app:signingReport` > `Variant: debug` > `Config: debug`.
   - Copy that SHA1 string (e.g., `XX:XX:XX...`) and paste it into the Cloud Console.
7. Click **Create**.
8. **Download the JSON**:
   - Only needed if using Firebase Auth (google-services.json).
   - *Since you are using raw `google_sign_in` and a custom backend:*
     - You mainly need to ensure the **SHA-1 and Package Name match**.
     - The `google_sign_in` plugin on Android uses the Google Play Services configuration which usually requires a `google-services.json` file placed in `android/app/`.
   - **Recommendation**: Even without Firebase, it's safest to download the `google-services.json` file from a connected Firebase project *OR* effectively just rely on the SHA-1 match if you aren't using Firebase.
   - **Wait!** If you are *not* using Firebase, you only need the OAuth Client ID if you are calling a backend. But for the app to sign in, check the `google_sign_in` docs.
   - *Standard Practice*: Most Flutter apps use Firebase for easier config. If not using Firebase, you might still need to register the app in the console.

### For iOS
1. Go to **APIs & Services > Credentials**.
2. Click **+ CREATE CREDENTIALS** > **OAuth client ID**.
3. **Application type**: Select **iOS**.
4. **Name**: `ezo-ios`.
5. **Bundle ID**: Open `ios/Runner.xcodeproj/project.pbxproj` or just open `ios/Runner/Info.plist` (usually not there, but bundle identifier is in Xcode settings). Default is often `com.example.ezo`.
6. Click **Create**.
7. **Download the plist**:
   - Download the `GoogleService-Info.plist`.
   - Place this file in `ios/Runner/` folder.
   - **Important**: You must also drag and drop this file into your `Runner` project in Xcode to ensure it's added to the bundle resources.
8. **Info.plist Configuration**:
   - Open `ios/Runner/Info.plist`.
   - Add the `CFBundleURLTypes` entry:
     ```xml
     <key>CFBundleURLTypes</key>
     <array>
       <dict>
         <key>CFBundleTypeRole</key>
         <string>Editor</string>
         <key>CFBundleURLSchemes</key>
         <array>
           <!-- Copied from GoogleService-Info.plist key REVERSED_CLIENT_ID -->
           <string>com.googleusercontent.apps.YOUR-CLIENT-ID</string>
         </array>
       </dict>
     </array>
     ```

### For Web (Back-end verification)
1. Go to **APIs & Services > Credentials**.
2. Click **+ CREATE CREDENTIALS** > **OAuth client ID**.
3. **Application type**: Select **Web application**.
4. **Name**: `ezo-backend`.
5. **Authorized JavaScript origins**: (Your backend URL, e.g., `http://localhost:3000` for dev).
6. **Authorized redirect URIs**: (Your callback URL if using redirects, often not needed for implicit flow or ID token verification).
7. Click **Create**.
8. **Copy the Client ID**: This is your `GOOGLE_CLIENT_ID` for the backend.

## Step 4: Configure the Flutter App

### Android Configuration
1. If using `google-services.json` (Recommended via Firebase):
   - Place `google-services.json` in `android/app/`.
   - Add the Google Services classpath to `android/build.gradle`:
     ```gradle
     dependencies {
         classpath 'com.google.gms:google-services:4.3.15'
     }
     ```
   - Apply the plugin in `android/app/build.gradle`:
     ```gradle
     apply plugin: 'com.google.gms.google-services'
     ```
2. **Without Firebase/google-services.json**:
   - You can pass the `clientId` programmatically to `GoogleSignIn(clientId: '...')` (mainly for Web/Desktop, but helpful).
   - However, on Android, it usually auto-detects from the resources generated by the google-services plugin.

### Code Update
In your `auth_controller.dart`, ensure you initialize `GoogleSignIn` with scopes if needed:

```dart
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile', 'openid'],
  // serverClientId is crucial if you want an ID token that the backend can verify!
  // Use the Web Client ID you created in Step 3.
  serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com', 
);
```

## Step 5: Backend Verification
- Ensure your backend uses the same **Web Client ID** to verify the `idToken` sent from the app.
- If the app sends an `idToken` generated with an Android Client ID, the backend must be configured to accept that Audience (aud), or better, use the `serverClientId` parameter in Flutter to request a token for the backend.

## Summary Checklist
- [ ] Created Google Cloud Project
- [ ] Configured OAuth Consent Screen
- [ ] Created Android OAuth Client ID (SHA-1 fingerprint added)
- [ ] Created iOS OAuth Client ID
- [ ] Downloaded/Configured `google-services.json` (Android) / `GoogleService-Info.plist` (iOS)
- [ ] Created Web OAuth Client ID (for Backend `serverClientId`)
