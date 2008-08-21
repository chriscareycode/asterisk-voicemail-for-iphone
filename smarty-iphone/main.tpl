<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
         "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Voicemail for iPhone</title>
<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
<meta name = "format-detection" content = "telephone=no">
<style type="text/css" media="screen">@import "iui/iui.css";</style>
<script type="application/x-javascript" src="iui/iui.js"></script>
<script type="application/x-javascript" src="main.js"></script>
<link rel="apple-touch-icon" href="images/asterisk-voicemail-iphone.png" />
</head>
<body>

<div class="toolbar">
	<h1 id="pageTitle"></h1>
	<a id="backButton" class="button" href="#"></a>
</div>
	
    <ul id="home" title="Main" selected="true">
        <li><a href="#messages"><img align="absmiddle" style="border:0px;height:25px;padding-right:4px;margin-bottom:4px;" src="images/asterisk-logo-sm-1.png" />Messages</a></li>
        <li><a href="#settings">Settings</a></li>
		<!-- li><a href="main.php" target="_self">Refresh Messages</a></li -->
        <li><a href="#about">About</a></li>
		<li><a href="logout.php" target="_self">Logout</a></li>
		<li class="group">Info</li>
		<div style="padding-right:10px;">
			<h3 style="text-align:center;">
			<img src="images/asterisk-logo-3.png" border="0" style="padding-bottom:8px;" /><br />
				{$app_name}<br />
				Logged in as <span style="color:darkblue;">{$mailbox_formatted}</span><br />
			</h3>
		</div>
    </ul>
	
    <ul id="messages" title="Messages">
        <li class="group">Inbox</li>
{foreach from=$messages_inbox key=myId item=i}
		<li id="li_inbox_{$i.file}"><a href="#inbox_{$i.file}"><span style="color:darkblue;">{$i.calleridname}</span><br />
		{$i.calleridnumber} ({$i.duration}sec)</a></li>
{/foreach}
		<li class="group">Saved</li>
{foreach from=$messages_old key=myId item=i}
		<li id="li_old_{$i.file}"><a href="#old_{$i.file}"><span style="color:darkblue;">{$i.calleridname}</span><br />
		{$i.calleridnumber} ({$i.duration}sec)</a></li>
{/foreach} 
    </ul>

{foreach from=$messages_inbox key=myId item=i}
    <ul id="inbox_{$i.file}" title="Message Detail">
	
		<li class="group">Play</li>
		
		<li style="padding:5px 0px 2px 10px">
			<table>
				<tr>
					<td>Play Message: </td>
					<td>
	                    <object type="audio/x-mpeg" data="listen/{$secret_key}/{$mailbox}/INBOX/{$i.file}.mp3" width="48" height="48" autoplay="$
	                    <param name="src" value="listen/{$secret_key}/{$mailbox}/INBOX/{$i.file}.WAV" />
	                    <param name="controller" value="true" />
	                    <param name="autoplay" value="false" />
	                    <param name="autostart" value="0" />
	                    </object>
                    </td>
				</tr>
			</table>
		</li>
		<li class="group">Action</li>
        <!-- li><a href="{$apache_messages_alias}{$mailbox}/INBOX/{$i.file}.mp3" target="_self">Play Message</a></li -->
		<!-- li><a href="listen/{$secret_key}/{$mailbox}/INBOX/{$i.file}.mp3" target="_self">Play Message</a></li -->
		<li><a href="#inbox_{$i.file}_move" target="_self">Move Message</a></li>
		<li><a href="#inbox_{$i.file}_delete" target="_self">Delete Message</a></li>
		<li><a class="nothing" href="tel:{$i.calleridnumber}" target="_self">Call Back {$i.calleridnumber}</a></li>
		<li class="group">Detail</li>
		
		<h3 style="margin-top:7px;padding-left:10px;">
			<div style="text-align:center;padding-right:20px;">
			<div style="font-size:29px;color:darkblue;">{$i.calleridname}</div>
			<div style="font-size:30px;margin-bottom:4px;">{$i.calleridnumber}</div>
			<div style="font-size:24px;">Duration: {$i.duration} seconds</div>
			<div style="font-size:24px;">{$i.datetimebetter}</div>
			</div>
		</h3>
    </ul> 
	
	<ul id="inbox_{$i.file}_delete" title="Delete Message">  
		<li class="group">Verify Delete Message</li>
		<li ><a href="#delete" onclick="doDelete('{$i.file}','INBOX/{$i.file}');return true;">Verify Delete</a></li>
	</ul>
	
	<ul id="inbox_{$i.file}_move" title="Move Message">  
		<li class="group">Move Message</li>
		<li ><a href="#move" onclick="doMove('{$i.file}','INBOX/{$i.file}','Old');return true;">To Saved</a></li>
	</ul>
{/foreach}

