// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){ 

	$("a.preview-property").mouseover(function() { $(this).nextAll("div.listing-popup:first").css("display", "block");});
	
	$("a.preview-property").mouseout(function() { $("div.listing-popup", this.parent).css("display", "none");});
	
	/* Toggle property to favorites */
	$("a.toggle-faves").click(function() {
		var elem = 'a#'+this.id;
		var listingid = this.id;
		$.post("/users/favorites/toggle/" +listingid, 
			function(data) {
				$("div.notification").addClass("success").text("Fabulous. The item has been " + data).toggle();
				
				var anchor = $(elem);
				if (data == 'added') {
					anchor.html("Remove from Favorites"); 
				} else { 
					anchor.html("Add to Favorites"); 
				}
			}, 
			'html'
		);
		return false;
	});

	/* Add a property to favorites */
	$("a.toggle-faves-add").click(function() {
		$.post("/users/favorites/add/" +this.id, function(data) { 
			$("div.notification").addClass("success").text("Congratulations on your success. We've added the item to your favorites list.").toggle(); }, 'html' );
	});
	/* Remove a property from favorites */
	$("a.toggle-faves-remove").click(function() {
		var elem = 'a#'+this.id;
		var listingid = this.id;	
		$.post("/users/favorites/remove/" +listingid, function(data) { 
			$("div.notification").addClass("delete")
				.text("The item has been removed from your favorites list.")
				.toggle();
				// fade the parent div
				$(elem).parents('.favorite-item:first').fadeOut(500);
			}, 
			'html' 
		);
		return false;
	});	
	
	/* SEARCH */
	/* save search */
	$('#search-save-btn').click(function() { 
		var elem = 'a#'+this.id;
		var listingid = this.id;
		
		// get the data from the form fields
		var fieldsArr = new Array();
		if ($('input[name=location]').val() != "") { fieldsArr['location'] = $('input[name=location]').val(); }
        if ($('select[name=bedrooms]').val() != "") { fieldsArr['bedrooms'] = $('select[name=bedrooms]').val(); }
        if ($('select[name=bathrooms]').val() != "") { fieldsArr['bathrooms'] = $('select[name=bathrooms]').val(); }
        if ($('input[name=minyear]').val() != "") { fieldsArr['minyear'] = $('input[name=minyear]').val(); }
        if ($('input[name=maxyear]').val() != "") { fieldsArr['maxyear'] = $('input[name=maxyear]').val(); }
        if ($('select[name=price_low]').val() != "") { fieldsArr['price_low'] = $('select[name=price_low]').val(); }
        if ($('select[name=price_high]').val() != "") { fieldsArr['price_high'] = $('select[name=price_high]').val(); }
        if ($('select[name=property_type]').val() != "") { fieldsArr['property_type'] = $('select[name=property_type]').val(); }
        if ($('input[name=zipcode]').val() != "") { fieldsArr['zipcode'] = $('input[name=zipcode]').val(); }
 		
 		// assemble vars into query string
 		var data = buildQueryString(fieldsArr);

 		$.ajax({
            url: "/users/save-search", 
            type: "POST",
            data: data,     
            cache: false,
            success: function (html) {              
                if (html==1) {        
                     // success returned from post
                
                } else { 
                	// fail returned from post
                	alert('Sorry, unexpected error. Please try again later.');
                }               
            }       
        });

/*
		$.post("/users/save_search", data,
			function(data) {
				$("div.notification").addClass("success").text("Great. We've saved your search.").toggle();
				
				var anchor = $(elem);
				if (data == 'added') {
					anchor.html("Remove from Favorites"); 
				} else { 
					anchor.html("Add to Favorites"); 
				}
			}, 
			'html'
		);
*/

		return false;

	});
	
	/* perform search */
	$('select#bathrooms').change( function() {
		var baths = $("#bathrooms option:selected").val();
		var path = replaceQueryString(window.location.href,"bathrooms",baths)
		window.location = path
	});
	
	$('select#bedrooms').change( function() {
		var beds = $("#bedrooms option:selected").val();
		var path = replaceQueryString(window.location.href,"bedrooms",beds)
		window.location = path	
	});
	
	$('input#minyear').change( function() {
		var path = replaceQueryString(window.location.href,"minyear",$("#minyear").val())
		window.location = path	
	});

	$('input#maxyear').change( function() {
		var path = replaceQueryString(window.location.href,"maxyear",$("#maxyear").val())
		window.location = path	
	});


	$('select#price_low').change( function() {
		var path = replaceQueryString(window.location.href,"price_low",$("#price_low").val())
		window.location = path	
	});


	$('select#price_high').change( function() {
		var path = replaceQueryString(window.location.href,"price_high",$("#price_high").val())
		window.location = path	
	});

	$('input#zipcode').change( function() {
		var path = replaceQueryString(window.location.href,"zipcode",$("#zipcode").val())
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
	
	function buildQueryString(arr) {
	    var s = "";
	    for ( var e in arr )
	    {
	       s += "&" + e + "=" + escape( arr[e] );
	    }
	    return s.substring(1);
	}

});