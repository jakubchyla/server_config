# Automatic daily news
Downloads and converts news using Calibre recipes and sends them to Kindle by mail.

## Configuration
You have to specify your kindle email address by setting **KINDLE_MAIL** variable in compose.

### exim4

This repo already contains configuration for using gmail smtp,
you only have to create **passwd.client** file in news/exim4/mail_config.  
passwd.client should contain lines of the form
> target.mail.server.example:login-user-name:password

You can use "*" as mail server target to match all.

### Calibre recipes

To add/remove recipes just copy/remove files in **fetch/recipes/** and rebuild image.