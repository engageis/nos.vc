
// Provisional
CATARSE_INIT = {
  explore:{
    index: function(){
       window.view = new CATARSE.ExploreIndexView({el: $("body") });
    }
  },
  projects: {
    index: function(){
      window.view = new CATARSE.ProjectsIndexView({el: $("body") });
    },
    show: function(){
      window.view = new CATARSE.ProjectsShowView({el: $("body") });
    },
    embed: function(){
      window.view = new CATARSE.ProjectsEmbedView({el: $("body") });
    },
    video_embed: function(){
      window.view = new CATARSE.ProjectsVideo_embedView({el: $("body") });
    },
    'new': function(){
      window.view = new CATARSE.ProjectsNewView({el: $("body") });
    },
    pending: function(){
      window.view = new CATARSE.ProjectsPendingView({el: $("body") });
    },
    pending_backers: function(){
      window.view = new CATARSE.ProjectsPending_backersView({el: $("body") });
    },
    start: function(){
      window.view = new CATARSE.ProjectsStartView({el: $("body") });
    },
    backers: {
      'new': function(){
        window.view = new CATARSE.BackersNewView({el: $("body") });
      },
      review: function(){
        window.view = new CATARSE.BackersReviewView({el: $("body") });
      }
    }
  },
  static: {
    guidelines: function(){
      window.view = new CATARSE.StaticGuidelinesView({el: $("body") });
    }
  },
  users: {
    show: function(){
      window.view = new CATARSE.UsersShowView({el: $("body") });
    }
  }
}





jQuery(function () {
  var body, controllerClass, controllerName, action;

  body = $('#main_content');
  controllerClass = body.data( "controller-class" );
  controllerName = body.data( "controller-name" );
  action = body.data( "action" );

  function exec(controllerClass, controllerName, action) {
    var ns, railsNS;

    ns = CATARSE_INIT;
    railsNS = controllerClass ? controllerClass.split("::").slice(0, -1) : [];

    _.each(railsNS, function(name){
      if(ns) {
        ns = ns[name];
      }
    });

    if ( ns && controllerName && controllerName !== "" ) {
      if(ns[controllerName] && _.isFunction(ns[controllerName][action])) {
        var view = window.view = new ns[controllerName][action]();
      }
    }
  }

  function exec_filter(filterName){
    if(CATARSE.Common && _.isFunction(CATARSE.Common[filterName])){
      CATARSE.Common[filterName]();
    }
  }

  exec_filter('init');
  exec( controllerClass, controllerName, action );
  exec_filter('finish');
});
