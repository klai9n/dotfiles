#!/bin/bash

# 1. جلب الرابط المنسوخ تلقائيًا (يدعم Wayland و X11)
if [ -n "$WAYLAND_DISPLAY" ]; then
    URL=$(wl-paste)
else
    URL=$(xclip -selection clipboard -o)
fi

# التحقق من أن المنسوخ هو رابط يوتيوب
if [[ ! "$URL" =~ "youtube.com" && ! "$URL" =~ "youtu.be" ]]; then
    notify-send "خطأ" "الرابط الموجود في الحافظة ليس رابط يوتيوب صالح!"
    exit 1
fi

# 2. فتح نافذة مدير الملفات الرسومية لاختيار مجلد الحفظ باستخدام zenity
CHOICE=$(zenity --file-selection --directory --title="اختر مجلد حفظ الأغنية")

# إذا ألغى المستخدم النافذة أو أغلقها، يخرج السكريبت دون فعل شيء
if [ -z "$CHOICE" ]; then
    exit 0
fi

# الانتقال إلى المجلد المختار
cd "$CHOICE" || exit 1

# 3. إرسال إشعار ببدء التحميل
notify-send "yt-dlp" "بدء تحميل الأغنية في: $CHOICE"

# 4. تشغيل أمر yt-dlp الخاص بك
yt-dlp -f "ba/b" -x --audio-format opus --audio-quality 0 \
       --embed-thumbnail \
       --embed-metadata \
       --write-subs --sub-langs "all" --embed-subs \
       --ppa "ffmpeg: -mapping_info -c:v mjpeg -disposition:v:0 attached_pic" \
       "$URL"

# 5. إشعار عند اكتمال التحميل أو فشله
if [ $? -eq 0 ]; then
    notify-send "yt-dlp" "تم تحميل الأغنية بنجاح! 🎵"
else
    notify-send "yt-dlp" "فشل تحميل الأغنية! ❌"
fi
