import * as vscode from "vscode";
import { spawn } from "node:child_process";
import { dirname } from "node:path";

export function activate(context: vscode.ExtensionContext): void {
  const output = vscode.window.createOutputChannel("Parsian-Python");

  const runCommand = vscode.commands.registerCommand(
    "parsianPython.runFile",
    async () => {
      const editor = vscode.window.activeTextEditor;
      if (!editor) {
        vscode.window.showWarningMessage("ابتدا یک فایل .pyfa باز کنید.");
        return;
      }

      const filePath = editor.document.uri.fsPath;
      if (!filePath.toLowerCase().endsWith(".pyfa")) {
        vscode.window.showWarningMessage("فایل فعال باید پسوند .pyfa داشته باشد.");
        return;
      }

      await editor.document.save();
      const executable = vscode.workspace
        .getConfiguration("parsianPython")
        .get<string>("interpreterPath", "parsian");

      output.clear();
      output.show(true);
      output.appendLine(`$ ${executable} "${filePath}"`);

      const child = spawn(executable, [filePath], {
        cwd: dirname(filePath),
        shell: false,
        windowsHide: true
      });

      child.stdout.on("data", (data: Buffer) => output.append(data.toString()));
      child.stderr.on("data", (data: Buffer) => output.append(data.toString()));
      child.on("error", (error: Error) => {
        output.appendLine(`\nخطا در اجرای مترجم: ${error.message}`);
        vscode.window.showErrorMessage(
          "Parsian-Python اجرا نشد. نصب بودن مترجم و تنظیم interpreterPath را بررسی کنید."
        );
      });
      child.on("close", (code: number | null) => {
        output.appendLine(`\nProcess exited with code ${code ?? "unknown"}`);
      });
    }
  );

  context.subscriptions.push(runCommand, output);
}

export function deactivate(): void {
  // No persistent resources to dispose.
}
