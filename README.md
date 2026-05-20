# WebApps Windows Installer

## Introduction

WebApps Windows Installer provides script to help install Apache HTTPD and PHP
into Windows operating system. It usages mainly to allow easy install or update
Apache HTTPD and PHP by dropping downloaded archive into `Installer`
folder.

WebApps Windows Installer supports binaries downloaded from:
* [Apache Lounge](https://www.apachelounge.com/download/)
* [Windows PHP](https://windows.php.net/download/)
* [PECL extension](https://pecl.php.net/)

It's required, prior to use the script to install
[Microsoft Visual C++ Redistributable](https://support.microsoft.com/en-us/topic/the-latest-supported-visual-c-downloads-2647da03-1eea-4433-9aff-95f26a218cc0).

## Usage

To install or update Apache HTTPD and PHP, open an *Administrator Command Prompt*
and issue:

```cmd
cd /d D:\path\to\installer
install.cmd VS18
```

```
WebApps Installer 1.4
(c) 2021-2026 Toha <tohenk@yahoo.com>
-------------------------------------

Host is Windows 64-bit
Current dir is D:\path\to\installer\
The 'Apache2.4' service is not started.
Removing the 'Apache2.4' service
The 'Apache2.4' service has been removed successfully.
Installing Apache httpd from httpd-2.4.67-260504-Win64-VS18.zip
PHP version available:
1. PHP-8.4
2. PHP-8.5
Enter choice: 2
Installing PHP from PHP-8.5\php-8.5.6-Win32-vs17-x64.zip
Restoring php.ini
Restoring php-cli.ini
Checking PHP Apache module for version 8
Enable PHP extensions in D:\PROJ\Webapps\PHP\php.ini
Enable PHP extensions in D:\PROJ\Webapps\PHP\php-cli.ini
Checking for extension install memcache
Installing memcache extension from PHP-8.5\php_memcache-8.2-8.5-ts-vs17-x64.zip
Checking for extension install mongodb
Installing mongodb extension from PHP-8.5\php_mongodb-2.3.1-8.5-ts-vs17-x64.zip
Checking for extension install xdebug
Installing xdebug extension from PHP-8.5\php_xdebug-3.5.1-8.5-ts-vs17-x64.zip
Installing the 'Apache2.4' service
The 'Apache2.4' service is successfully installed.
Testing httpd.conf....
Errors reported here must be corrected before the service can be started.
[SC] ChangeServiceConfig SUCCESS
```

## Additional Scripts

* `services.cmd`, start or stop services defined in `services.dat`
* `switch_app.cmd`, switch web application configuration found in `Conf\vhosts\*.conf`
