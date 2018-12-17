Open .exe file with any disassembler(I used OllyDbg). Then find string literals that contains "nag nag...", they are used in message
boxes we need to remove. Go to line of code where any of them are used. There we can see following code:
```
Address   Hex dump      Command                                  Comments
004010D0  6A 30         PUSH 30
004010D2  68 33304000   PUSH OFFSET 00403033                     ; ASCII "Remove me!"
004010D7  68 3E304000   PUSH OFFSET 0040303E                     ; ASCII "Nag Nag Nag...
004010DC  6A 00         PUSH 0
004010DE  E8 C5010000   CALL <JMP.&USER32.MessageBoxA>           ; first message box
004010E3  6A 00         PUSH 0
004010E5  68 10124000   PUSH 00401210
004010EA  FF75 B0       PUSH DWORD PTR SS:[EBP-50]
004010ED  68 29304000   PUSH OFFSET 00403029                     ; ASCII "NAGDIALOG"
004010F2  FF35 6C304000 PUSH DWORD PTR DS:[40306C]
004010F8  E8 87010000   CALL <JMP.&USER32.DialogBoxParamA>       ; second dialog box
```
So we need just to fill with nop's all these commands and win. Don't forget to save the modified program!
