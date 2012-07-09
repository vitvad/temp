console.debugMode = true;
function log(){if(console.debugMode = true) console.log(arguments);}

var contextProp  = {
	title: "Translate en-ru",
	contexts : ["selection"],
	onclick: function(info, tab){
		var url = "http://translate.google.ru/#en|ru|" + info.selectionText;

		//create tab with translation
		chrome.tabs.create({
			url: url
		}, function(tabObject){

			var url = "http://translate.google.ru/#en|ru|" + info.selectionText;

			var req = new XMLHttpRequest();
			req.open("GET", "http://translate.google.ru/translate_a/t?client=t&text="+ info.selectionText +"&hl=ru&sl=en&tl=ru&ie=UTF-8&oe=UTF-8&multires=1&ssel=0&tsel=0&sc=1", true);
			req.onreadystatechange = function(){
				 if (req.readyState == 4) {
					if (req.status == 200) {

						var ar = req.responseText.split(',');
						for(var i=0; i< ar.length; i++){
							if(!ar[i]) ar[i] = '""';
						};
						//convert string to array
						var data = JSON.parse(ar.join(','));

						//create new item
						var item = {};
						item.en = info.selectionText;
						try{
							item.ru = data[0][0][0];
							item.synonyms = data[1][0][1];
						}catch(e){}
						log(data, item);
						//save word
						saveToLocal(item);
					};
				}
			};
			req.send(null);

			log("tabObject=", tabObject);
		});
	}
};

function saveToLocal(item){
	log("item=", item);
	var lS = window.localStorage;
	lS.setItem(item.en, item.toString());
}
function random(max){var min=0;return Math.floor(Math.random() * (max - min + 1)) + min;}

function getNotification(){
	var num = random(window.localStorage.length - 1), x=0;
	for(var i in window.localStorage){
		if(num == x){
			var item =  JSON.parse(window.localStorage[i]);
			break;
		}
		x++;
	};
	console.log(item, "item", num, window.localStorage.length);
	var notification = window.webkitNotifications.createNotification(
		'tt.png',                      // The image.
		item.en, // The title.
		'ololo'      // The body.
	);
	notification.show();
	setTimeout(function(){
		notification.cancel();
		getNotification();
	}, 3000);

	notification.onclick = function(){
		alert(1);
	}
	//return item;
}
//getNotification();

/* add item to context menu */
chrome.contextMenus.create( contextProp, function(){})