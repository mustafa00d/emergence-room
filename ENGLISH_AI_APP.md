# English AI Learning App

هذا الفرع مخصص لتطبيق تعلم اللغة الإنجليزية بالذكاء الاصطناعي.

## المنجز حالياً

- تسجيل الدخول وإنشاء ملف المتعلم عبر Supabase Auth.
- NestJS API مرتبط بـ PostgreSQL/Supabase.
- اختبار تحديد مستوى تكيفي CEFR من A1 إلى C2.
- قياس مستقل للقواعد والمفردات والقراءة والاستماع.
- ملفات migrations جاهزة لـ Supabase.
- واجهة Flutter للاختبار والنتائج.
- GitHub Actions لفحص Backend وتنفيذ migrations بعد إضافة أسرار Supabase.

النسخة الكاملة محفوظة في ملف `english_ai_phase2.zip` المرفق في محادثة المشروع. يُفضّل لاحقاً نقلها إلى مستودع مستقل باسم `english-ai-learning-app` بدلاً من دمجها مع مشروع غرفة الطوارئ.

## أسرار GitHub المطلوبة للربط التلقائي بـ Supabase

- `SUPABASE_ACCESS_TOKEN`
- `SUPABASE_PROJECT_REF`
- `SUPABASE_DB_PASSWORD`

لا ترفع مفاتيح Supabase السرية أو كلمة مرور قاعدة البيانات داخل الملفات.