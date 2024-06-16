#  LibNFCSwift

This is a wrapper library to call libnfc from Swift since CoreNFC does not support third party NFC readers. I am using this in a personal project so if this project eats your lunch... I am open to pull requests!

Another note, this project is licensed LGPL only because libnfc is LGPL. If I can relicense it to something weaker I will.

## Development Notes
The easiest way to get started with this library is to use Homebrew to install libnfc.
```
brew install libnfc
```


## Usage Notes
You can incorporate this library into another Swift project by adding the following include to your Package.swift:
```
    dependencies: [
        .package(url: "https://github.com/chotchki/LibNFCSwift.git", branch: "main")
    ],
```

You will also need to reconfigure the permissions on your XCode project:
1. In the App Sandbox you'll need to enable "USB" access.
2. In the Hardened Runtime you'll have to disable "Library Validation". This is because Homebrew's installation will be differently signed than yours.

