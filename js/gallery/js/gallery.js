/*
 * jQuery IHGallery
 *****************************************************************
	PamamName: Default value	Description
 *****************************************************************
	btnPrev: '.prev'			html selector for prev button
	btnNext: '.next'			html selector for next button
	holder: 'div'			html selector for gallery main holder
	scrollElParent: 'ul'		html selector for gallery main part which will scroll
	scrollEl: 'li'				html selector for elements wrapper of gallery
	numHolder: false			[false of css selector] html selector for thumbs links holder
	numCreate: false			create dinamicly thumbs or use already existed in html(true of false)
	thumbTag: "a"				html selector for thumbs links
	step: false					[true, false, number]
								false - scroll on width of "holder"
								true - scroll on the element width
								[number] - scroll on exactly width in "px"
	type: 'circle'				["circle", "start-end" , "start-end-start"] Switch type of gallery scroll
	direction: 'horisontal'		['horisontal' , 'vertical'] Switch type of gallery scroll 
	onClick: null				CallBack function example: onClick: function(){alert('My callback')}
	onChangeFunc: null			onChangeFunc function example: onChangeFunc: function(){alert('My callback')}
	easing: 'linear'			[animation type: "linear" default - not need easing library] see easing
								if we use other type need include easing library before gallery JS
	switchTime: false			[false or number time in ms] Switch on/off autorotation example - switchTime:2000, //same as 2second
	duration : 500				[number] Time - how long animation continue
 *****************************************************************
 */

