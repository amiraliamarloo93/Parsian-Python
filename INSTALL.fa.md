# نصب و به‌روزرسانی Parsian-Python

وضعیت فعلی پروژه **آزمایشی و پیش‌ازانتشار** است. نصب‌کنندهٔ ویندوز برای دریافت بستهٔ رسمی به یک Release عمومی دارای فایل wheel نیاز دارد. تا پیش از انتشار نخستین نسخه، از این راهنما برای آماده‌سازی محیط توسعه استفاده کنید.

## پیش‌نیاز

- Windows 10/11
- Python 3.10 یا جدیدتر، همراه با pip
- اتصال اینترنت برای دریافت بستهٔ انتشار

برای بررسی نصب پایتون در PowerShell:

~~~powershell
py -3 --version
py -3 -m pip --version
~~~

## نصب از کد منبع (برای توسعه‌دهندگان)

مخزن هسته خصوصی است؛ باید دسترسی GitHub به آن داشته باشید:

~~~powershell
git clone https://github.com/amiraliamarloo93/Parsian-Python-Core.git
cd Parsian-Python-Core
py -3 -m pip install -e ".[dev]"
parsian examples/hello.pyfa
~~~

## نصب از Release عمومی

پس از انتشار نسخهٔ رسمی، فایل installer/windows/install.ps1 را از همین مخزن دریافت کنید و در PowerShell اجرا کنید:

~~~powershell
Set-ExecutionPolicy -Scope Process Bypass
.\install.ps1
~~~

اسکریپت فقط زمانی می‌تواند نصب را انجام دهد که یک Release عمومی حاوی فایل wheel در مخزن رسمی موجود باشد. هیچ نسخه‌ای را از آدرس‌های ناشناس نصب نکنید.

## به‌روزرسانی

پس از انتشار اولین نسخه، اسکریپت installer/windows/update.ps1 می‌تواند آخرین wheel منتشرشده در GitHub Releases را پیدا کند و با pip به‌روزرسانی کند:

~~~powershell
.\update.ps1
~~~

## افزونهٔ Visual Studio Code (نسخهٔ توسعه)

پس از نصب Node.js، در پوشهٔ vscode-extension اجرا کنید:

~~~powershell
npm install
npm run compile
npx --yes @vscode/vsce package
~~~

این دستور یک فایل VSIX برای نصب دستی می‌سازد. افزونه برای اجرای برنامه به مترجم Parsian-Python نصب‌شده و قابل دسترسی از PATH نیاز دارد. بستهٔ VSIX رسمی هنوز منتشر نشده است.

## عیب‌یابی

- اگر فرمان py پیدا نشد، Python را از منبع رسمی نصب و ترمینال را دوباره باز کنید.
- اگر هنوز Release دارای فایل .whl منتشر نشده، نصب‌کننده نمی‌تواند بسته‌ای دریافت کند.
- فایل‌های .pyfa مانند کد پایتون اجرا می‌شوند؛ فایل ناشناس را اجرا نکنید.
- این راهنما تا انتشار بستهٔ آزمایش‌شده، پیش‌نویس محسوب می‌شود.
