#!/bin/bash

# 1. تصميم الواجهة الرسومية باستخدام YAD
OUTPUT=$(yad --form --title="مُحمّل يوتيوب المتقدم" \
    --width=550 --center --image="video-x-generic" \
    --text="قم بلصق الرابط وتخصيص إعدادات التحميل أدناه:" \
    --field="🔗 رابط المقطع أو الألبوم (URL):" "" \
    --field="📁 مجلد الحفظ:DIR" "$HOME/Music/Reader_core" \
    --field="✍️ تسمية مخصصة للملف (اختياري):" "" \
    --field="🎬 نوع التحميل:CB" "أغنية (صوت فقط)!فيديو (صوت وصورة)" \
    --field="📊 جودة التحميل الكلية:CB" "أفضل جودة متاحة (Best)!جودة متوسطة (Medium)!جودة منخفضة وتوفير بيانات (Low)" \
    --field="🎵 صيغة الصوت المفضلة (إذا اخترت أغنية):CB" "opus!mp3!flac" \
    --field="🖼️ دمج صورة الغلاف / الـ Cover؟:CHK" "TRUE" \
    --field="💬 تحميل وتدميج الترجمة المتوفرة؟:CHK" "TRUE" \
    --field="📂 هل الرابط قائمة تشغيل / ألبوم (Playlist)؟:CHK" "FALSE" \
    --button="ابدأ التحميل الآن:0" --button="إلغاء:1")

# التحقق من الضغط على إلغاء
if [ $? -ne 0 ] || [ -z "$OUTPUT" ]; then
    exit 0
fi

# 2. تفكيك البيانات المستلمة
RAW_URL=$(echo "$OUTPUT" | cut -d'|' -f1)
SAVE_DIR=$(echo "$OUTPUT" | cut -d'|' -f2)
CUSTOM_NAME=$(echo "$OUTPUT" | cut -d'|' -f3)
DOWNLOAD_TYPE=$(echo "$OUTPUT" | cut -d'|' -f4)
QUALITY_LEVEL=$(echo "$OUTPUT" | cut -d'|' -f5)
AUDIO_FORMAT=$(echo "$OUTPUT" | cut -d'|' -f6)
EMBED_COVER=$(echo "$OUTPUT" | cut -d'|' -f7)
EMBED_SUBS=$(echo "$OUTPUT" | cut -d'|' -f8)
IS_PLAYLIST=$(echo "$OUTPUT" | cut -d'|' -f9)

# تنظيف الرابط من بارامترات التتبع
URL=$(echo "$RAW_URL" | sed 's/&si=.*//')

# 3. التحقق من الرابط
if [ -z "$URL" ]; then
    yad --error --title="خطأ في الإدخال" --text="لم تقم بوضع أي رابط! يرجى لصق الرابط أولاً." --width=350 --center
    exit 1
fi

if [[ ! "$URL" =~ "youtube.com" && ! "$URL" =~ "youtu.be" && ! "$URL" =~ "music.youtube.com" ]]; then
    yad --error --title="رابط غير صالح" --text="الرابط المدخل ليس رابط يوتيوب صالح!" --width=350 --center
    exit 1
fi

mkdir -p "$SAVE_DIR"
cd "$SAVE_DIR" || exit 1

# 4. بناء مصفوفة الخيارات
ARGS=("--no-update" "-i") # -i لتجاهل الأخطاء الفرعية في القوائم والألبومات

if [ "$DOWNLOAD_TYPE" == "أغنية (صوت فقط)" ]; then
    ARGS+=("-x" "--audio-format" "$AUDIO_FORMAT")
    if [ "$QUALITY_LEVEL" == "أفضل جودة متاحة (Best)" ]; then
        ARGS+=("--audio-quality" "0" "-f" "ba/b")
    elif [ "$QUALITY_LEVEL" == "جودة متوسطة (Medium)" ]; then
        ARGS+=("--audio-quality" "5" "-f" "ba")
    else
        ARGS+=("--audio-quality" "9" "-f" "wa")
    fi
else
    if [ "$QUALITY_LEVEL" == "أفضل جودة متاحة (Best)" ]; then
        ARGS+=("-f" "bv+ba/b")
    elif [ "$QUALITY_LEVEL" == "جودة متوسطة (Medium)" ]; then
        ARGS+=("-f" "bv*[height<=720]+ba/b")
    else
        ARGS+=("-f" "bv*[height<=480]+ba/b")
    fi
fi

# خيار الغلاف (تم تعديله ليكون آمنًا على ملفات الصوت)
if [ "$EMBED_COVER" == "TRUE" ]; then
    ARGS+=("--embed-thumbnail" "--convert-thumbnails" "jpg")
fi

# خيار الترجمة والكلمات
if [ "$EMBED_SUBS" == "TRUE" ]; then
    ARGS+=("--write-subs" "--sub-langs" "all,-live_chat" "--embed-subs")
fi

# التعامل مع الألبومات وقوائم التشغيل
if [ "$IS_PLAYLIST" == "TRUE" ] || [[ "$URL" =~ "list=" ]]; then
    ARGS+=("--yes-playlist")
else
    ARGS+=("--no-playlist")
fi

if [ -n "$CUSTOM_NAME" ]; then
    ARGS+=("-o" "$CUSTOM_NAME %(playlist_index)s.%(ext)s")
else
    ARGS+=("-o" "%(title)s.%(ext)s")
fi

# إضافة البيانات الوصفية تلقائياً
ARGS+=("--embed-metadata")

# 5. التحميل وتنقية المخرجات لـ YAD
notify-send "yt-dlp" "جاري جلب بيانات الألبوم وبدء التحميل..."

yt-dlp --newline "${ARGS[@]}" "$URL" | awk '
BEGIN { print "0"; fflush(); }
/\[download\] Downloading item/ {
    print "# 🎵 " $0; fflush();
}
/\[download\] Destination:/ {
    split($0, a, "Destination: ");
    print "# 🎶 جاري تحميل: " a[2]; fflush();
}
/\[download\]/ && /%/ {
    for (i=1; i<=NF; i++) {
        if ($i ~ /%/) {
            pct = $i;
            gsub(/%/, "", pct);
            print pct;
        }
    }
    print "# 📊 " $0;
    fflush();
}
' | yad --progress \
    --title="جاري التحميل..." \
    --text="⏳ يتم الآن جلب بيانات الألبوم..." \
    --width=520 \
    --height=150 \
    --center \
    --auto-close

STATUS=${PIPESTATUS[0]}

# 6. تنظيف الملفات المؤقتة المتخلفة (.temp و .jpg) تلقائياً في حالة وجودها
rm -f *.temp.* *.jpg 2>/dev/null

# 7. النتيجة
if [ $STATUS -eq 0 ] || [ $(ls -1 *.opus *.mp3 *.flac 2>/dev/null | wc -l) -gt 0 ]; then
    notify-send "yt-dlp" "🎉 اكتمل تحميل الألبوم بنجاح في:\n$SAVE_DIR"
else
    notify-send "yt-dlp" "❌ حدث خطأ ما أثناء التحميل."
fi