jQuery.fn.IHGallery = function(_options){
	// defaults options
	var _options = jQuery.extend({
		btnPrev: '.prev',
		btnNext: '.next',
		holder: 'div',
		scrollElParent: 'ul',
		scrollEl: 'li',
		numHolder: false,
		numCreate: false,
		thumbTag: "a",
		step: false,
		effect: "scroll",
		type: 'circle',
		onClick: null,
		onChangeFunc: null,
		direction: 'horisontal',
		easing: 'linear',
		switchTime: false,
		duration : 1500
	},_options);

	// Number list Create
	jQuery.fn.IHGallery.numListCreate = function(numHolder, scrollEl){
		var numListElC = '';
		for(var i = 0; i < scrollEl.length; i++){
			numListElC += '<li><a href="#">'+(i+1)+'</a></li>';
		}
		jQuery(numHolder).html('<ul>'+numListElC+'</ul>');
	};

	// Number list Activate
	jQuery.fn.IHGallery.numListActive = function(self){
		if(self._settings.effect == "scroll") self.active = getCurElIndex(self);
		if(self.active > self.scrollEl.length - 1) self.active = self.scrollEl.length - 1;
		if (self.numHolder) {
			jQuery(self._settings.thumbTag, self.numHolder).removeClass('active');
			jQuery(self._settings.thumbTag, self.numHolder).eq(self.active).addClass('active');
		}
	};
/* scroll Effect */
	jQuery.fn.IHGallery.scrollEffect = function(self){

		if(_options.direction == "horisontal") self.scrollElParent.css({width: "32000px"});
		self.scrollEl.each(function(){ self.distanceSum += jQuery(this)["outer"+self.eFunc](true);});

		if (_options.step && _options.step !=true){
			self.step = isNumber(_options.step) ? _options.step : self.holder["inner"+self.eFunc]();
		}else if (!_options.step) self.step = self.holder["inner"+self.eFunc]();
		if(self.holder["inner"+self.eFunc]() < self.distanceSum){
			self.bNext.css({display: 'block'});
			self.bPrev.css({display: 'block'});
			if(_options.type=="circle"){
				self.offset = self.distanceSum;
				self.scrollElParent.append(self.scrollEl.clone(true));
				self.scrollElParent.prepend(self.scrollEl.clone(true));
			}
		}

		offsetStartPosition = culcOffset(self.active);
		self.scrollElParent.css( self.direct , - self.offset + offsetStartPosition);
		if(_options.direction == "horisontal") self.scrollElParent.css({width: 3*self.distanceSum + offsetStartPosition});

		//button next "click"
		if (self.bNext) {
			self.bNext.click(function(){
				if (!self.scrollElParent.is(':animated')) {
					if (jQuery.isFunction(_options.onClick)) _options.onClick.apply(this, self);
					moveNext(self);
				}
				return false;
			});
		}

		//button prev "click"
		if (self.bPrev) {
			self.bPrev.click(function(){
				if (!self.scrollElParent.is(':animated')) {
					if (jQuery.isFunction(_options.onClick)) _options.onClick.apply(this, self);
					movePrev(self);
				};
				return false;
			});
		};

//thumbs
		if (_options.numHolder){
			if(_options.numHolder.indexOf('>')==-1 && _options.numHolder.indexOf('<')==-1){
				self.numHolder = jQuery(_options.numHolder, self.gallery)
			}else{
				self.numHolder = jQuery(_options.numHolder);
				jQuery(self.gallery).append(self.numHolder);
			};
			setTimeout(function(){
				jQuery.fn.IHGallery.numListActive(self);
				numClick(self);
			},100);
		};

		auto(self);
	};

/* fade Effect */
	jQuery.fn.IHGallery.fadeEffect = function(self){
		var aList;
		self.scrollEl.css({
			"position":"absolute",
			"top":0,
			"left": 0,
			"zIndex": 1,
			"display": "none",
			"opacity": 0
		}).eq(self.active).css({
			"zIndex": 2,
			"display": "block",
			"opacity": 1
		}).css("opacity", "auto");
		if(self.holder.height() == 0){
			self.holder.css({
				height: self.scrollEl.eq(self.active).height(),
				width: self.scrollEl.eq(self.active).width()
			});
		};

		if(self.scrollEl.length > 1){
			self.bNext.css({display: 'block'});
			self.bPrev.css({display: 'block'});
		}

		autoSwitch();

		function autoSwitch(){
			if (self.switchTime){
				if(self._t) clearTimeout(self._t);
				self._t = setTimeout(function(){
					if(self.active < self.scrollEl.length - 1) changeEl(self.active + 1);
					else changeEl(0);
				}, self.switchTime);
			}
		}

		//button next "click"
		if (self.bNext) {
			self.bNext.click(function(){
				if (!self.scrollElParent.is(':animated')) {
					var _nextItem = 0;
					if (self.active < self.scrollEl.length - 1) _nextItem = self.active+1;
					else _nextItem = 0;
					changeEl(_nextItem);
				};
				return false;
			});
		}

		//button prev "click"
		if (self.bPrev) {
			self.bPrev.click(function(){
				if (!self.scrollElParent.is(':animated')) {
					var _prevItem = 0;
					if (self.active > 0) _prevItem = self.active-1;
					else _prevItem = self.scrollEl.length-1;
					changeEl(_prevItem);
				};
				return false;
			});
		};

		//thumbs
		if (_options.numHolder){
			if(_options.numHolder.indexOf('>')==-1 && _options.numHolder.indexOf('<')==-1){
				self.numHolder = jQuery(_options.numHolder, self.gallery)
			}else{
				self.numHolder = jQuery(_options.numHolder);
				jQuery(self.gallery).append(self.numHolder);
			};
			setTimeout(function(){
				jQuery.fn.IHGallery.numListActive(self);
				aList = jQuery(self.numHolder, self.gallery).find(self._settings.thumbTag);
				aList.unbind('click.thumbs').bind('click.thumbs', function(){
					if(self.scrollElParent.is(':animated')) self.scrollElParent.stop(true, true);
					var ind = aList.removeClass('active').index($(this).addClass('active'));
					changeEl(ind);
					return false;
				});
			},100);
		}

		function changeEl(ind){
			if(self._t) clearTimeout(self._t);
			if(self.scrollEl.is(':animated')) self.scrollEl.stop(true, true);
			if(ind != self.active){
				if (_options.numHolder) aList.removeClass('active').eq(ind).addClass('active');
				self.scrollEl.eq(self.active).removeClass('active').css({"zIndex": 1}).animate({opacity: 0}, {queue:false, duration: self._settings.duration, easing: self._settings.easing, complete: function(){$(this).css({display:'none'})}});
				self.scrollEl.eq(ind).addClass('active').css({opacity: 0, display:'block', "zIndex": 2}).animate({opacity: 1}, {queue:false, duration: self._settings.duration, easing: self._settings.easing, complete:function(){
					$(this).css('opacity', 'auto');
					self.active = ind;
					autoSwitch();
					if (jQuery.isFunction(_options.onChange)) {
						_options.onChangeFunc.apply(self,self);
					};
				}});
			}
		}
	};

	return this.each(function(){
		var self = {}, offset = 0, offsetStartPosition = 0, func = (_options.direction == "horisontal" ? "width" : "height"), eFunc = (_options.direction == "horisontal" ? "Width" : "Height"), direct = (_options.direction == "horisontal" ? "left" : "top");
		self = {
			_settings: {},
			_t: null,
			gallery: this,
			distanceSum: 0,
			offset: 0,
			func : func,
			eFunc : eFunc,
			direct: direct
		};
		jQuery.extend(self._settings, _options);

		self.bNext = jQuery(_options.btnNext, self.gallery).length ? jQuery(_options.btnNext, self.gallery) : false;
		self.bPrev = jQuery(_options.btnPrev, self.gallery).length ? jQuery(_options.btnPrev, self.gallery) : false;

		self.holder = jQuery(_options.holder, self.gallery);
		self.scrollElParent = jQuery(_options.scrollElParent, self.holder).css("position","relative");
		self.scrollEl = jQuery(_options.scrollEl, self.scrollElParent);

		self.active = self.scrollEl.index(self.scrollEl.filter('.active'));
		if (self.active==-1) self.active = 0;
		self.scrollEl.removeClass('active').eq(self.active).addClass('active');
		if(_options.switchTime) self.switchTime = _options.switchTime + _options.duration;

		if(self._settings.effect == "scroll") jQuery.fn.IHGallery.scrollEffect(self);
		if(self._settings.effect == "fade") jQuery.fn.IHGallery.fadeEffect(self);

		// init creating num list
		if (_options.numCreate) jQuery.fn.IHGallery.numListCreate(self.numHolder, self.scrollEl);
	});

	function moveNext(self){
		var offset;
		if (self._settings.step && self._settings.step ==true){
			if(self._settings.type=="circle"){
				if(self.active + 1 <= self.scrollEl.length) self.active++;
				else self.active = 0;
				offset = self.scrollElParent.find(self._settings.scrollEl).eq(self.active).position()[self.direct] + self.distanceSum;
			}else{
				if(self.active + 1 < self.scrollEl.length) self.active++;
				else self.active = (self._settings.type=="start-end" ? self.scrollEl.length -1 : 0);
				offset = self.scrollEl.eq(self.active).position()[self.direct];
			}
		}else{
			offset = self.offset;
			offset += self.step;
		};

		if(self._settings.type =="start-end-start"){
			if(self.offset == (self.distanceSum - self.holder["inner"+self.eFunc]())) offset = 0;
		}
		if(self._settings.type !="circle"){
			if(offset > (self.distanceSum - self.holder["inner"+self.eFunc]())) offset = self.distanceSum - self.holder["inner"+self.eFunc]();
		}

		self.offset = offset;
		rotate(self);
	}

	function movePrev(self){
		var offset;
		if (self._settings.step && self._settings.step ==true){
			if(self._settings.type=="circle"){
				if(self.active - 1 < 0){
					self.active = self.scrollEl.length - 1;
					offset = self.scrollElParent.find(self._settings.scrollEl).eq(self.active).position()[self.direct];
				}else{
					self.active--;
					offset = self.scrollElParent.find(self._settings.scrollEl).eq(self.active).position()[self.direct] + self.distanceSum;
				}
			}else{
				if(self.active - 1 < 0) self.active = (self._settings.type=="start-end" ? 0 : self.scrollEl.length - 1)
				else self.active--;
				offset = self.scrollEl.eq(self.active).position()[self.direct];
			}
		}else{
			offset = self.offset;
			offset -= self.step;
		};


		if(self._settings.type =="start-end-start"){
			if(self.offset == 0) offset = self.distanceSum - self.holder["inner"+self.eFunc]();
		}
		if(self._settings.type !="circle"){
			if(offset < 0 ) offset = 0;
		}

		self.offset = offset;
		rotate(self);
	}

	function auto(self){
		if (self.switchTime){
			self._t = setTimeout(function(){
				moveNext(self);
			}, self.switchTime );
		}
	}

	// get offset of gallery when active element not first at start 
	function culcOffset(self, ind){
		var tmpcounter=0;
		var pos=0;
		while (tmpcounter < ind){
			pos += self.scrollEl.eq(tmpcounter)["outer"+eFunc](true);
			tmpcounter++;
		};
		return pos;
	}

	function rotate(self){
		var direct = self.direct, params = {};
		if(self._t) clearTimeout(self._t);
		params[self.direct] = -self.offset; /* hack - create dinamic css rule key and value into $.animate */

		self.scrollElParent.stop(true, true).animate( params , {duration: self._settings.duration, easing: self._settings.easing, complete:function(){
			if(self._settings.type =="circle"){
				if (self.offset < self.distanceSum){
					self.offset = self.distanceSum * 2 - (self.distanceSum - self.offset);
				}else if (self.offset >= self.distanceSum * 2) {
					self.offset = self.distanceSum + (self.offset - self.distanceSum * 2);
				}
			}
			self.scrollElParent.css(direct, -self.offset);
			jQuery.fn.IHGallery.numListActive(self);

			if (jQuery.isFunction(self._settings.onChangeFunc)) {
				self._settings.onChangeFunc.apply(self, self);
			}
			//autoslide
			auto(self);
		}});
	}

	function isNumber(x){ 
		return ( (typeof x === typeof 1) && (null !== x) && isFinite(x) );
	}

	//click on control elemens
	function numClick(self){
		jQuery(self.numHolder, self.gallery).find(self._settings.thumbTag).unbind('click.thumbs').bind('click.thumbs', function(){
			if(self.scrollElParent.is(':animated')) self.scrollElParent.stop(true, true);
			var aList = jQuery(self.numHolder, self.gallery).find(self._settings.thumbTag);
			var index = aList.index(this);
			self.offset = self.scrollElParent.find(self._settings.scrollEl).eq( (self._settings.type =="circle" ? index + self.scrollEl.length : index ) ).position()[self.direct];

			rotate(self);
			return false;
		});
	};

	//curent position
	function getCurElIndex(self){
		var curMargin = parseInt(self.scrollElParent.css(self.direct)) + (self._settings.type =="circle" ? self.distanceSum : 0);
		for(i=0; i < self.scrollEl.length; i++){
			if (curMargin == 0) return i;
			if (curMargin <= 0) curMargin += self.scrollEl.eq(i)["outer"+self.eFunc](true);
			else curMargin -= self.scrollEl.eq(i)["outer"+self.eFunc](true);
			if (curMargin == 0) return i+1;
		}
	}
}