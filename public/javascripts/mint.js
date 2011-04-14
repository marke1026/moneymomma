/* 
Author: JP Schwinghamer | Mint.com
*/

$(document).ready(function(){

	//Login
	
	if($('body').hasClass('home') && showLoginForm){  // If we're on the homepage and the showLoginForm var (T&T) is present
		if($.cookie('wa_login') == null){ // If the wa_login cookie is absent (if the user is not a current active user)
			$('#credentials').remove(); // Remove login credentials form
		}
		else { // So if the wa_login cookie is present (if the user is an active user)
			$('#credentials #password, #credentials #username').css({opacity: 1});  // Fade In the credentials form
			if($.cookie('mintRememberMe') != null){ // If the remember me cookie is present
				$('#credentials #username').val($.cookie('mintRememberMe'));  // Set the username value to the cookie value
				$('#credentials #password').val('');  // Remove the faux password to prevent confusion
			} // Done fading in form
			
			$('#user_auth .login.button').click(function(){  // When the user clicks the login button
				if($('#remember').is(':checked')){  /* If the remember me checkbox is checked */
					$.cookie('mintRememberMe', $('#username').val(), {expires: 7, path: '/', domain: '.mint.com'}); // Create the remember me cookie with the username
				}
				else	{  // If it's not checked
					$.cookie('mintRememberMe', null, {expires: -7, path:'/', domain: '.mint.com'}); // Clear the remember me cookie
				}
				$('#credentials').submit();  // Submit the form
				return false;
			})
		} 
		
		$('#user_auth input').focus(function(){ // On focus
			$('.form_box').animate({opacity: 1}, 300);  // Fadein the form background
			$('#user_auth .hide').animate({opacity: 1}, 300); // Fadein anything with the hide class (form elements)
			if($('#user_auth #username').val() == 'Email') {  // If the form is in the default state, 'Email' is still the input value
				$('#credentials #password, #credentials #username').val(''); // Clear the input values			
			}
			if($.cookie('mintRememberMe') != null){  // If the remember me cookie is set
				$('#remember').attr('checked', true);
			}
		})
			
		$('#user_auth').keypress(function(e){  // If you the user presses a key while in the form
			if(e.which == 13){ // If that key is 'enter'
				if($('#remember').is(':checked')){  /* If the remember me checkbox is checked */
					$.cookie('mintRememberMe', $('#username').val(), {expires: 7, path: '/', domain: '.mint.com'}); // Create the remember me cookie with the username
				}
				else	{  // If it's not checked
					$.cookie('mintRememberMe', null, {expires: -7, path:'/', domain: '.mint.com'}); // Clear the remember me cookie
				}
		  		$('#credentials').submit(); //Submit the credentials form
		  		e.preventDefault();
		  	}
		})
	}
	else	{ // If we're not on the homepage or the showLoginForm is false
		$('#credentials').remove(); // Remove the credentials form from the DOM
	}
	
	
	//Homepage Tabs
	
	//Hoverintent Config
	
	var config = {    
    	over: tabon, // function = onMouseOver callback (REQUIRED)    
    	interval: 50, 
    	timeout: 300, // number = milliseconds delay before onMouseOut    
    	out: taboff // function = onMouseOut callback (REQUIRED)
	}	
	
	$('#tab_menu li').hoverIntent(config);
	
	function tabon()	{
		$(this).addClass('active').siblings().removeClass('active').removeClass('next');
		$(this).next().addClass('next');
		var tab = $(this).attr('title');
		
		if($('#' + tab).is(':visible')){
			return false;
		}
		else{
			if($.browser.msie){
				$('.tab:visible').hide();
				$('#' + tab).show();
			}
			else {
				$('.tab:visible').fadeOut(500);
				$('#' + tab).fadeIn(500);
			}
		}
	};
	
	function taboff()	{
		return false
	};
	
	//Homepage Tour
	
	//Home
	
	$('#slide1 .violator').click(function(){
		$('.canada').fadeOut();
		$('#tour_container').animate({right: '950'});
		$('.tour_hero .prev_slide').addClass('active').fadeIn().animate({left: '0'});
		$('.tour_hero .next_slide').addClass('active').fadeIn().animate({right: '0'});
		$('#tour_position #position2').addClass('active').siblings().removeClass('active');	
		
		// Dynamic Tour Image Loader Hover
		if($('#slide2 .thumb').length == 0) {
			$('#slide2').append('<img src="images/rd/home/tour/tour_accounts.png" class="thumb"/>');
			$('#slide3').append('<img src="images/rd//home/tour/tour_transactions.png" class="thumb"/>');
			$('#slide4').append('<img src="images/rd/home/tour/tour_graphs.png" class="thumb"/>');
			$('#slide5').append('<img src="images/rd/home/tour/tour_alerts.png" class="thumb"/>');
			$('#slide6').append('<img src="images/rd/home/tour/tour_pig.png" class="thumb"/>');
			$('#slide7').append('<img src="images/rd/home/tour/tour_lock.png" class="thumb"/>');
		}
			
		return false;
	})
	
		//Indicator
		$('#tour_position #position1').click(function(){
			$(this).addClass('active').siblings().removeClass('active');
			$('#tour_container').animate({right: '0'});
			$('.tour_hero .prev_slide').addClass('active').fadeIn().animate({left: '950'});
			$('.tour_hero .next_slide').addClass('active').fadeIn().animate({right: '-950'});
		})
	
	//Slide 2
	
	$('#slide2 .prev_panel').click(function(){
		$('#tour_container').animate({right: '-=950'});
		$('.tour_hero .prev_slide').animate({left: '950'});
		$('.tour_hero .next_slide').animate({right: '-950'});
		$('#tour_position #position1').addClass('active').siblings().removeClass('active');		
	});
	
	$('#slide2 .next_panel').click(function(){
		$('#tour_container').animate({right: '+=950'});
		$('#tour_position #position3').addClass('active').siblings().removeClass('active');		
	});
	
		/* Indicator */
		$('#tour_position #position2').click(function(){
			$(this).addClass('active').siblings().removeClass('active');
			$('#tour_container').animate({right: '950'});
			$('.tour_hero .prev_slide').addClass('active').fadeIn().animate({left: '0'});
			$('.tour_hero .next_slide').addClass('active').fadeIn().animate({right: '0'});
		})
	
	//Slide 3
	
	$('#slide3 .prev_panel').click(function(){
		$('#tour_container').animate({right: '-=950'});
		$('#tour_position #position2').addClass('active').siblings().removeClass('active');		
	});

	$('#slide3 .next_panel').click(function(){
		$('#tour_container').animate({right: '+=950'});
		$('#tour_position #position4').addClass('active').siblings().removeClass('active');		
	});
	
		/* Indicator */
		$('#tour_position #position3').click(function(){
			$(this).addClass('active').siblings().removeClass('active');
			$('#tour_container').animate({right: '1900'});
			$('.tour_hero .prev_slide').addClass('active').fadeIn().animate({left: '0'});
			$('.tour_hero .next_slide').addClass('active').fadeIn().animate({right: '0'});
		})

	//Slide 4
	
	$('#slide4 .prev_panel').click(function(){
		$('#tour_container').animate({right: '-=950'});
		$('#tour_position #position3').addClass('active').siblings().removeClass('active');		
	});

	$('#slide4 .next_panel').click(function(){
		$('#tour_container').animate({right: '+=950'});
		$('#tour_position #position5').addClass('active').siblings().removeClass('active');		
	});

		/* Indicator */
		$('#tour_position #position4').click(function(){
			$(this).addClass('active').siblings().removeClass('active');
			$('#tour_container').animate({right: '2850'});
			$('.tour_hero .prev_slide').addClass('active').fadeIn().animate({left: '0'});
			$('.tour_hero .next_slide').addClass('active').fadeIn().animate({right: '0'});
		})

	//Slide 5
	
	$('#slide5 .prev_panel').click(function(){
		$('#tour_container').animate({right: '-=950'});
		$('#tour_position #position4').addClass('active').siblings().removeClass('active');		
	});

	$('#slide5 .next_panel').click(function(){
		$('#tour_container').animate({right: '+=950'});
		$('#tour_position #position6').addClass('active').siblings().removeClass('active');		
	});
	
		/* Indicator */
		$('#tour_position #position5').click(function(){
			$(this).addClass('active').siblings().removeClass('active');
			$('#tour_container').animate({right: '3800'});
			$('.tour_hero .prev_slide').addClass('active').fadeIn().animate({left: '0'});
			$('.tour_hero .next_slide').addClass('active').fadeIn().animate({right: '0'});
		})

	//Slide 6
	
	$('#slide6 .prev_panel').click(function(){
		$('#tour_container').animate({right: '-=950'});
		$('#tour_position #position5').addClass('active').siblings().removeClass('active');		
	});

	$('#slide6 .next_panel').click(function(){
		$('#tour_container').animate({right: '+=950'});
		$('#tour_position #position7').addClass('active').siblings().removeClass('active');		
	});
	
		/* Indicator */
		$('#tour_position #position6').click(function(){
			$(this).addClass('active').siblings().removeClass('active');
			$('#tour_container').animate({right: '4750'});
			$('.tour_hero .prev_slide').addClass('active').fadeIn().animate({left: '0'});
			$('.tour_hero .next_slide').addClass('active').fadeIn().animate({right: '0'});
		})

	//Slide 7
	
	$('#slide7 .prev_panel').click(function(){
		$('#tour_container').animate({right: '-=950'});
		$('.tour_hero .next_slide').fadeIn();
		$('#tour_position #position6').addClass('active').siblings().removeClass('active');		
	});
	
	$('#slide7 .next_panel').click(function(){
		$('#tour_container').animate({right: '0'});
		$('.tour_hero .prev_slide').addClass('active').fadeIn().animate({left: '950'});
		$('.tour_hero .next_slide').addClass('active').fadeIn().animate({right: '-950'});
		$('#tour_position #position1').addClass('active').siblings().removeClass('active');		
	});
	
		/* Indicator */
		$('#tour_position #position7').click(function(){
			$(this).addClass('active').siblings().removeClass('active');
			$('#tour_container').animate({right: '5700'});
			$('.tour_hero .prev_slide').addClass('active').fadeIn().animate({left: '0'});
			$('.tour_hero .next_slide').addClass('active').fadeIn().animate({right: '0'});
		})
		
		// Dynamic Tour Image Loader Click from Indicator
		$('#tour_position .indicator').click(function(){
			if($('#slide2 .thumb').length == 0) {
				$('#slide2').append('<img src="images/rd/home/tour/tour_accounts.png" class="thumb"/>');
				$('#slide3').append('<img src="images/rd/home/tour/tour_transactions.png" class="thumb"/>');
				$('#slide4').append('<img src="images/rd/home/tour/tour_graphs.png" class="thumb"/>');
				$('#slide5').append('<img src="images/rd/home/tour/tour_alerts.png" class="thumb"/>');
				$('#slide6').append('<img src="images/rd/home/tour/tour_pig.png" class="thumb"/>');
				$('#slide7').append('<img src="images/rd/home/tour/tour_lock.png" class="thumb"/>');
			}
		})
		
			
	//Launch Video
	
	$('.launch_video').click(function(){	
		
		if (navigator.mimeTypes ["application/x-shockwave-flash"]==undefined){
			window.open('http://www.youtube.com/watch?v=rK6WLHNYjwM');
			return false;
		}
		
		$('<div id="video_overlay"><iframe title="YouTube video player" class="youtube-player" type="text/html" width="844" height="505" src="https://www.youtube.com/embed/rK6WLHNYjwM?rel=0&amp;hd=1;autoplay=1" frameborder="0" style="display:block; margin-bottom:15px"></iframe></div>').appendTo('body').append('<div class="close"></div>').append('<a class="medium orange button" href="https://wwws.mint.com/login.event?task=S"><span class="get_started">Free! Get started here</span></a>').fadeIn('fast');

		//Append the page transparent overlay
		$('body').append('<div id="page_overlay"></div>');
		
		/* Grab viewport height middle position */ 
		var vph = $(window).height() / 2;
		
		/* Grab viewport width middle position */ 
		var vpw = $(window).width() / 2;
		
		/* Grab overlay height middle position */ 
		var vbh = $('#video_overlay').height() /2;

		/* Grab overlay width middle position */ 
		var vbw = $('#video_overlay').width() /2;
		
		/* Find overlay height middle on screen */ 
		var hoffsetval = vph - vbh - 15 + 'px';
		
		/* Find overlay width middle on screen */ 
		var woffsetval = vpw - vbw - 15 + 'px';
		
		/* Assign top offset to overlay and make visible */ 
		$('#video_overlay').css({'top' : hoffsetval, 'left' : woffsetval,  'visibility': 'visible'});
		return false
	});	

	//Launch Security Video
	
	$('.launch_security_video').click(function(){	

		if (navigator.mimeTypes ["application/x-shockwave-flash"]==undefined){
			window.open('http://www.youtube.com/watch?v=go5YnAlp0iw');
			return false;
		}
	
		$('<div id="video_overlay"><iframe title="YouTube video player" class="youtube-player" type="text/html" width="700" height="550" src="https://www.youtube.com/embed/go5YnAlp0iw?rel=0&amp;hd=1;autoplay=1" frameborder="0" style="display:block; margin-bottom:15px"></iframe></div>').appendTo('body').append('<div class="close"></div>').append('<a class="medium orange button" href="https://wwws.mint.com/login.event?task=S"><span class="get_started">Free! Get started here</span></a>').fadeIn('fast');
		
		//Append the page transparent overlay
		$('body').append('<div id="page_overlay"></div>');
		
		/* Grab viewport height middle position */ 
		var vph = $(window).height() / 2;
		
		/* Grab viewport width middle position */ 
		var vpw = $(window).width() / 2;
		
		/* Grab overlay height middle position */ 
		var vbh = $('#video_overlay').height() /2;

		/* Grab overlay width middle position */ 
		var vbw = $('#video_overlay').width() /2;
		
		/* Find overlay height middle on screen */ 
		var hoffsetval = vph - vbh - 15 + 'px';
		
		/* Find overlay width middle on screen */ 
		var woffsetval = vpw - vbw - 15 + 'px';
		
		/* Assign top offset to overlay and make visible */ 
		$('#video_overlay').css({'top' : hoffsetval, 'left' : woffsetval,  'visibility': 'visible'});
		return false
	});	
	
	//Launch How-To Video
	
	$('.launch_how-to_video').click(function(){
		var videoURL = $(this).find('a').attr('href');
		
		if (navigator.mimeTypes ["application/x-shockwave-flash"]==undefined){
			window.open(videoURL);
			return false;
		}
	
		$('<div id="video_overlay"><iframe title="YouTube video player" class="youtube-player" type="text/html" width="844" height="505" src="' + videoURL + '?hd=1;autoplay=1" frameborder="0" style="display:block; margin-bottom:15px"></iframe></div>').appendTo('body').append('<div class="close"></div>').append('<a class="medium orange button" href="https://wwws.mint.com/login.event?task=S"><span class="get_started">Free! Get started here</span></a>').fadeIn('fast');
		
		//Append the page transparent overlay
		$('body').append('<div id="page_overlay"></div>');
		
		/* Grab viewport height middle position */ 
		var vph = $(window).height() / 2;
		
		/* Grab viewport width middle position */ 
		var vpw = $(window).width() / 2;
		
		/* Grab overlay height middle position */ 
		var vbh = $('#video_overlay').height() /2;

		/* Grab overlay width middle position */ 
		var vbw = $('#video_overlay').width() /2;
		
		/* Find overlay height middle on screen */ 
		var hoffsetval = vph - vbh - 15 + 'px';
		
		/* Find overlay width middle on screen */ 
		var woffsetval = vpw - vbw - 15 + 'px';
		
		/* Assign top offset to overlay and make visible */ 
		$('#video_overlay').css({'top' : hoffsetval, 'left' : woffsetval,  'visibility': 'visible'});
		return false
	});	

	//Launch Community Video
	
	$('.launch_community_video').click(function(){
		var videoURL = $(this).find('a').attr('href');
		
		if (navigator.mimeTypes ["application/x-shockwave-flash"]==undefined){
			window.open(videoURL);
			return false;
		}
	
		$('<div id="video_overlay"><iframe title="YouTube video player" class="youtube-player" type="text/html" width="844" height="505" src="' + videoURL + '?hd=1;autoplay=1" frameborder="0" style="display:block; margin-bottom:15px"></iframe></div>').appendTo('body').append('<div class="close"></div>').append('<a class="medium orange button" href="https://wwws.mint.com/login.event?task=S"><span class="get_started">Free! Get started here</span></a>').fadeIn('fast');
		
		//Append the page transparent overlay
		$('body').append('<div id="page_overlay"></div>');
		
		/* Grab viewport height middle position */ 
		var vph = $(window).height() / 2;
		
		/* Grab viewport width middle position */ 
		var vpw = $(window).width() / 2;
		
		/* Grab overlay height middle position */ 
		var vbh = $('#video_overlay').height() /2;

		/* Grab overlay width middle position */ 
		var vbw = $('#video_overlay').width() /2;
		
		/* Find overlay height middle on screen */ 
		var hoffsetval = vph - vbh - 15 + 'px';
		
		/* Find overlay width middle on screen */ 
		var woffsetval = vpw - vbw - 15 + 'px';
		
		/* Assign top offset to overlay and make visible */ 
		$('#video_overlay').css({'top' : hoffsetval, 'left' : woffsetval,  'visibility': 'visible'});
		return false
	});	
	
	//Close Video
	$('#video_overlay .close').live('click', function(){
		$(this).parent().fadeOut('fast', function(){
			$('#video_overlay').remove();
		});
		$('#page_overlay').fadeOut('fast', function(){
			$(this).remove();
		});		
	})
	
	$(document).click(function(){
	    if($('#video_overlay').is(':visible')){
	    	$('#video_overlay').fadeOut('fast', function(){
	    		$('#video_overlay').remove();
	    	});
			$('#page_overlay').fadeOut('fast', function(){
				$(this).remove();
			});		
	    }
	})
	
	/* Accolades */
	
	/* Toggle Panels */
	$('.show_more_button').toggle(function(){	
		if($.browser.msie){
	    	$(this).parent().parent().find('.hidden').show().css({visibility : 'visible'});
		}
		else{
	    	$(this).parent().parent().find('.hidden').slideDown().css({opacity: 0, visibility : 'visible'}).animate({opacity : '1'});
	    }
	    var title = $(this).parent().parent().find('h3').html().toLowerCase();
	    $(this).html('See less ' + title).addClass('open');
	    },
	    function()	{
	    	if($.browser.msie){
	    		$(this).parent().parent().find('.hidden').hide();
	    	}
	    	else{
	    		$(this).parent().parent().find('.hidden').animate({opacity : '0'}).slideUp();
	    	}
	    	var title = $(this).parent().parent().find('h3').html().toLowerCase();
	    	$(this).html('See more ' + title).removeClass('open');
	    }
	);
	
	/* Launch Mini Video Popup */
	$('.video_popup').click(function(){
		var videoURL = $(this).attr('href');
		
		if (navigator.mimeTypes ["application/x-shockwave-flash"]==undefined){
			return false;
		}
		
		$('<div id="video_overlay"><iframe title="YouTube video player" class="youtube-player" type="text/html" width="844" height="505" src="' + videoURL + '?hd=1;autoplay=1" frameborder="0" style="display:block; margin-bottom:15px"></iframe></div>').appendTo('body').append('<div class="close"></div>').append('<a class="medium orange button" href="https://wwws.mint.com/login.event?task=S"><span class="get_started">Free! Get started here</span></a>').fadeIn('fast');

		//Append the page transparent overlay
		$('body').append('<div id="page_overlay"></div>');
		
		/* Grab viewport height middle position */ 
		var vph = $(window).height() / 2;
		
		/* Grab viewport width middle position */ 
		var vpw = $(window).width() / 2;
		
		/* Grab overlay height middle position */ 
		var vbh = $('#video_overlay').height() /2;

		/* Grab overlay width middle position */ 
		var vbw = $('#video_overlay').width() /2;
		
		/* Find overlay height middle on screen */ 
		var hoffsetval = vph - vbh + 'px';
		
		/* Find overlay width middle on screen */ 
		var woffsetval = vpw - vbw + 'px';
		
		/* Assign top offset to overlay and make visible */ 
		$('#video_overlay').css({'top' : hoffsetval, 'left' : woffsetval,  'visibility': 'visible'});
		return false
	});
	
	//Grab mintlife json feed for news updates
	
	if($('.news_updates').length){
		$.getJSON('https://www.mint.com/blog/feed/service/?tag=&cat=Updates&count=20&orderby=desc&callback=?', function(data){	
			$.each(data.posts, function(i,post){
			
				var date = new Date(post.published);
				var month = date.getMonth() + 1;
				var day = date.getDate();
				var year = date.getFullYear();
				
				if(i < 5) {
					$('.news_updates .initial').append('<div class="entry clearfix"><div class="news_date">' + month + '/' + day + '/' + year + '</div><div class="news_item"><a href="' + post.link + '">' + post.title + '</a></div></div>');
				}
				else {
					$('.news_updates .hidden').append('<div class="entry clearfix"><div class="news_date">' + month + '/' + day + '/' + year + '</div><div class="news_item"><a href="' + post.link + '">' + post.title + '</a></div></div>');
				}
			})
		})
	}
	
	//Grab twitter json feed for news updates
	
	if($('.news_updates').length){
		$.getJSON('https://twitter.com/status/user_timeline/mint.json?count=15&callback=?', function(data){	
			$.each(data, function(i,post){
				
				// convert to local string and remove seconds and year //		
				var timestamp = post.created_at;
				var newtext = timestamp.replace(/(\+\S+) (.*)/, '$2 $1')
				var date = new Date(newtext);
				var month = date.getMonth() + 1;
				var day = date.getDate();
				var year = date.getFullYear();
				
				if(i < 5) {
				$('.news_tweets .initial').append('<div class="entry clearfix"><div class="news_date">' + month + '/' + day + '/' + year + '</div><div class="news_item"><a href="https://www.twitter.com/mint/">' + post.text + '</a></div></div>');
				}
				else {
					$('.news_tweets .hidden').append('<div class="entry clearfix"><div class="news_date">' + month + '/' + day + '/' + year + '</div><div class="news_item"><a href="https://www.twitter.com/mint/">' + post.text + '</a></div></div>');
				}
			})
		})
	}
	
	// Tax Legalese Popup
	$('.tax_popup').click(function(){
		$('<div id="tax_popup"><h1 style="font-size: 22px">*Maximum (Biggest) Refund Guaranteed or Your Money Back</h1><p class="nowrap">If you get a larger refund or smaller tax due from another tax preparation method, we\'ll refund the applicable <br/>TurboTax federal and\/or state purchase price paid. TurboTax Online Federal Free Edition customers are entitled <br/>to payment of $14.95 and a refund of your state purchase price paid**.</p><hr/><p>**Claims must be submitted within sixty (60) days of your TurboTax filing date and no later than 6/18/11. <br/>E-file, Audit Defense, Professional Review, Ask a Tax Expert, Refund Transfer and technical support fees are <br/>excluded. This guarantee cannot be combined with the TurboTax Satisfaction (Easy) Guarantee.</p></div>').appendTo('body').append('<div class="close"></div>').fadeIn('fast');
		
		//Append the page transparent overlay
		$('body').append('<div id="page_overlay"></div>');
				
		/* Grab viewport height middle position */ 
		var vph = $(window).height() / 2;
		
		/* Grab viewport width middle position */ 
		var vpw = $(window).width() / 2;
		
		/* Grab overlay height middle position */ 
		var vbh = $('#tax_popup').height() /2;

		/* Grab overlay width middle position */ 
		var vbw = $('#tax_popup').width() /2;
		
		/* Find overlay height middle on screen */ 
		var hoffsetval = vph - vbh + 'px';
		
		/* Find overlay width middle on screen */ 
		var woffsetval = vpw - vbw + 'px';
		
		/* Assign top offset to overlay and make visible */ 
		$('#tax_popup').css({'top' : hoffsetval, 'left' : woffsetval,  'visibility': 'visible'});
		return false
	});
	
	//Close Tax Popup
	$('#tax_popup .close').live('click', function(){
		$(this).parent().fadeOut('fast', function(){
			$('#tax_popup').remove();
		});
		$('#page_overlay').fadeOut('fast', function(){
			$(this).remove();
		});		
	})
	
	$(document).click(function(){
	    if($('#tax_popup').is(':visible')){
	    	$('#tax_popup').fadeOut('fast', function(){
	    		$('#tax_popup').remove();
	    	});
			$('#page_overlay').fadeOut('fast', function(){
				$(this).remove();
			});		
	    }
	})
	
	/* Education Feed */
	if($('body#education').length){
		$.getJSON('https://www.mint.com/blog/feed/service/?tag=education&count=6&orderby=desc&callback=?', function(data){	
			
			/* Create an array for the post categories */
			var catArray = new Array();
			
			$.each(data.posts, function(i,post){
				
				/* Loop through each category */
				$.each(post.categories, function(j,category){
				    
				    /* Construct a link for each category and push it to the array */
				    catArray.push('<a href="http://www.mint.com/blog/category/' + category.category_nicename + '">' + category.cat_name + '</a>');
				});
				
				/* Join each category array element with a comma */
				var cats = catArray.join(', ');
				
				/* Ensure HTTPS image reference */
				var image = post.thumbnail.replace('http', 'https');
				
				$('.left.column .articles').append('<div class="article clearfix"><div class="thumb"><img src="' + image + '"/></div><div class="category">' + cats + '</div><div class="title"><a href="' + post.link + '">' + post.title + '</a></div><div class="date">' + post.published + '</div></div>');
				
				/* Clear Array before each loop */
				catArray = [];
			})
		})
	}
	
	/* Launch Education Game */
	$('.launch_game').click(function(){
		$('<div id="video_overlay"><iframe src="https://stage-www.mint.com/wp-content/themes/mint7/games/questformoney/mint_dot_com.swf" width="800px" height="600px"></iframe></div>').appendTo('body').append('<div class="close"></div>').show();
		
		//Append the page transparent overlay
		$('body').append('<div id="page_overlay"></div>');
		
		/* Grab viewport height middle position */ 
		var vph = $(window).height() / 2;
		
		/* Grab viewport width middle position */ 
		var vpw = $(window).width() / 2;
		
		/* Grab overlay height middle position */ 
		var vbh = $('#video_overlay').height() /2;

		/* Grab overlay width middle position */ 
		var vbw = $('#video_overlay').width() /2;
		
		/* Find overlay height middle on screen */ 
		var hoffsetval = vph - vbh - 15 + 'px';
		
		/* Find overlay width middle on screen */ 
		var woffsetval = vpw - vbw - 15 + 'px';
		
		/* Assign top offset to overlay and make visible */ 
		$('#video_overlay').css({'top' : hoffsetval, 'left' : woffsetval,  'visibility': 'visible'});
		return false
	})	
	
	//Launch Quest Video
	
	$('.launch_quest_video').click(function(){	
		
		if (navigator.mimeTypes ["application/x-shockwave-flash"]==undefined){
			window.open('http://www.youtube.com/watch?v=rK6WLHNYjwM');
			return false;
		}
		
		$('<div id="video_overlay"><iframe title="YouTube video player" class="youtube-player" type="text/html" width="844" height="505" src="https://www.youtube.com/embed/a8BYVLc8Ev4?rel=0&amp;hd=1;autoplay=1" frameborder="0" style="display:block; margin-bottom:15px"></iframe></div>').appendTo('body').append('<div class="close"></div>').append('<a class="medium orange button" href="https://wwws.mint.com/login.event?task=S"><span class="get_started">Free! Get started here</span></a>').fadeIn('fast');

		//Append the page transparent overlay
		$('body').append('<div id="page_overlay"></div>');
		
		/* Grab viewport height middle position */ 
		var vph = $(window).height() / 2;
		
		/* Grab viewport width middle position */ 
		var vpw = $(window).width() / 2;
		
		/* Grab overlay height middle position */ 
		var vbh = $('#video_overlay').height() /2;

		/* Grab overlay width middle position */ 
		var vbw = $('#video_overlay').width() /2;
		
		/* Find overlay height middle on screen */ 
		var hoffsetval = vph - vbh - 15 + 'px';
		
		/* Find overlay width middle on screen */ 
		var woffsetval = vpw - vbw - 15 + 'px';
		
		/* Assign top offset to overlay and make visible */ 
		$('#video_overlay').css({'top' : hoffsetval, 'left' : woffsetval,  'visibility': 'visible'});
		return false
	});	
})