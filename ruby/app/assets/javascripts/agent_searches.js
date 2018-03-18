function getUserPhotoUrls() {
  var count = $( ".photo-holder > img" ).length;
  $.ajax({
    url: 'https://randomuser.me/api/',
    dataType: 'json',
    data: {
      results: count
    },
    success: function(data) {
      addPhotoUrlsToPage(extractUrls(data));
    }
  });  
}

function extractUrls(response_data) {
  var urls = [];

  $.each(response_data['results'], function( index, value ) {
    urls.push(value['picture']['large']);
  });

  return urls;
}

function addPhotoUrlsToPage(url_list) {
  var counter = 0;
  $( ".photo-holder > img" ).each(function( index ) {
    $(this).attr('src',url_list[counter++]);
  });
}