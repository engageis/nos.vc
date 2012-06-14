CATARSE.StaticGuidelinesView = Backbone.View.extend({
  initialize: function() {
    $('#header header nav.actions ul li.how_works').addClass('selected');

    _.bindAll(this, 'index', 'how_it_works', 'who_organizes_the_meetings', 'how_much', 'why_use')
    CATARSE.router.route("", "index", this.index)
    CATARSE.router.route("how_it_works", "how_it_works", this.how_it_works)
    CATARSE.router.route("who_organizes_the_meetings", "who_organizes_the_meetings", this.who_organizes_the_meetings)
    CATARSE.router.route("how_much", "how_much", this.how_much)
    CATARSE.router.route("why_use", "why_use", this.why_use)
  },
  index: function(){
     CATARSE.router.navigate("how_it_works", {trigger: true})
  },
  how_it_works: function(){
    this.selectItem("how_it_works")
  },
  who_organizes_the_meetings: function(){
    this.selectItem("who_organizes_the_meetings")
  },
  how_much: function(){
    this.selectItem("how_much")
  },
  why_use: function(){
    this.selectItem("why_use")
  },
  selectItem: function(item) {
    this.$(".static_default .default_text .content").hide()
    this.$(".static_default .default_text ." + item + ".content").show()
    var link = this.$(".static_default .sidebar ." + item + "_link")
     this.$(".static_default .sidebar a").removeClass('selected')
    link.addClass('selected')
  }
})

