su
echo "QQ群：32871430"
echo "作者：楓亭吳小豪"
if [ -f "/system/xbin/daemonsu" ];then
    echo "檢測到已成功執行過本腳本"
    echo "請點擊返回退出腳本執行器"
    echo "如有其它問題歡迎進群討論"
    exit
fi

pm install -r --user 0 SU.apk

mount -o rw,remount /system
if [ $? -eq 0 ]; then
    echo "/system 掛載成功"
else
    echo "/system 掛載失敗"
    echo "退出腳本"
    exit
fi

mount -o rw,remount /
if [ $? -eq 0 ]; then
    echo "/ 掛載成功"
else
    echo "/ 掛載失敗"
    echo "退出腳本"
    exit
fi
mkdir /system/app/SuperSu
mkdir /system/bin/.ext
if [ -d "/system/bin/.ext" ]; then
    echo "開始複製文件"
fi
cp libsupol.so /system/lib/
cp libsupol.so /system/lib64/
cp su /system/bin/.ext/.su
cp supolicy /system/xbin/
cp su /system/xbin/daemonsu
cp su /system/
cp su /system/etc/su
cp SU.apk /system/app/SuperSu/SuperSU.apk
echo -e "\n/system/xbin/daemonsu --auto-daemon & ">>/system/bin/install-recovery.sh
cp /system/bin/install-recovery.sh /system/etc/
chmod 0644 /system/lib/libsupol.so
chmod 0644 /system/lib64/libsupol.so
chmod 0755 /system/bin/.ext
chmod 0755 /system/bin/.ext/.su
chmod 0755 /system/xbin/supolicy
chmod 6755 /system/xbin/daemonsu
chmod 6755 /system/su
chmod 6755 /system/etc/su
chmod 0755 /system/app/SuperSu
chmod 0644 /system/app/SuperSu/SuperSU.apk

mv /system/su /system/xbin/su
mv /system/etc/su /system/bin/su
/system/xbin/daemonsu --auto-daemon &
echo "腳本執行完畢，準備重啟"
sleep 1
reboot