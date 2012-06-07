CATARSE.ProjectsStartView = Backbone.View.extend({
  initialize: function() {
    $('#header header nav.actions ul li.submit_project').addClass('selected');
    everything_ok = function(){
      var all_ok = true
      if(!ok('#name'))
        all_ok = false
      if(!ok('#about'))
        all_ok = false
      if(!ok('#when'))
        all_ok = false
      if(!ok('#where'))
        all_ok = false
      if(!ok('#video'))
        all_ok = false
      if(!ok('#leader_name'))
        all_ok = false
      if(!ok('#goal'))
        all_ok = false
      if(!ok('#maximum_backers'))
        all_ok = false
      if(!ok('#how_works'))
        all_ok = false
      if(!ok('#more_info'))
        all_ok = false
      if(!contact_ok())
        all_ok = false
      if(!accepted_terms())
        all_ok = false
      if(all_ok){
        $('input[type=submit]').attr('disabled', false)
      } else {
        $('input[type=submit]').attr('disabled', true)
      }
    }
    ok = function(id){
      var value = $(id).val()
      if(value && value.length > 0){
        $(id).addClass("ok").removeClass("error")
        return true
      } else {
        $(id).addClass("error").removeClass("ok")
        return false
      }
    }
    contact_ok = function(){
      var value = $('#contact').val()
      var re = /^[a-z0-9\._-]+@([a-z0-9][a-z0-9-_]*[a-z0-9-_]\.)+([a-z-_]+\.)?([a-z-_]+)$/
      if(value.match(re)){
        $('#contact').addClass("ok").removeClass("error")
        return true
      } else {
        $('#contact').addClass("error").removeClass("ok")
        return false
      }
    }
    accepted_terms = function(){
      return $('#accept').is(':checked')
    }
    $('#name').keyup(everything_ok)
    $('#about').keyup(everything_ok)
    $('#how_works').keyup(everything_ok)
    $('#more_info').keyup(everything_ok)
    $('#when').keyup(everything_ok)
    $('#where').keyup(everything_ok)
    $('#leader_name').keyup(everything_ok)
    $('#video').keyup(everything_ok)
    $('#goal').keyup(everything_ok)
    $('#maximum_backers').keyup(everything_ok)
    $('#contact').keyup(everything_ok)
    $('#accept').click(everything_ok)
    $('input,textarea,select').live('focus', function(){
      $('p.inline-hints').hide()
      $(this).next('p.inline-hints').show()
    })
    $('#name').focus()
  }
})
