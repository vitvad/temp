javascript:(function(forms){
	for (var i = 0; i < forms.length; i++) {
		var curForm = forms[i];
		for (var z = 0; z < curForm.elements.length; z++) {
			var el = curForm.elements[z];
			if (el.tagName.toLowerCase() == "input" && (el.type.toLowerCase() == "text" || el.type.toLowerCase() == "password") ) {
				if(el.className.indexOf("mail")!=-1 || el.id.indexOf("mail")!=-1 || el.name.indexOf("mail")!=-1){
					el.value = el.type + "-" + z + "-field@example.com";
				}else{
					el.value = el.type + "-" + z + "-field";
				}
			};
			if (el.tagName.toLowerCase() == "textarea") {
				el.value = el.type + "-" + z + "-" + el.tagName;
			};
			if (el.tagName.toLowerCase() == "select") {
				el.selectedIndex = el.options.length - 1;
			};
		};
	};
	void(0);
})(document.forms);
