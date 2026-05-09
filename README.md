# Forge GTM: environment setup

This guide installs everything you need to use the Forge GTM template system. Follow each section in order.

---

## Before you start

This guide will take around 20 to 30 minutes. You only need to do it once. After that, your computer is ready to use Forge GTM.

If anything goes wrong or you are unsure about a step, contact your Forge GTM account holder before trying to fix it yourself.

---

## Section 1: Create a GitHub account

GitHub is where your Forge GTM files are stored. You need a free account to access them.

1. Go to [github.com](https://github.com) and click **Sign up**.
2. Enter your work email address and follow the steps to create your account.
3. GitHub will send you a verification email. Open it and click the link to verify your address.
4. You do not need to change any other GitHub settings at this stage.

If you already have a GitHub account, you can use it. Move on to the next section.

---

## Section 2: Install GitHub Desktop

GitHub Desktop is a free application that lets you download and manage your Forge GTM files without using the command line.

1. Go to [desktop.github.com](https://desktop.github.com).
2. Download GitHub Desktop for your operating system (Mac or Windows) and install it.
3. Open GitHub Desktop and sign in with the GitHub account you just created.
4. You do not need to configure anything else at this stage.

---

## Section 3: Clone your Forge GTM repos

Your Forge GTM account holder will send you a list of repository URLs. A repository (or "repo") is a folder of files stored on GitHub. Cloning means downloading a copy to your computer.

Do this for each URL you have been given:

1. Open GitHub Desktop.
2. Click **File** in the menu bar, then click **Clone repository**.
3. Click the **URL** tab.
4. Paste the repo URL into the URL field.
5. Choose where to save the repo on your computer. Make a note of this location, as you will need it later.
6. Click **Clone**.

Repeat these steps until you have cloned all the repos you were given. Do this before moving on to the next section.

---

## Section 4: Install Claude Code

Claude Code is the AI assistant used to operate Forge GTM. You interact with it through a terminal inside your project folders.

1. Go to [claude.ai/download](https://claude.ai/download) and follow the installation instructions for your operating system.
2. When prompted, sign in with your Anthropic account. If you do not have one, you can create one on that page.
3. Once installed, Claude Code is ready. You do not need to configure anything else at this stage.

Note: Claude Code requires a Claude subscription. Your Forge GTM account holder will confirm which plan you need before you start.

---

## Section 5: Run the environment setup script

This step installs the software that Forge GTM needs to run (Node.js, Git, and Ghostscript). The script checks what is already on your computer and only installs what is missing.

Follow the instructions for your operating system below.

---

### Mac

1. In GitHub Desktop, find the **Forge-Setup** repo in the left-hand sidebar and right-click it. Choose **Show in Finder**.
2. Inside the Forge-Setup folder, right-click on an empty area and choose **New Terminal at Folder**. If you do not see that option, open the Terminal application and type `cd ` (with a space after it), then drag the Forge-Setup folder into the Terminal window and press Return.
3. Type the following and press Return:

   ```
   bash setup-mac.sh
   ```

4. Follow any instructions the script displays on screen.
5. When you see **Setup complete. Your environment is ready.** the installation is finished.

---

### Windows (recommended): PowerShell

1. In GitHub Desktop, find the **Forge-Setup** repo in the left-hand sidebar and right-click it. Choose **Show in Explorer**.
2. Inside the Forge-Setup folder, hold the **Shift** key and right-click on an empty area. Choose **Open PowerShell window here** or **Open in Terminal**.
3. If you see a message about execution policy, type the following and press Return, then press **Y** when asked:

   ```
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
   ```

4. Type the following and press Return:

   ```
   .\setup-windows-powershell.ps1
   ```

5. Follow any instructions the script displays on screen.
6. When you see **Setup complete. Your environment is ready.** the installation is finished.

---

### Windows (alternative): Command Prompt

Use this method only if you cannot run the PowerShell script above.

1. In GitHub Desktop, find the **Forge-Setup** repo and right-click it. Choose **Show in Explorer**.
2. Inside the Forge-Setup folder, double-click the file **setup-windows-batch.bat**.
3. If Windows shows a security warning, click **More info** and then **Run anyway**.
4. Follow any instructions the script displays on screen.
5. When you see **Setup complete. Your environment is ready.** the installation is finished.

---

## Section 6: You are ready

Your environment is set up. The software Forge GTM needs is installed, and your repos are on your computer.

Your Forge GTM account holder will confirm which repo to open first and provide a workflow guide covering how to produce materials day to day.

If you run into any problems at any stage, contact your Forge GTM account holder before trying to resolve them yourself.
