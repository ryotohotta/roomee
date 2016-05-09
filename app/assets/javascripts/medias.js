$(function(){
    $(".button-collapse").sideNav();
    $('.collapsible').collapsible();
    /**
     * jTinder initialization
     */
    $(".a-info").click(function(){
      var href = $(this).attr('href');
      location.href = href;
    });
    $(".a-info").bind('touchstart',function() {
      event.preventDefault();
      $(this).trigger('click');
    });

    $(".swipe-cards").jTinder({
      // dislike callback
        onDislike: function (item) {
          // set the status text
        },
      // like callback
        onLike: function (item) {
          // set the status text
        },
      animationRevertSpeed: 200,
      animationSpeed: 400,
      threshold: 1,
      likeSelector: '.like',
      dislikeSelector: '.dislike'
    });

    /**
     * Set button action to trigger jTinder like & dislike.
     */
    $('.actions .like, .actions .dislike').click(function(e){
      e.preventDefault();
      $(".swipe-cards").jTinder($(this).attr('class'));
    });

    $(document).ready(function(){
      $('.materialboxed').materialbox();
    });
    $(document).ready(function() {
      $('select').material_select();
    });

    $(document).ready(function(){
      $('ul.tabs').tabs();
    });
    $(document).ready(function(){
      $('ul.tabs').tabs('select_tab', 'tab_id');
    });
});