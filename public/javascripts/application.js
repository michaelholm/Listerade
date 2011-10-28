// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){ 
	$('select#bathrooms').change( function() {
		var baths = $("#bathrooms option:selected").val();
		var path = replaceQueryString(window.location.href,"baths",baths)
		window.location = path
	});
	
	$('select#bedrooms').change( function() {
		var beds = $("#bedrooms option:selected").val();
		var path = replaceQueryString(window.location.href,"beds",beds)
		window.location = path	
	});
	
	
/*
	$('select#ltype').change( function() {
		var ltype = $("#ltype option:selected").val();
		var path = replaceQueryString(window.location.href,"property_type",ltype)
		window.location = path	
	});
*/
	
	$('select#ltype').change( function() {
		var ltype = $("#ltype option:selected").val();
		var path = replaceQueryString(window.location.href,"property_type",ltype)
		window.location = path	
	});
	
	/*
		$('select#ltype').change( alert($("#ltype option:selected")) );
		$('select#state').change( alert($("#state option:selected")) );
		$('select#city').change( alert($("#city option:selected")) );
		$('select#county').change( alert($("#county option:selected")) );
		$('select#zipcode').change( alert($("#zipcode option:selected")) );
	*/
	
	function replaceQueryString(url,param,value) {
	    var re = new RegExp("([?|&])" + param + "=.*?(&|$)","i");
	    if (url.match(re)) 
	        return url.replace(re,'$1' + param + "=" + value + '$2');
	    else
	        return url + '&' + param + "=" + value;
	    
	}

});