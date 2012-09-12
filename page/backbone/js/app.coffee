# Model of Backbone
class ConfigModel extends Backbone.Model
	initialize: ->
		@set 'color': 'blue', 'width': '100', 'height': '100'

# View of Backbone
class ConfigInputView extends Backbone.View
	initialize: ->
		@model.view = @
    
	events:
		'keyup #color-input': "updateConfig"
		'keyup #width-input': "updateConfig"

	updateConfig: (e)=>
		@model.set 'color': $('#color-input').val() , 'width': $('#width-input').val(), 'height': $('#width-input').val()

# View 2
class ColorBoxView extends Backbone.View
	tagName: 'li'
	initialize: ->
		@template = $('#color-box-template').template()
		@model.bind 'change', @render
		@model.view = @

	render: =>
		$(@el).html $.tmpl @template, @model.toJSON()
		return @
