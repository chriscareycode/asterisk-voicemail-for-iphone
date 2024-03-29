<?php
/*
	Asterisk Voicemail for iPhone
	Copyright 2008 Christopher P Carey (http://chriscarey.com)
	This program is distributed under the terms of the GNU General Public License
	
	This file is part of Asterisk Voicemail for iPhone.

    Asterisk Voicemail for iPhone is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Asterisk Voicemail for iPhone is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Asterisk Voicemail for iPhone.
	If not, see <http://www.gnu.org/licenses/>.
*/

	require_once("i_db.php");
	require_once("i_settings.php");
	require_once("i_functions.php");
	require_once($g_smarty_class.'Smarty.class.php');
	
	session_start();
	
	// If we have a active cookie, skip this page
	if (isset($_COOKIE['mailbox'])) {
		$_SESSION['mailbox'] = $_COOKIE['mailbox'];
		header("Location: main.php");
	}
	
	// Local Variables
	$debug = false;
	$action = "";   
	$mailbox = "";
	$password = "";
	$login_message = "";
	$login_success = false;
	$p_mailbox = ""; if (isset($_POST['mailbox'])) $p_mailbox = $_POST['mailbox'];
	$p_password = ""; if (isset($_POST['password'])) $p_password = $_POST['password'];
	
	// Add default_prefix if they provide 7 digits
	if (strlen($p_mailbox) == 7) $p_mailbox = $g_default_prefix.$p_mailbox;

	// Set up Smarty	
	$smarty = new Smarty();
	$smarty->template_dir = $g_smarty_folder.'templates';
	$smarty->compile_dir = $g_smarty_folder.'templates_c';
	$smarty->cache_dir = $g_smarty_folder.'cache';
	$smarty->config_dir = $g_smarty_folder.'configs';

	// Assign mailbox to template
	$smarty->assign('mailbox', $p_mailbox);
	
	// Check for Login
	if (strlen($p_mailbox) > 0) {
		
		if ($g_use_database) {
		
			// Authenticate with MySQL
			if (doMySqlAuthentication($p_mailbox, $p_password)) {
				$login_success = true;
			} else {
				$login_success = false;
				$smarty->assign('mailbox_error', 'Login Incorrect');
			}
			
		} else {
		
			// Authenticate with voicemail.conf
			if (doVoicemailConfAuthentication($p_mailbox, $p_password)) {
				$login_success = true;
			} else {
				$login_success = false;
				$smarty->assign('mailbox_error', 'Login Incorrect');
			}			
		}
	}
		
	// If we have successful login, leave this page
	if ($login_success == true) {
		setcookie("mailbox", $p_mailbox, time()+3600*24*14);
		$_SESSION['mailbox'] = $p_mailbox;
		header("Location: main.php");
	}
	
	// If we got this far, we're not logging in. Show the template
	$smarty->display($g_smarty_template_folder.'login.tpl');
	
?>
