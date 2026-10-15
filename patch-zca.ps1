$bundleId = "com.zwift.android.prod"
$apkRaw = adb shell pm path $bundleId
$apk = ($apkRaw -split ':')[-1].Trim()
adb pull $apk zca.apk
apktool d zca.apk -o zca_decoded
$xmlPath = "zca_decoded/res/xml/remote_config_defaults.xml"
$xmlContent = Get-Content $xmlPath -Raw
$regex = '(<key>react_native_fitness_view<\/key>\s*<value>)false(<\/value>)'
$xmlContent = $xmlContent -replace $regex, '${1}true${2}'
[System.IO.File]::WriteAllText((Get-Item $xmlPath).FullName, $xmlContent)
apktool b zca_decoded -o zca.apk
apk-mitm --certificate cert-zwift-com.pem zca.apk
