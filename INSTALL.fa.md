# نصب و به‌روزرسانی Parsian-Python

نسخهٔ آزمایشی **0.1.0** منتشر شده است. این راهنما برای Windows 10/11 نوشته شده است. پروژه هنوز آزمایشی است؛ ابتدا آن را در یک محیط ساده امتحان کنید.

## پیش‌نیاز

- Windows 10/11
- Python 3.10 یا جدیدتر، همراه با pip
- اتصال اینترنت

در PowerShell بررسی کنید پایتون نصب است:

```powershell
py -3 --version
py -3 -m pip --version
```

## نصب نسخهٔ منتشرشده

ابتدا اسکریپت نصب را از مخزن رسمی دریافت کنید:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/amiraliamarloo93/Parsian-Python/main/installer/windows/install.ps1" -OutFile "install.ps1"
```

پیش از اجرا، اگر می‌خواهید محتوای اسکریپت را بررسی کنید، آن را در ویرایشگر متنی باز کنید. سپس در همان پنجرهٔ PowerShell اجرا کنید:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\install.ps1
```

نصب‌کننده آخرین Release عمومی را پیدا می‌کند و بستهٔ wheel را با pip برای کاربر فعلی نصب می‌کند. اگر فرمان `parsian` بعد از نصب پیدا نشد، یک ترمینال جدید باز کنید و دوباره امتحان کنید.

## اجرای برنامه

یک فایل با پسوند `.pyfa` بسازید؛ مثلاً `hello.pyfa`:

```python
نام = "جهان"
چاپ("سلام " + نام)
```

سپس در PowerShell، از پوشه‌ای که فایل در آن است اجرا کنید:

```powershell
parsian .\hello.pyfa
```

برای دیدن کد پایتون ترجمه‌شده، از گزینهٔ زیر استفاده کنید:

```powershell
parsian --translate .\hello.pyfa
```

فایل‌های ناشناس را اجرا نکنید؛ این ابزار محیط ایزوله یا sandbox برای کدهای ورودی فراهم نمی‌کند.

## به‌روزرسانی

برای دریافت آخرین نسخهٔ منتشرشده، اسکریپت به‌روزرسانی را دانلود کنید:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/amiraliamarloo93/Parsian-Python/main/installer/windows/update.ps1" -OutFile "update.ps1"
```

پس از بررسی محتوای اسکریپت، آن را اجرا کنید:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\update.ps1
```

## نصب از کد منبع (برای توسعه‌دهندگان)

مخزن هسته خصوصی است؛ برای این روش باید به آن دسترسی GitHub داشته باشید:

```powershell
git clone https://github.com/amiraliamarloo93/Parsian-Python-Core.git
cd Parsian-Python-Core
py -3 -m pip install -e ".[dev]"
parsian examples/hello.pyfa
```

## افزونهٔ Visual Studio Code (نسخهٔ توسعه)

کد افزونه هنوز نسخهٔ رسمی منتشرشده نیست. پس از نصب Node.js، در پوشهٔ `vscode-extension` اجرا کنید:

```powershell
npm install
npm run compile
npx --yes @vscode/vsce package
```

این دستور یک فایل VSIX برای نصب دستی می‌سازد. افزونه برای اجرای برنامه به مترجم Parsian-Python نصب‌شده و قابل دسترسی از PATH نیاز دارد.

## عیب‌یابی

- اگر فرمان `py` پیدا نشد، Python 3.10 یا جدیدتر را نصب کنید و ترمینال را دوباره باز کنید.
- اگر فرمان `parsian` پیدا نشد، یک ترمینال جدید باز کنید؛ در صورت تداوم مشکل، مسیر نصب اسکریپت‌ها و تنظیمات PATH را بررسی کنید.
- اگر نصب یا به‌روزرسانی شکست خورد، پیام کامل خطا را همراه با نسخهٔ پایتون و ویندوز در [Issues](https://github.com/amiraliamarloo93/Parsian-Python/issues) ثبت کنید.
- بستهٔ انتشار و ابزار هنوز آزمایشی‌اند؛ برای پروژه‌های حساس به آن‌ها تکیه نکنید.
