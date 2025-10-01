@echo off
echo Fixing Android Build Issues...

echo 1. Stopping Gradle Daemon...
cd android
gradlew --stop

echo 2. Cleaning Android Project...
gradlew clean

echo 3. Clearing Gradle Cache...
rmdir /s /q .gradle 2>nul
rmdir /s /q build 2>nul

echo 4. Clearing Global Gradle Cache...
rmdir /s /q "%USERPROFILE%\.gradle\caches" 2>nul

echo 5. Clearing CMake Cache...
cd ..
rmdir /s /q build\.cxx 2>nul

echo 6. Flutter Clean...
flutter clean

echo 7. Get Dependencies...
flutter pub get

echo Android fix completed!
echo Try running: flutter run
pause