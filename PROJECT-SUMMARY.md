# ExpenseIL — סיכום פרויקט מלא לצ'אט חדש

## מה זה הפרויקט
אפליקציית מעקב הוצאות ישראלית — קובץ HTML יחיד (~2434 שורות) שעובד כ-PWA.
מיועדת למעקב אחרי חיובי כרטיסי אשראי ישראליים (כל, מקס, ישראכרט, אמריקן אקספרס).

## קבצים חשובים
- **`C:\Users\Eyal\Desktop\ExpensesIL\ExpenseIL.html`** — הקובץ הראשי (master copy)
- **`C:\Users\Eyal\Desktop\ExpensesIL\index.html`** — עותק זהה ל-GitHub Pages (תמיד לסנכרן מ-ExpenseIL.html!)
- **`C:\Users\Eyal\Desktop\ExpensesIL\Excels\`** — תיקיית אקסלים של חיובים
- **`C:\Users\Eyal\Desktop\ExpensesIL\manifest.json`**, **`sw.js`**, **`icon-*.png`** — קבצי PWA

## פרטי Deployment
- **GitHub Pages**: username **eyalalkobi0301-arch**, repo **expense-il**
- **URL**: https://eyalalkobi0301-arch.github.io/expense-il/
- **Firebase Project ID**: expenseil
- **Firebase DB URL**: https://expenseil-default-rtdb.firebaseio.com

## מדיניות אבטחה (קריטי — לא לשנות!)
- מדובר במידע רגיש (כרטיסי אשראי) — לא לקחת סיכון
- אין לשמור סיסמאות של אתרי בנק/כרטיסי אשראי בסקריפטים
- אין API calls לשערי חליפין
- אין Bookmarklet (וקטור XSS)
- אין Google Sheets (גוגל רואה הכל, מבטל את ה-AES-256-GCM)
- כל הנתונים הפיננסיים מוצפנים ב-localStorage על כל מכשיר בנפרד
- רק הקוד עולה ל-GitHub Pages — לא נתונים
- Firebase sync: הנתונים חייבים להיות מוצפנים על המכשיר עם AES-256-GCM לפני שליחה ל-Firebase. Firebase רואה רק blobs מוצפנים.

## פיצ'רים פעילים
1. **ייבוא אקסלים** — גרירת קבצים או בחירה ידנית, תומך בכל חברות האשראי הישראליות
2. **סריקת תיקייה (חדש)** — כפתור "בחר תיקיית אקסלים" שמשתמש ב-File System Access API (`window.showDirectoryPicker`). סורק תיקייה, מציג קבצים חדשים, ומייבא רק מה שלא יובא כבר. פונקציות: `pickWatchFolder()`, `scanWatchFolder()`, `importWatchFiles()`
3. **הצפנת PIN** — AES-256-GCM דרך Web Crypto API (PBKDF2)
4. **סנכרון Firebase** — Google Sign-in עם `signInWithPopup`, נתונים מוצפנים לפני שליחה
5. **קטגוריזציה חכמה** — למידה אוטומטית של קטגוריות לפי שם עסק
6. **גרפים** — Chart.js לניתוח הוצאות
7. **PWA** — עובד כאפליקציה באייפון ובאנדרואיד
8. **קרדיטים/החזרים** — סכומים שליליים נשמרים (בלי Math.abs), מוצגים בירוק עם "+"

## דגשים טכניים חשובים
- `saveData()` ו-`saveLearnedCategory()` הן **async** — כל קריאה חייבת להיות עם `await`
- `showPinScreen(mode)` מקבל mode = `'setup'` או `'unlock'` — **לא** `'set'`!
- `importedFileNames` נשמר ב-localStorage key `expIL_importedFiles`
- Credits/refunds: סכומים שליליים לא מומרים ל-Math.abs

## תיקון אחרון שנעשה — PIN + Sync
### הבעיה:
כשלוחצים על כפתור הסנכרון (☁️), זה מבקש PIN אבל לא נפתח המסך להזנת PIN.

### הסיבה:
1. כפתור הסנכרון היה מוסתר (display:none) כשאין cryptoKey — תוקן להציג תמיד
2. `handleSyncClick()` קרא ל-`showPinScreen('set')` — באג! הפונקציה מצפה ל-`'setup'` (שורה 602: `const isSetup = mode === 'setup'`)

### מה תוקן (בקובץ המקומי):
- שורה ~2293: הכפתור תמיד מוצג עם label "☁️ סנכרון בין מכשירים"
- שורה ~2321: `showPinScreen('set')` → `showPinScreen('setup')`
- שורה ~2325: `showPinScreen('unlock')` לכשיש נתונים מוצפנים
- שורה ~2336: זיהוי שגיאת `auth/unauthorized-domain` עם הודעה ברורה

### מצב נוכחי:
- ✅ התיקון קיים ב-ExpenseIL.html
- ✅ index.html סונכרן מ-ExpenseIL.html (עודכן 06/06/2026)
- ⚠️ **צריך לעלות ל-GitHub** — התיקון עדיין לא ב-GitHub Pages!
- ⚠️ **צריך לוודא ב-Firebase Console** שגוגל Sign-In מופעל ושהדומיין `eyalalkobi0301-arch.github.io` ברשימת authorized domains

## איך להעלות ל-GitHub
ל-Eyal מותקן Git for Windows. ב-PowerShell:
```powershell
cd C:\Users\Eyal\Desktop\ExpensesIL
git add -A
git commit -m "fix: sync button PIN screen + folder scanner"
git push origin main
```
אם יש בעיות עם git, אפשר להעלות ידנית דרך:
https://github.com/eyalalkobi0301-arch/expense-il → Add file → Upload files

## מצגות Canva שנוצרו
- מצגת שיווקית בעברית: design ID `DAHLTAby3IY` — [עריכה](https://www.canva.com/d/0D9IDDeN9jEK69H)
- מדריך שימוש v2 (סופי, כולל סריקת תיקיות): design ID `DAHLWwzm4rk` — [עריכה](https://www.canva.com/d/ny6FK8rEL_T0PPe)
- PDF מדריך שמור ב: `C:\Users\Eyal\Desktop\ExpensesIL\ExpenseIL-Guide.pdf`

## משימות שעדיין תלויות
1. **קריטי**: להעלות את הקבצים המעודכנים ל-GitHub (index.html + ExpenseIL.html)
2. **קריטי**: לוודא ב-Firebase Console ש-Google Sign-In מופעל + דומיין מאושר
3. לבדוק שלאחר ה-deploy, לחיצה על כפתור הסנכרון באייפון באמת מציגה מסך PIN
4. תזכורת שבועית להוצאות — כבר מוגדרת ופעילה (שבת 10:00 בבוקר)

## פרטי קשר
- שם: Eyal Alkobi
- אימייל: eyalalkobi0301@gmail.com
- GitHub: eyalalkobi0301-arch
