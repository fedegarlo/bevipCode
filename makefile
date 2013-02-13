
build-x:
	security unlock-keychain /Users/svp/Library/Keychains/login.keychain	
	xcodebuild
	cp -R build/Release-iphoneos/T2.app /Volumes/Users/Cecilio/Desktop/
