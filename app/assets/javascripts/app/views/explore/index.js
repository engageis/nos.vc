CATARSE.ExploreIndexView = Backbone.View.extend({
  events: {
    "click section.categories a.more_categories": "more_categories"
  },
  initialize: function() {
    $('#header header nav.actions ul li.explore').addClass('selected');
    _.bindAll(this, "render", "ProjectView", "ProjectsView", "initializeView", "recommended", "expiring", "recent", "successful", "category", "search", "updateSearch", "more_categories")
    CATARSE.router.route(":name", "category", this.category)
    CATARSE.router.route("recommended", "recommended", this.recommended)
    CATARSE.router.route("expiring", "expiring", this.expiring)
    CATARSE.router.route("recent", "recent", this.recent)
    CATARSE.router.route("successful", "successful", this.successful)
    CATARSE.router.route("search/*search", "search", this.search)
    CATARSE.router.route("", "index", this.index)
    this.render()
    _this = this;
  },

  ProjectView: CATARSE.ModelView.extend({
    template: function(){
      return $('#project_template').html()
    }
  }),

  ProjectsView: CATARSE.PaginatedView.extend({
    template: function(){
      return $('#projects_template').html()
    },
    emptyTemplate: function(){
      return $('#empty_projects_template').html()
    }
  }),

  search: function(search){
    search = decodeURIComponent(search);
    if(this.$('.section_header .replaced_header')) {
      this.$('.section_header .replaced_header').remove();
    }
    this.$('.section_header .original_title').fadeOut(300, function() {
      $('.section_header').append('<div class="replaced_header"></div>');
      $('.section_header .replaced_header').html('<h1><span>Explore</span> / '+ search +'</h1>');
    })
    this.selectItem("")
    this.initializeView({
      meta_sort: "created_at.desc",
      name_or_headline_or_about_or_user_name_or_user_address_city_contains: search
    })
    var input = this.$('#search')
    if(input.val() != search)
      input.val(search)
  },

  updateSearch: function(){
    var search = encodeURIComponent(this.$('#search').val())
    CATARSE.router.navigate("search/" + encodeURIComponent(search), true)
  },

  index: function(){
    _this.changeReplacedTitle()
    _this.selectItem("recommended")
    _this.initializeView({
      recommended: true,
      not_expired: true,
      meta_sort: "explore"
    })
  },

  recommended: function(){
    this.selectItem("recommended")
    this.initializeView({
      recommended: true,
      not_expired: true,
      meta_sort: "explore"
    })
  },

  expiring: function(){
    this.selectItem("expiring")
    this.initializeView({
      expiring: true,
      meta_sort: "expires_at"
    })
  },

  recent: function(){
    this.selectItem("recent")
    this.initializeView({
      recent: true,
      not_expired: true,
      meta_sort: "created_at.desc"
    })
  },

  successful: function(){
    this.selectItem("successful")
    this.initializeView({
      successful: true,
      meta_sort: "expires_at.desc"
    })
  },

  category: function(name){
    this.selectItem(name)
    this.initializeView({
      category_id_equals: this.selectedItem.data("id"),
      meta_sort: "created_at.desc"
    })
    this.$('section.categories h2.selected_categorie').html(this.selectedItem.html())
  },
  more_categories: function(){
    $('section.categories ul li.other_categorie').toggle('hide');
  },
  initializeView: function(search){
    if(this.projectsView)
      this.projectsView.destroy()
    this.projectsView = new this.ProjectsView({
      modelView: this.ProjectView,
      collection: new CATARSE.Projects({search: search}),
      loading: this.$("#loading"),
      el: this.$("#explore_results .results")
    })
  },

  changeReplacedTitle: function() {
    if(this.$('.section_header .replaced_header')) {
      this.$('.section_header .replaced_header').fadeOut(300, function(){
        $(this).remove();
        $('.section_header .original_title').fadeIn(300);
      });
    }
  },

  selectItem: function(name) {
    this.selectedItem = $('.sidebar a[href=#' + name + ']')
    $('.sidebar .selected').removeClass('selected')
    this.selectedItem.addClass('selected')
    this.$('section.categories h2.selected_categorie').html('')
  },

  render: function(){
    this.$('#header .search input').timedKeyup(this.updateSearch, 1000)
  }

})
