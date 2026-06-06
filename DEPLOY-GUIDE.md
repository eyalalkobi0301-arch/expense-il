# ExpenseIL — מדריך העלאה ל-GitHub Pages

## קבצים להעלאה (5 קבצים בלבד)
- `index.html` — האפליקציה
- `manifest.json` — הגדרות PWA
- `sw.js` — Service Worker לעבודה אופליין
- `icon-192.png` — אייקון קטן
- `icon-512.png` — אייקון גדול

> **אל תעלה:** `ExpenseIL.html` (עותק מקורי לגיבוי), קבצי Excel/CSV

## שלבים

### 1. צור ריפו חדש ב-GitHub
1. היכנס ל-https://github.com/new
2. שם: `expense-il` (או כל שם אחר)
3. **חשוב: סמן Public** (GitHub Pages חינמי רק ל-Public)
4. לחץ "Create repository"

### 2. העלה את הקבצים
1. בדף הריפו החדש לחץ "uploading an existing file"
2. גרור את 5 הקבצים הנ"ל
3. לחץ "Commit changes"

### 3. הפעל GitHub Pages
1. Settings → Pages (בתפריט הצדדי)
2. Source: "Deploy from a branch"
3. Branch: `main` / `/ (root)`
4. לחץ Save
5. חכה דקה — תקבל כתובת: `https://YOUR-USERNAME.github.io/expense-il/`

### 4. הוסף לאייפון
1. פתח את הכתובת בספארי באייפון
2. לחץ על כפתור השיתוף (ריבוע עם חץ למעלה)
3. בחר "Add to Home Screen" / "הוסף למסך הבית"
4. לחץ "Add"

## אבטחה
- **שום מידע אישי לא עולה ל-GitHub** — רק הקוד של האפליקציה
- כל הנתונים הפיננסיים מוצפנים ב-localStorage של כל מכשיר בנפרד
- באייפון תצטרך להזין PIN ולייבא קבצי Excel מחדש (הנתונים לא מסתנכרנים בין מכשירים)
