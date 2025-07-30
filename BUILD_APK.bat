@echo off
echo 🩸 Blood Donation App - APK Builder
echo ===================================
echo.

echo ✅ Cleaning project...
flutter clean

echo.
echo ✅ Getting dependencies...
flutter pub get

echo.
echo ✅ Building APK...
flutter build apk --release

echo.
if exist "build\app\outputs\flutter-apk\app-release.apk" (
    echo 🎉 APK Built Successfully!
    echo 📱 Location: build\app\outputs\flutter-apk\app-release.apk
    echo.
    echo Opening APK folder...
    start "" "build\app\outputs\flutter-apk\"
) else (
    echo ❌ APK Build Failed!
)

pause