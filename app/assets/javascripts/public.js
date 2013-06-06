app_url = 'http://localhost:3000';

sendAjaxRequest = function(_url, _data, _data_type, _method, _callback){
	console.log('_url:' + _url );
	console.log('_data:' + _data );
	console.log('_method:' + _method );
	console.log('_callback:' + _callback );
	$.ajax({
		url: _url,
		data: _data,
		type: _method,
		dataType: _data_type,
		success: function(data){
			console.log(data);
			_callback();
		}
	})
}