# Project-Lag-tester

A high-visibility, full-screen batch-based network analysis and simulation utility designed to test connection stability, measure latency variation (jitter), and evaluate router packet handling capacity under controlled local network loads.

> [!WARNING]
> **LEGAL DISCLAIMER & TERMS OF USE**
> This project is created strictly as a technical method to test local internet handling and infrastructure stability. It is **NOT** supposed to be used for malicious purposes. 
> 
> * **Use At Your Own Risk:** The developer holds absolutely no responsibility or liability for your actions. If you use this software incorrectly, cause network disruptions, or get into legal trouble/punishment, you are entirely at fault. The creator does not contribute to, condone, or take responsibility for your actions.
> * **User Agreement:** Downloading, pasting, cloning, or utilizing this source code in any capacity means you explicitly agree that all actions and consequences are your own fault. 
> * **Best Practice:** Make the right choice. Do not use this tool maliciously to disrupt networks at your home, workplace, or any other infrastructure.

---

## 🚀 Key Features

* **Ultra-Zoom TUI:** Tailored with a custom 30x48 full-screen console font size injection for great visibility from across a room.
* **Persistent Visual Themes:** Select from 8 distinct terminal aesthetics (Matrix Green, Retro Amber, Neon Purple, Cyber Aqua, etc.) saved locally directly to your cache.
* **Real-Time Monitor Loop:** Agnostic text tracking parser that natively streams network latency, drops trailing anomalous tokens (`<1ms`), and protects arithmetic calculations from dropping out during severe congestion.
* **Granular Control Engine:** Run pre-configured stress topologies (Light, Medium, Heavy) or use manual entries to tweak window streams, loop counts, and custom packet density sizes.
* **Safe Return & Pure Nuke Logic:** Seamless post-launch redirects back to the primary workspace menu dashboard coupled with a deep cleanup runtime routine (terminates tasks, resets ARP bindings, and flushes local DNS resolvers).

---

## 🛠️ Installation & Setup

1. Create a new text file on your **Desktop**.
2. Copy the complete source code from `MASTER_CONTROL.bat` into your text file.
3. Rename the file extension from `.txt` to `.bat` (e.g., `Project_Lag_Tester.bat`).
4. **Important:** Right-click the file and select **Run as Administrator** (this permission level is required for full functionality, such as clearing local ARP mappings during a system purge).

  P.S. Or you can just download the File as I should have add each one with a .bat on the end - AND administrator ISNT needed, i was doing it without the            administrator

---

## 📊 Version Status

* **v14.7.9 STABLE PRO:** This is the primary stable production revision. All system logic, environment echo overrides, isolated loop boundaries, and menu shortcuts are fully debugged and operational.
* **v14.8.1 Faster:** Newest version and runs faster and just spits out CMD without the slow loading process and is more convienent then 14.7.9 but could have potenital bugs as this was just made - report any bugs to issues tab in Github - suggested version as 14.7.9 is slower and uses more resources

---

## 🐛 Bug Reporting

If you encounter any anomalous environment errors, interface glitches, or arithmetic variable crashes on your workstation configuration, please report them directly to the official issue tracker:

👉 [Submit a Bug Report Here](https://github.com/r3v3nan1/Project-Lag-tester/issues)

