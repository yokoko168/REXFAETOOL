# Static Binary iperf3 (AArch64)

針對嵌入式系統 (如 OpenWrt/Linux AP) 優化的靜態編譯版本，不需額外依賴庫即可執行。

## 🖥️ 1. Server 端 (接收端)
請複製執行以下指令，將自動下載並進入 Server 模式：

```bash
(curl -k -L -o /root/iperf3 "https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3" || wget --no-check-certificate -O /root/iperf3 "https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3") && chmod +x /root/iperf3 && echo "安裝完成，正在啟動 iperf3 Server..." && /root/iperf3 -s
```

## 💻 2. Client 端 (發送端 / FAE 專用)
請複製執行以下指令，下載後會顯示 **參數速查表** 與 **範例指令**，方便現場修改 IP：

```bash
cd /root && (curl -k -L -o iperf3 "https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3" || wget --no-check-certificate -O iperf3 "https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3") && chmod +x iperf3 && echo -e "\n\n======================================================\n✅ 安裝完成！參數速查表：\n\n  -c [ServerIP] : 指定 Server IP (必填)\n  -u            : 使用 UDP 模式 (測 WiFi 建議用)\n  -b [頻寬]      : 限制頻寬 (例: 4M, 100M, 0=無限)\n  -t [秒數]      : 測試時間 (例: 10, 20)\n  -P [數量]      : 平行連線數 (多流測試, 例: 4)\n  -R            : 反向模式 (Server 傳給 Client, 測下行)\n  -B [本機IP]    : 綁定本機特定網卡 IP\n  -f m          : 顯示單位改為 Mbits\n\n⬇️  請複製底下範例去修改：\n./iperf3 -c 192.168.Server.IP -u -b 100M -P 2 -t 20 -f m\n======================================================\n"
```


**是的，強烈建議你要調整！**

你剛剛的實測證明了在嵌入式系統（OpenWrt/Linux AP）上，`curl` 比 `wget` 可靠得多。

### 為什麼原本的腳本會失敗？

1. **SSL 支援殘缺：** 很多 AP 裡的 `wget` 其實是閹割版（uclient-fetch），預設不支援 HTTPS，就算加了 `--no-check-certificate`，它連建立連線的能力都沒有（報錯 `Failed to allocate uclient context`）。
2. **GitHub 重導向 (Redirect)：** GitHub 的 raw 連結通常會跳轉，`curl` 需要加 `-L` 才會跟隨跳轉，而舊版 `wget` 有時處理不好這個跳轉。

---

### ✅ 最佳化建議：使用「雙保險」寫法

身為 FAE，你遇到的設備千奇百怪。有些只有 curl，有些只有 wget。
最穩的寫法是**「優先用 curl，失敗則嘗試 wget」**。

我幫你把腳本修改好了，你可以直接複製替換你的筆記：

1. **改用 `curl` 為主**（加上 `-k` 忽略憑證、`-L` 跟隨跳轉）。
2. **加入 `||` (OR 邏輯)**：如果 `curl` 失敗，自動嘗試 `wget`。
3. **修正 URL 格式**：移除了 Markdown 語法中多餘的括號，確保複製到終端機不會出錯。

---

### 📋 更新後的腳本 (請複製取代你的筆記)

# Static Binary iperf3 (AArch64)

針對嵌入式系統 (如 OpenWrt/Linux AP) 優化的靜態編譯版本，不需額外依賴庫即可執行。

## 🖥️ 1. Server 端 (接收端)

請複製執行以下指令，系統會嘗試自動下載並啟動 Server (優先使用 curl，若無則嘗試 wget)：

```bash
(curl -k -L -o /root/iperf3 "https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3" || wget --no-check-certificate -O /root/iperf3 "https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3") && chmod +x /root/iperf3 && echo "安裝完成，正在啟動 iperf3 Server..." && /root/iperf3 -s

```

## 💻 2. Client 端 (發送端 / FAE 專用)

請複製執行以下指令，下載後會顯示 **參數速查表** 與 **範例指令**，方便現場修改 IP：

```bash
cd /root && (curl -k -L -o iperf3 "https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3" || wget --no-check-certificate -O iperf3 "https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3") && chmod +x iperf3 && echo -e "\n\n======================================================\n✅ 安裝完成！參數速查表：\n\n  -c [ServerIP] : 指定 Server IP (必填)\n  -u            : 使用 UDP 模式 (測 WiFi 建議用)\n  -b [頻寬]      : 限制頻寬 (例: 4M, 100M, 0=無限)\n  -t [秒數]      : 測試時間 (例: 10, 20)\n  -P [數量]      : 平行連線數 (多流測試, 例: 4)\n  -R            : 反向模式 (Server 傳給 Client, 測下行)\n  -B [本機IP]    : 綁定本機特定網卡 IP\n  -f m          : 顯示單位改為 Mbits\n\n⬇️  請複製底下範例去修改：\n./iperf3 -c 192.168.Server.IP -u -b 100M -P 2 -t 20 -f m\n======================================================\n"

```

---

### 💡 修改重點說明 (給你看的)

1. **指令結構：** `(curl ... || wget ...)`
* 這行指令的意思是：先跑 curl，如果成功就結束；如果 curl 報錯（例如沒安裝），就會自動跑後面的 wget。這樣可以適應 99% 的 Linux 環境。


2. **curl 參數：** 加了 `-k` (不驗證 SSL) 和 `-L` (跟隨 GitHub 的 302 重導向)，這對下載 GitHub Raw 檔案至關重要。
3. **URL 清理：** 原本你的代碼裡 URL 被包在 `[]()` 裡面，如果直接複製進 Shell 有時會因為特殊符號報錯，我把它改成了純粹的雙引號字串。

