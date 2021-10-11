
<h1>Task 2.1: Linux</h1>
	  
<p><img class="img-responsive" src="images/linux1.png"></p>

<p>1. Username: It is used when user logs in.</p>
<p>2. Password: An x character indicates that encrypted password is stored in /etc/shadow file. Please note that you need to use the passwd command to computes the hash of a password typed at the CLI or to store/update the hash of the password in /etc/shadow file.</p>
<p>3. User ID (UID): Each user must be assigned a user ID (UID). UID 0 (zero) is reserved for root and UIDs 1-99 are reserved for other predefined accounts. Further UID 100-999 are reserved by system for administrative and system accounts/groups.</p>
<p>4. Group ID (GID): The primary group ID (stored in /etc/group file)</p>
<p>5. GECOS or the full name of the user. This field contains a list of comma-separated values with the following information:<br>
User’s full name or the application name.<br>
Room number.<br>
Work phone number.<br>
Home phone number.<br>
Other contact information.</p>
<p>6. Home directory. The absolute path to the user’s home directory. It contains the user’s files and configurations. By default, the user home directories are named after the name of the user and created under the /home directory.</p>
<p>7. Login shell. The absolute path to the user’s login shell. This is the shell that is started when the user logs into the system. On most Linux distributions, the default login shell is Bash.</p>
<p>Pseudo users accounts UIDs 1-999(daemons, pseudo-users, system and reserved users). To defend against
remote login attacks (when SSH key files are used instead of passwords), specify /bin/false or
/bin/nologin as shells (instead of /bin/bash or /bin/sh) </p>

<p>Uid is a simple numeric designation for an individual user. This is usually a positive number not more
than 65535 (sometimes 32-bit). Some identifiers are reserved for special use. These include 0 (root),
1-999(daemons, pseudo-users, system and reserved users), 1000+ (regular users).</p>
<p>Gid - unique identifier of the group within the system to which the user belongs</p>
<p><img class="img-responsive" src="images/linux2.png"></p>

<p><strong>Commands for working with user accounts:</strong></p>
<p>1) useradd [-c uid comment] [-d dir] [-e expire] [-f inactive] [-g gid] [-m [-k skel_dir]] [-s shell]</p>
[-u uid [-o]] username</p>
<p>2) userdel [-r] username</p>
<p>3) usermod [-c uid comment] [-d dir [-m]] [-e expire] [-f inactive] [-g gid] [-G gid [, gid]]</p>
[-l new username] [-s shell] [-u uid [-o]] username</p>
<p><strong>Rename user:</strong></p>
<p>usermod -l login-name old-name</p>
<p>usermod -u UID username</p>
<p><img class="img-responsive" src="images/linux3.png"></p>
<p><strong>Remove user with his directory and mail:</strong>userdel -r username</p>
<p><strong>Lock/unlock users</strong>passwd -l username; passwd -u username</p>
<p><strong>Cancel password</strong>passwd -d username</p>

<p><img class="img-responsive" src="images/linux4.png"></p>
<p>ls -la; <br>Command show following file information:
1. The file type.<br>
2. The file permissions.<br>
3. Number of hard links to the file.<br>
4. File owner.<br>
5. File group.<br>
6. File size.<br>
7. Date and Time.<br>
8. File name.<br>
</p>
<p><strong>Permissions:</strong><br>
The first character indicates the file type:<br>
- - regular file;<br>
d - directory;<br>
b - block device;<br>
c - character device;<br>
l - symbolic link;<br>
p - pipe (pipe, fifo);<br>
s - socket. Nine characters representation as "rwxrwxrwx", where some "r", "w" and "x" can be replaced with "-".<br>
Symbols reflect the three types of access accepted in Linux - read, write and use - however they are<br>
present in triplicate in the shortcut.</p>

<p>When the relationship between the file and the user who started the process, the role is determined as
follows:<br>
If the UID of the file is the same as the UID of the process, the user is the owner of the file<br>
If the GID of the file matches the GID of any group the user belongs to, he is a member of the group to
which the file belongs.<br>
If neither the UID no the GID of a file overlaps with the UID of the process and the list of groups that the
user running it belongs to, that user is an outside</p>
<p><img class="img-responsive" src="images/linux5.png"></p>
<p>Octal value : Permission</p>

<p>0 : read, write and execute</p>
<p>1 : read and write</p>
<p>2 : read and execute</p>
<p>3 : read only</p>
<p>4 : write and execute</p>
<p>5 : write only</p>
<p>6 : execute only</p>
<p>7 : no permissions</p>
<p><img class="img-responsive" src="images/Standartny-e-prava-Unix-SUID-SGID-Sticky-bity-.png"></p>
<p>The umask masks default permission levels by qualifying them with a certain value. umask command output contains permissions bits that will NOT be set in newly created files and directories. If umask= 022, default permissoon for files is: 666 – 022 = 644</p>
<p></p>

<p><img class="img-responsive" src="images/linux6.png"></p>
chmod ugo+rwx file.txt<br>
chmod ugo-x file.txt<br>
chmod o-x file.txt<br>
chmod o+x file.txt<br>
