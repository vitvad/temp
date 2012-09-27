/*
	*TODO:
		- rating for each words how offen translation for it was showed
		- add other notifications
*/

console.debugMode = true;
function log(){if(console.debugMode = true) console.log(arguments);}


var ownOptions = 4, initialTime = 60000, timerRef, note;
// Conditionally initialize the options.
if (!localStorage.isInitialized) {
	localStorage._isActivated = true;   // The display activation.
	localStorage._frequency = 1;        // The display frequency, in minutes.
	localStorage._isInitialized = true; // The option initialization.
	localStorage._isNewWindow = true;	//open translation in new window
	
	localStorage["a trifle"] = '{"en":"a trifle","ru":"немного","synonyms":["немного","слегка"]}';
	localStorage["beverage"] = '{"en":"beverage","ru":"напиток","synonyms":["напиток","питье"]}';
	localStorage["corresponding"] = '{"en":"corresponding","ru":"соответствующий","synonyms":["соответствующий","соответственный","подобный","ведущий переписку"]}';
	localStorage["dissipation"] = '{"en":"dissipation","ru":"диссипация","synonyms":["диссипация","рассеяние","рассеивание","разложение","распыление","расточительство","расточение","растрачивание","исчезновение","распад","беспутный образ жизни","утечка","преобразование","легкомысленные развлечения"]}';
	localStorage["embarrassed"] = '{"en":"embarrassed","ru":"смущение","synonyms":["смущенный","растерянный","стесненный","запутавшийся в долгах"]}';
	localStorage["intents"] = '{"en":"intents","ru":"намерения"}';
	localStorage["namesake"] = '{"en":"namesake","ru":"тезка","synonyms":["тезка","человек, названный в честь кого-л."]}';
	localStorage["requirements"] = '{"en":"requirements","ru":"требование","synonyms":["требование","запросы","технические требования","реквизиты"]}';
	localStorage["scissors"] = '{"en":"scissors","ru":"ножницы","synonyms":["ножницы"]}';
	localStorage["soapy"] = '{"en":"soapy","ru":"мыльный","synonyms":["мыльный","елейный","вкрадчивый","мылкий","покрытый мылом"]}';
	localStorage["theft"] = '{"en":"theft","ru":"кража","synonyms":["кража","воровство","хищение","покража","украденные вещи"]}';
	localStorage["thieves"] = '{"en":"thieves","ru":"воры"}';
}

chrome.extension.onMessage.addListener(function(request, sender, sendResponse) {
	log("onMessage", request, sender);
	if(request.appletDisable == true){
		if(timerRef) clearTimeout(timerRef);
		note.cancel();
	};
	if(request.appletDisable == false || request.appletFrequency){
		if(timerRef) clearTimeout(timerRef);
		note.cancel();
		getNotification();
	};
});

/********************************** Context menu functionality */

var contextProp = (function getProp(){
	return {
		title: "Translate en-ru",
		contexts : ["selection"],
		onclick: function(info, tab){
			var url = "http://translate.google.ru/#en|ru|" + info.selectionText;

			//create tab with translation
			if(localStorage._isNewWindow == "true"){
				chrome.tabs.create({
					url: url
				}, function(tabObject){
					getData(info);
				});
			}else{
				getData(info);
			};
		}
	}
})();

/* add item to context menu */
chrome.contextMenus.create( contextProp, function(){})

/********************************** Notification functionality */

function getData(info){
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
				log("Catched Data =",data);
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

	if(typeof tabObject != "undefined") log("tabObject=", tabObject);
}

function saveToLocal(item){
	log("Before Save item=", item);
	var lS = window.localStorage;
	lS.setItem(item.en, JSON.stringify(item));
}
function random(max){var min=ownOptions;return Math.floor(Math.random() * (max - min + 1)) + min;}

function getNotification(){
	log("Get Note","Is ", localStorage._isActivated);
	if(localStorage._isActivated == "false") return;

	//Get new one notification with some delay
	timerRef = setTimeout(function(){
		buildNote();
		getNotification();
	}, localStorage._frequency * initialTime);
}

function buildNote(){
	var item = getItem();

	if(item){
		note = window.webkitNotifications.createNotification(
			'16.png',		// The image.
			item.en.toUpperCase(),		// The title.
			"press on me to get the answer"			// The body.
		);

		//Get this Item with translation
		note.onclick = function(){
			if(timerRef) clearTimeout(timerRef);
			note.cancel();

			note = window.webkitNotifications.createNotification(
				'16.png',		// The image.
				item.en + "  -  " + item.ru,		// The title.
				(typeof item.synonyms != "undefined" ? item.synonyms : "")			// The body.
			);
			note.show();
			note.onclose = function(){
				getNotification();
			}
		}

		note.show();
		hideNotification(note);
	}
}

//Hide notification
function hideNotification(note){
	if(timerRef) clearTimeout(timerRef);
	setTimeout(function(){
		note.cancel();
	},7000);
}

function getItem(){
	var num = random(window.localStorage.length - 1), x=0;
	for(var i in window.localStorage){
		if(num == x){
			var item = JSON.parse(window.localStorage[i]);
			log("Get Item", item, "item num =", num, window.localStorage.length - ownOptions);
			return item;
		}
		x++;
	};
}
getNotification();
