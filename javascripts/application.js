//= require handlebars.runtime
//= require_tree ./templates
//= require rails

$(document).foundation();

navigator.geolocation.getCurrentPosition(function(position) {
  search['search[ll]'].value = position.coords.latitude+','+position.coords.longitude;
});

$(search).on('ajax:success', function(e, body) {
  var response, html, template;

  response = JSON.parse(body);

  template = HandlebarsTemplates.search_results;

  html = template(response);

  searchResults.children[0].innerHTML = html;
});

$(searchResults).on('ajax:success', '#searchResponseVenues a', function(e, body) {
  var $showVenuePage, response, html, template;

  $showVenuePage = $(showVenuePage);

  response = JSON.parse(body);

  template = HandlebarsTemplates['venues/show'];

  html = template(response);

  $showVenuePage
    .siblings()
      .toggleClass('hide', true)
      .end()
    .toggleClass('hide', false)

  showVenuePage.children[0].innerHTML = html;
});