{foreach from=$messages_old key=myId item=i}
    <ul id="old_{$i.file}" title="Message Detail">
		<li class="group">Action</li>
        <!-- li><a href="{$apache_messages_alias}{$mailbox}/Old/{$i.file}.mp3" target="_self">Play Message</a></li -->
		<li><a href="listen/{$secret_key}/{$mailbox}/Old/{$i.file}.mp3" target="_self">Play Message</a></li>
		<li><a href="#old_{$i.file}_move">Move Message</a></li>
		<li><a href="#old_{$i.file}_delete" target="_self">Delete Message</a></li>
		<li><a class="nothing" href="tel:{$i.calleridnumber}" target="_self">Call Back {$i.calleridnumber}</a></li>
		<li class="group">Detail</li>
		<h3 style="margin-top:7px;padding-left:10px;">
			<div style="text-align:center;padding-right:20px;">
			<div style="font-size:29px;color:darkblue;">{$i.calleridname}</div>
			<div style="font-size:30px;margin-bottom:4px;">{$i.calleridnumber}</div>
			<div style="font-size:24px;">Duration: {$i.duration} seconds</div>
			<div style="font-size:24px;">{$i.datetimebetter}</div>
			</div>
		</h3>
    </ul>  
	
	<ul id="old_{$i.file}_delete" title="Delete Message">  
		<li class="group">Verify Delete Message</li>
		<li ><a href="#delete" onclick="doDelete('{$i.file}','Old/{$i.file}');return true;">Verify Delete</a></li>
	</ul>
	
	<ul id="old_{$i.file}_move" title="Move Message">  
		<li class="group">Move Message</li>
		<li ><a href="#move" onclick="doMove('{$i.file}','Old/{$i.file}','INBOX');return true;" >To Inbox</a></li>
	</ul> 

{/foreach}
    
	<div id="about" class="panel" title="About Voicemail">
        <h2>{$app_name} v{$app_version}<br />
		by Christopher Carey<br />
		Homepage: <a href="http://chriscarey.com/projects/asterisk/iphone/" target="_blank">Click Here</a><br />
{if $current_version}
		<br />Latest Version: v{$current_version}
{/if}
		</h2>
    </div>
	
    <div id="delete" class="panel" title="Message Deleted">
        <h2>Message has been deleted.</h2>		
		<a style="margin-top:30px;margin-left:0px;" class="button" href="main.php" target="_self">Touch here twice for Main Menu</a>
    </div>
    
	<div id="move" class="panel" title="Message Moved">
        <h2>Message has been moved.</h2>		
		<a style="margin-top:30px;margin-left:0px;" class="button" href="main.php" target="_self">Touch here twice for Main Menu</a>
    </div>
 
	<div id="settings" title="Settings" class="panel">
		<h2>User</h2>
        <fieldset>
            <div class="row">
                <label>Full Name</label>
                <input type="text" name="userName" value="{$c_settings.FullName}"/>
            </div>
            <div class="row">
                <label>Password</label>
                <input type="password" name="password" value="{$c_settings.Password}"/>
            </div>
        </fieldset>
		
        <h2>Playback</h2>
        <fieldset>
			<div class="row">
                <label>Say Caller ID</label>
                <div class="toggle" onclick="settingsSayCallerId()" {if $c_settings.SayCallerId == 'true'}toggled="true"{else}toggled="false"{/if}>
				<span class="thumb"></span>
				<span class="toggleOn">ON</span>
				<span class="toggleOff">OFF</span>
			</div>
            </div>
			<div class="row">
                <label>Envelope</label>
                <div class="toggle" onclick="settingsEnvelope()" {if $c_settings.Envelope == 'true'}toggled="true"{else}toggled="false"{/if}>
				<span class="thumb"></span>
				<span class="toggleOn">ON</span>
				<span class="toggleOff">OFF</span>
			</div>
            </div>
        </fieldset>
        
		<h2>Email</h2>
		<fieldset>
			<div class="row">
                <label>Email</label>
                <input type="text" name="email" value="{$c_settings.Email}"/>
            </div>
			 <div class="row">
                <label>Send to Email</label>
                <div class="toggle" onclick="settingsSendToEmail()" {if $c_settings.SendToEmail == 'true'}toggled="true"{else}toggled="false"{/if}>
				<span class="thumb"></span>
				<span class="toggleOn">ON</span>
				<span class="toggleOff">OFF</span>
			</div>
            </div>
            <div class="row">
                <label>Delete after Email</label>
                <div class="toggle" onclick="settingsDeleteAfterEmail()" {if $c_settings.DeleteAfterEmail == 'true'}toggled="true"{else}toggled="false"{/if}>
				<span class="thumb"></span>
				<span class="toggleOn">ON</span>
				<span class="toggleOff">OFF</span>
			</div>
            </div>
		</fieldset>
		
    </div>
</body>
</html>
