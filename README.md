# zoffline-companion

Zwift Companion app (Android) patched for use with [zwift-offline](https://github.com/zoffline/zwift-offline).

## Download

Download APK from [releases](https://github.com/fatsbrown/zoffline-companion/releases).

## Patch it yourself

To patch it yourself, use [patch-zca.sh](https://github.com/fatsbrown/zoffline-companion/blob/main/patch-zca.sh) or run

``` bash
bundleId="com.zwift.android.prod"
apk=`adb shell pm path $bundleId`
apk=`echo $apk | awk '{print $NF}' FS=':' | tr -d '\r\n'`
adb pull $apk zca.apk
apktool d zca.apk -o zca_decoded
sed -i '/<key>react_native_fitness_view<\/key>/{n;s/<value>false<\/value>/<value>true<\/value>/;}' zca_decoded/res/xml/remote_config_defaults.xml
apktool b zca_decoded -o zca.apk
apk-mitm --certificate cert-zwift-com.pem zca.apk
```

### Requirements

- [ADB](https://developer.android.com/tools/releases/platform-tools)
- [Apktool](https://github.com/iBotPeaches/Apktool)
- [apk-mitm](https://github.com/niklashigi/apk-mitm)

## Disclaimer

Zwift is a trademark of Zwift, Inc., which is not affiliated with the owner of this repository and does not endorse this repository.

All product and company names are trademarks of their respective holders. Use of them does not imply any affiliation with or endorsement by them.
