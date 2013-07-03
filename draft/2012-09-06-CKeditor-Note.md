---
layout: post
title: CKeditor Note
date: 2012-09-06 23:42:42
categories: 
	- CKeditor
	- Javascript
---
CKEditor Development Note
======
Basic Plugin Development
------
1. Setting
	Edit ckeditor/config.js. The first part are the total toolbar items and you can load according to your needs. The second part is to load the extra plugin we are going to create.

	``` javascript
		config.toolbar_Full =
		[
			{ name: 'document', items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
			{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
			{ name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
			{ name: 'forms', items : [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 
		        'HiddenField' ] },
			'/',
			{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
			{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv',
			'-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
			{ name: 'links', items : [ 'Link','Unlink','Anchor' ] },
			{ name: 'insert', items : [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ] },
			'/',
			{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
			{ name: 'colors', items : [ 'TextColor','BGColor' ] },
			{ name: 'tools', items : [ 'Maximize', 'ShowBlocks','-','About' ] }
		];

		config.extraPlugins = 'ckvar';
	```

2. Create a plugin with a button at ckeditor/plugins/ckvar/plugin.js

	``` javascript
		CKEDITOR.plugins.add( 'ckvar',
		{
			init : function( editor )
			{
				var pluginName = 'ckvar';
				CKEDITOR.dialog.add(pluginName, this.path + 'dialogs/footnote.js');
				editor.addCommand(pluginName, new CKEDITOR.dialogCommand(pluginName));
				editor.ui.addButton('ckvar',
				{
					label: 'Footnote or Citation',
					command: pluginName
				});
			}
		});
	```	
UI
------
- Combo  
	A example from [here](http://www.kuba.co.uk/blog.php?blog_id=15,"title").

	``` javascript
		CKEDITOR.plugins.add( 'tokens',
		{   
		   requires : ['richcombo'], //, 'styles' ],
		   init : function( editor )
		   {
		      var config = editor.config,
		      lang = editor.lang.format;
		      // Gets the list of tags from the settings.
		      var tags = []; //new Array();
		      //this.add('value', 'drop_text', 'drop_label');
		      tags[0]=["[contact_name]", "Name", "Name"];
		      tags[1]=["[contact_email]", "email", "email"];
		      tags[2]=["[contact_user_name]", "User name", "User name"];
		      // Create style objects for all defined styles.
		      editor.ui.addRichCombo( 'tokens',
		         {
		            label : "Insert tokens",
		            title :"Insert tokens",
		            voiceLabel : "Insert tokens",
		            className : 'cke_format',
		            multiSelect : false,
		            panel :
		            {
		               css : [ config.contentsCss, CKEDITOR.getUrl( editor.skinPath + 'editor.css' ) ],
		               voiceLabel : lang.panelVoiceLabel
		            },
		            init : function()
		            {
		               this.startGroup( "Tokens" );
		               //this.add('value', 'drop_text', 'drop_label');
		               for (var this_tag in tags){
		                  this.add(tags[this_tag][0], tags[this_tag][1], tags[this_tag][2]);
		               }
		            },
		            onClick : function( value )
		            {         
		               editor.focus();
		               editor.fire( 'saveSnapshot' );
		               editor.insertHtml(value);
		               editor.fire( 'saveSnapshot' );
		            }
		         });
		   }
		});
	```

	Here is the gist version.
	<script src="https://gist.github.com/3656034.js"> </script>

Reference
------
- [Offical Guide: Toolbar](http://docs.cksource.com/CKEditor_3.x/Developers_Guide/Toolbar "title")
- [Offical Guide: Create Plugin](http://docs.cksource.com/CKEditor_3.x/Tutorials/Abbr_Plugin_Part_1#Working_Example "title")
- [Voofie: Plugin Development](http://www.voofie.com/content/2/ckeditor-plugin-development/)
- [Another Tutorial](http://www.dotblogs.com.tw/lastsecret/archive/2011/11/30/60185.aspx)
