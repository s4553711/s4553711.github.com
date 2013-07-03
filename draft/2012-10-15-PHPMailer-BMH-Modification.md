---
layout: post
title: PHPMailer-BMH Modification
date: 2012-10-15 15:52:59
categories:
	- PHP
---
PHPMailer-BMH Modification
======
Bounced Mail Process
------
### Conjugation with Codeigniter
1. Download and include it in your custom library

	``` php
	require_once('PHPMailer-BMH/class.phpmailer-bmh.php');
	require_once('PHPMailer-BMH/callback samples/callback_echo.php');
	```

2. Initialization and setup the server info

	``` php
	$bmh = new BounceMailHandler(1);
	$bmh->mailhost = 'mailserver.com';
	$bmh->mailbox_username = 'account_name';
	$bmh->mailbox_password = 'passwd';
	$bmh->port = 993;
	$bmh->service = 'imap/ssl';
	$bmh->service_option = 'novalidate-cert';
	$bmh->testmode = true; // if you are debugging, open it
	```

3. Call the function

	``` php
	$bmh->openMailbox();
	$bmh->processMailbox();
	```

4. Add Custom Rule
	Open phpmailer-bmh_rules.php in the PHPMailer-BMH folder and add the rule you want.

### Fix
While using PHPMailer-BMH as a filter to process campaign feedback, I have to move some mail to specificed mailbox. So I have to active the moveHard and ste the target mailbox name.

	``` php
	$bmh->moveHard = true;
	$bmh->hardMailbox = 'INBOX.ihard';
	```

But I find there is problem while moving email to ihard mailbox. Althought PHPMailer-BMH require the mailbox name started with INBOX, after fixing mailbox name from 'INBOX.ihard' to 'ihard' the problem is fixed

	``` php
	@imap_mail_move($this->_mailbox_link, $x, "ihard");
	```

