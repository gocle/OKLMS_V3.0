$(function(){
	nav();
});


function nav(){	
	//모바일메뉴	
	$M_lnb = $('#m_lnb_wrap');
	
	$(window).resize(function(){
		//win_h = $('body').height();
		//$M_lnb.css('height',win_h-80);
		
	}).resize();	

	$('.m_show').click(function(){
		$M_lnb.fadeIn(100);
		//$('#m_lnb_wrap .mnbox').slideDown();
		$(this).fadeOut(100);
		$('.m_closed').fadeIn(100);
		//$('#wrapper .dim').fadeIn(100);
	});

	$('.m_closed').click(function(){
		$M_lnb.fadeOut();
		$(this).fadeOut(100);
		$('.m_show').fadeIn(100);
		//$('#wrapper .dim').fadeOut(100);
	});
	
	

	$(window).resize(function(){
		//$M_lnb.fadeOut(100);
		//$('.m_closed').fadeOut(100);
		//$('.m_show').fadeIn(100);
		
		 // width값을 가져오기
		var windowWidth = $( window ).width();
		if(windowWidth < 1200) {
			$M_lnb.fadeOut(100);
			$('.m_closed').fadeOut(100);
			$('.m_show').fadeIn(100);
			//$('#content-area-layout').click(function(){
				//$M_lnb.fadeOut();
				//$('.m_show').fadeIn(100);
				//$('.m_closed').fadeOut(100);
			//});
		} else {
			$M_lnb.fadeIn(100);
			//$('#content-area-layout').click(function(){
				//$('#m_lnb_wrap').show();
			//});
			
		}
	});
}