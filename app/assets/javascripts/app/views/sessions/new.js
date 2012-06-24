CATARSE.SessionsNewView = Backbone.View.extend({

  initialize: function() {
    _.bindAll(this, "index", "social", "login", "register")
    CATARSE.router.route("", "index", this.index)
    CATARSE.router.route("social", "social", this.social)
    CATARSE.router.route("login", "login", this.login)
    CATARSE.router.route("register", "register", this.register)
    this.render()

  },

  index: function() {
    CATARSE.router.navigate("social", {trigger: true})
  },

  social: function() {
    this.selectItem("social")
  },

  login: function() {
    this.selectItem("login")
  },

  register: function() {
    this.selectItem("register")
  },

  selectItem: function(item) {
    this.$("#page_content .main .content").hide()
    this.$("#page_content .main  ." + item + "_content").show()
    var link = this.$("ul.menu #" + item + "_link")
    link.parent().parent().children().children().removeClass('selected')
    link.addClass('selected')
  }

})

