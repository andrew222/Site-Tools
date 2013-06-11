app_url = 'http://localhost:3000';

sendAjaxRequest = function(_url, _data, _data_type, _method, _beforeSend, _callback){
	$.ajax({
		url: _url,
		data: _data,
		type: _method,
		dataType: _data_type,
		beforeSend: function(){
			_beforeSend();
		}, 
		complete: function(data){
			if(data.status == 200){
				_callback(data.responseText);
			}
		}
	})
}

loading_img = $('<img>').attr({
	src: '/assets/loading.gif'
})
loading_img.addClass('loading_img')