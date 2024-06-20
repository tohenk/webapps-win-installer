# WebApps Windows Installer

## Introduction

WebApps Windows Installer provides script to help install Apache HTTPD and PHP
into Windows operating system. It usages mainly to allow easy install or update
Apache HTTPD and PHP by dropping downloaded archive into `Installer`
folder.

WebApps Windows Installer supports binaries downloaded from:
* [Apache Lounge](https://www.apachelounge.com/download/)
* [Windows PHP](https://windows.php.net/download/)
* [PECL extension](https://windows.php.net/downloads/pecl/releases/)

It's required, prior to use the script to install
[Microsoft Visual C++ Redistributable](https://support.microsoft.com/en-us/topic/the-latest-supported-visual-c-downloads-2647da03-1eea-4433-9aff-95f26a218cc0).

## Usage

To install or update Apache HTTPD and PHP, open an *Administrator Command Prompt*
and issue:

```
cd x:\path\to\installer
install.cmd VS16
```

## Additional Scripts

* `services.cmd`, start or stop services defined in `services.dat`
* `switch_app.cmd`, switch web application configuration found in `Conf\vhosts\*.conf`
