// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.Block = (function(_super) {
    __extends(Block, _super);

    function Block() {
      _ref = Block.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Block.prototype.enhancePage = function() {
      this.bindWidgetParts();
      return this.bindActionHandlers();
    };

    Block.prototype.initialize = function() {
      if (this.toggleButton != null) {
        this.expanded = false;
        return this.updateToggleButton();
      }
    };

    Block.prototype.extras = function() {
      return this.element.find('p.extra');
    };

    Block.prototype.toggleButtonText = {
      "true": 'Click to show more...',
      "false": 'Click to collapse...'
    };

    Block.prototype.updateToggleButton = function() {
      return this.toggleButton.text(this.toggleButtonText[this.expanded]);
    };

    Block.prototype.toggleExtras = function(e) {
      e.preventDefault();
      this.extras().slideToggle('slow');
      this.expanded = !this.expanded;
      return this.updateToggleButton();
    };

    return Block;

  })(Widget);

}).call(this);