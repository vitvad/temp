function disable(isDeactivated) {
	// The label color.
	options.style.color = isDeactivated ? 'graytext' : 'black';

	// The control manipulability.
	options.frequency.disabled = isDeactivated;
}

window.addEventListener('load', function() {
	// Initialize the option controls.
	options.isActivated.checked = JSON.parse(localStorage._isActivated);

	// The display activation.
	options.frequency.value = localStorage._frequency;

	// The display frequency, in minutes.
	if (!options.isActivated.checked) { disable(true); }

	// Set the display activation and frequency.
	options.isActivated.onchange = function() {
		localStorage._isActivated = options.isActivated.checked;
		disable(!options.isActivated.checked);
		chrome.extension.sendMessage({appletDisable: !options.isActivated.checked}, function(response){});
	};
	options.isNewWindow.onchange = function() {
		localStorage._isNewWindow = options.isNewWindow.checked;
	};

	options.frequency.onchange = function() {
		localStorage._frequency = options.frequency.value;
		chrome.extension.sendMessage({appletFrequency: options.frequency.value}, function(response){});
	};

/* View Settings */
	options.getSettings.onclick = function(){
		getSettings();
		return false;
	}

	function getSettings(){
		var container = document.querySelector('#settings'), ls = localStorage;
		var html = "<table>";
		for(var i in ls){
			html += "<tr><td title='delete' style='cursor:pointer;' class='deleteItem' data-key='"+ i +"'>[X]</td><td><strong>"+ i +"</strong></td><td>"+ ls[i] +"</td></tr>";
		};
		html += "</table>";
		container.innerHTML = html;
		initDeleteButton();
	}

	function initDeleteButton(){
		var items = document.querySelectorAll("td.deleteItem");
		for(var i=0, len = items.length; i<len; i++) {
			(function(i){
				items[i].onclick = function(e){
					e.preventDefault();
					delete localStorage[items[i].getAttribute("data-key")];
					getSettings();
				}
			})(i);
		};
	}

/* Export/Import Settings */
	options.exportSettings.onclick = function(){
		var container = document.querySelector('#settings'), ls = localStorage;
		var html = "<textarea>"+ JSON.stringify(localStorage) +"</textarea>";
		container.innerHTML = html;
		return false;
	}

	options.importSettings.onclick = function(e){
		var container = document.querySelector('#settings'), ls = localStorage, txt = document.querySelector('textarea');
		if(txt && txt.value != ""){
			try{
				var data = JSON.parse(txt.value);
			}catch(e){alert("Wrong JSON settings")}
			if(typeof data != 'undefined'){
				for(var i in data){
					ls[i] = data[i];
				};
			}
		}
		return false;
	}


});







