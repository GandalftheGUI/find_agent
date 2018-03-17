function getUserPhotoUrls(count) {
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
  console.log(url_list);
}