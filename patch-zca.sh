#!/bin/bash
bundleId="com.zwift.android.prod"
apk=`adb shell pm path $bundleId`
apk=`echo $apk | awk '{print $NF}' FS=':' | tr -d '\r\n'`
adb pull $apk zca.apk
apktool d zca.apk -o zca_decoded
sed -i '/<key>react_native_fitness_view<\/key>/{n;s/<value>false<\/value>/<value>true<\/value>/;}' zca_decoded/res/xml/remote_config_defaults.xml
apktool b zca_decoded -o zca.apk
apk-mitm --certificate cert-zwift-com.pem zca.apk
