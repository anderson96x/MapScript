# MapScript


I wrote this script to assist me in my current job. In our organization, employees frequently change departments, requiring access to different shared folders. Instead of having separate scripts for each department, this script groups all listed department shared folders and performs the following tasks:

🚩 Tests the user's permission to the shared folders and maps only the ones they have access to.  
⛔ Checks each drive letter to avoid errors in case a drive letter is already in use.
  
     
For example, let's say John works in the HR department. If John needs temporary access to the Financial department's shared folder because the usual person is on vacation, I, as the IT admin, simply grant John permission to access the Financial shared folder. When John logs into a PC, the script automatically maps the Financial folder for him. Once John returns to the HR department, his access is revoked, and the shared folder is automatically removed. John will then only see the HR folder.

So all you gotta do is set this script as the Logon Script on the Active Directory (AD) for each user and just manage permissions on the File Server.


⛏ It probaly has some more efficient ways to solve this kind of problem out there, but this is what I could figure out for now.
