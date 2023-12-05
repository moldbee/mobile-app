# flutter build apk --release --no-tree-shake-icons
pwd=$(pwd)
adb -s R9DW60382TN install $pwd/build/app/outputs/apk/release/app-release.apk 