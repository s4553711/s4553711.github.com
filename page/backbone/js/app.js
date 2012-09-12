// Generated by CoffeeScript 1.3.3
(function() {
  var ColorBoxView, ConfigInputView, ConfigModel,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  ConfigModel = (function(_super) {

    __extends(ConfigModel, _super);

    function ConfigModel() {
      return ConfigModel.__super__.constructor.apply(this, arguments);
    }

    ConfigModel.prototype.initialize = function() {
      return this.set({
        'color': 'blue',
        'width': '100',
        'height': '100'
      });
    };

    return ConfigModel;

  })(Backbone.Model);

  ConfigInputView = (function(_super) {

    __extends(ConfigInputView, _super);

    function ConfigInputView() {
      this.updateConfig = __bind(this.updateConfig, this);
      return ConfigInputView.__super__.constructor.apply(this, arguments);
    }

    ConfigInputView.prototype.initialize = function() {
      return this.model.view = this;
    };

    ConfigInputView.prototype.events = {
      'keyup #color-input': "updateConfig",
      'keyup #width-input': "updateConfig"
    };

    ConfigInputView.prototype.updateConfig = function(e) {
      return this.model.set({
        'color': $('#color-input').val(),
        'width': $('#width-input').val(),
        'height': $('#width-input').val()
      });
    };

    return ConfigInputView;

  })(Backbone.View);

  ColorBoxView = (function(_super) {

    __extends(ColorBoxView, _super);

    function ColorBoxView() {
      this.render = __bind(this.render, this);
      return ColorBoxView.__super__.constructor.apply(this, arguments);
    }

    ColorBoxView.prototype.tagName = 'li';

    ColorBoxView.prototype.initialize = function() {
      this.template = $('#color-box-template').template();
      this.model.bind('change', this.render);
      return this.model.view = this;
    };

    ColorBoxView.prototype.render = function() {
      $(this.el).html($.tmpl(this.template, this.model.toJSON()));
      return this;
    };

    return ColorBoxView;

  })(Backbone.View);

}).call(this);