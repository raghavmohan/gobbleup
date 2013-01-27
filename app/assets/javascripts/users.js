navigator.geolocation.getCurrentPosition(GetLocation);
function GetLocation(location) {
    alert("Lat: " + location.coords.latitude + "Long: " + location.coords.longitude+ " acc: " +location.coords.accuracy);
}


if (window.location.pathname == '/')
	GetLocation();



/*
function getPerformers(position)
{
	var latitude = position.coords.latitude;
	var longitude = position.coords.longitude;

	//window.location.replace("performers/?lat="+latitude+"&long="+longitude);	
	$.get("nearby", { latitude: latitude, longitude: longitude },
  	function(data){
  		var i;
			for (i = 0; i < data.performers.length; i++)
			{
				addPerformer(data.performers[i], data.distances[i]);
			}
  	}
	);
	
}

function addPerformer(p, d)
{
	var a = document.createElement("a");
	a.href = '/performers/' + p.id;
	var inner = '<div class="performer"><div class="back"></div><div class="content">';
	inner += '<img src="https://graph.facebook.com/' + p.uid + '/picture?width=200">';
	inner += '<div class="inner">';
	inner += '<p class="name">' + p.street_name + '</p>';
	inner += '<p class="distance">' + d + ' miles from you</p>';	
	inner += '</div></div>';
	a.innerHTML = inner;
	$("#performersCon").append(a);	

}
*/
