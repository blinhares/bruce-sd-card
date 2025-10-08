
# GhostStrats CipherPortal - Encrypted Message Broadcast System

This project is a **secure offline communication tool** that mimics a captive portal interface. It is designed to allow trusted individuals to send and receive **hidden messages** locally over Wi-Fi, without requiring Internet access.

---

## 🔐 How It Works

1. **The HTML file is the portal itself.**
   - Open it in a browser on any device.
   - You will be prompted for a password to unlock a secret message.
   - The password is stored in **plain text** in the HTML, which means anyone can inspect the file and find it—but this is intentional.

2. **To keep the actual message hidden**, the displayed text is encrypted using a cipher.

3. **Recommended Cipher**: [Vigenère Cipher](https://www.dcode.fr/vigenere-cipher)
   - Before sending your message, encrypt it using this site.
   - Share your agreed cipher key **ahead of time** with your intended recipients (in person or via other secure means).
   - Once users unlock the portal, they will see the **encoded message**. They must then decode it using the agreed key and the link provided.

---

## ⚙️ Security by Obscurity

- The goal isn’t to make it unbreakable.
- It's to **deter non-technical users** or unwanted eyes from casually viewing the message.
- A curious person will only see scrambled text unless they understand the encryption and the key.

---

## ✅ Use Case

This is **an improved version** of my original message broadcast system:
- Ideal for sending fast, secure, short-term messages across Wi-Fi.
- Perfect for local networks, underground comms, or pop-up secure broadcasts.

---

## 🚨 Important Notes

- Anyone with basic technical knowledge can view the HTML source.
- The real protection comes from the **Vigenère cipher key**, so keep it private and change it regularly.
- The cipher decoding website is also linked inside the HTML for convenience.

---

safety is in an illusion.  
**—GhostStrats**


---

## ⚠️ Disclaimer

This tool is for **educational and secure private communication purposes only**.  
Do not use this to send sensitive or illegal information. The HTML file is local and not truly secure without proper encryption practices. Use responsibly.

---

## 🛠 How to Modify the Portal

You can open the HTML file in any text editor (like Notepad++, VS Code, or Sublime Text) and make changes directly.

### 🔑 To Change the Password:
- Locate this line inside the HTML:
  ```javascript
  const correctPassword = "Password";
  ```
- Replace `"Password"` with your own custom access code.

### 💬 To Change the Secret Message:
- Look for this section inside the file:
  ```html
  <div id="portalMessage">
    <p>
      Access granted. Transmission begins...<br><br>
      Rendezvous: 1800 @ 4444 Main St.<br>
      ...
    </p>
  </div>
  ```
- Replace the text within the `<p>...</p>` tags with your **Vigenère-encrypted message**.

Be sure to **test your edits** by opening the file in a browser before sending it to others.

---

Stay encrypted. Stay undetected.  
**—GhostStrats**
