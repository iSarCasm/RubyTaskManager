$(document).ready(function() {
	var errTime = 0;

	// LOGOUT
	$('.logout').click(function(){
		$(this).fadeOut(1000);
		$('.projects').fadeOut(1000, function(){
			$('.projects').remove();
			$('.omniauth').find('div').fadeIn(300);
		})
	});

	// SHOW new project input text field
	$('#new_project_button').click(function(){
    var field = $('#project_name');
    if (field.css('display') == 'none')
    {
    	event.preventDefault();
    	// SHOW
	    field.css({'display':'inline-block','width':'0px'});
	    field.animate({'width':'600px'},300);
	    field.focus();
	  } else {
	  	// HIDE
	  	var len = field.val().length;
	  	if(len>0 && len<=100) {
	  		field.animate({'width':'0px'},300);
		  	setTimeout(function() {
		  		field.css({'display':'none'});
		  		field.val('');
		  	}, 300);
	  	} else {
	  		event.preventDefault();
	  		if(len<=0) {
		  		showError("Project title cant be blank!");
	  		} else {
	  			showError("Maximum project title length is 100!");
	  		}
		  }
	  }
	});

	$('.project_title_save').click(function(){
		var len = $(this).parents(".project_title_edit").find('input:text').val().length;
		if(len>0 && len<=100) {
			$(this).parents("tr").find('.project_title').css({'display':'inline'});
			$(this).parents(".project_title_edit").css({'display':'none'});
			// pre-change content
			$(this).parents('td').find('.project_title').find('span').text($(this).parents(".project_title_edit").find('input:text').val());
		} else {
				event.preventDefault();
	  		if(len<=0) {
		  		showError("Project title cant be blank!");
	  		} else {
	  			showError("Maximum project title length is 100!");
	  		}
		  }
	});

	$('.project_edit_button').click(function(){
		//project edit
		$(this).parents("tr").find('.project_title_edit').css({'display':'block'});
		$(this).parents("tr").find('.project_title').css({'display':'none'});
		$(this).parents("tr").find('.project_title_edit').find('input:text').focus();
		var strLength = $(this).parents("tr").find('.project_title_edit').find('input:text').val().length * 2;
		$(this).parents("tr").find('.project_title_edit').find('input:text')[0].setSelectionRange(strLength, strLength);
		
	});

	$('.task_edit_button').click(function(){
		$(this).parents("tr").find('.task_title_edit').css({'display':'block'});
		$(this).parents("tr").find('.task_title').css({'display':'none'});
		$(this).parents("tr").find('.task_title_edit').find('input:text').focus()
		var strLength = $(this).parents("tr").find('.task_title_edit').find('input:text').val().length * 2;
		$(this).parents("tr").find('.task_title_edit').find('input:text')[0].setSelectionRange(strLength, strLength);
	});

	$('.task_title_save').click(function(){
		var len = $(this).parents(".task_title_edit").find('input:text').val().length;
		if(len>0 && len<=100) {
			$(this).parents("tr").find('.task_title').css({'display':'inline'});
			$(this).parents(".task_title_edit").css({'display':'none'});
			// pre-change content
			$(this).parents('td').find('.task_title').find('span').text($(this).parents(".task_title_edit").find('input:text').val());
		} else {
			event.preventDefault();
			if(len<=0) {
		  		showError("Task cant be blank!");
	  		} else {
	  			showError("Maximum task length is 100!");
	  		}
		}
	});

	$('.task_add_submit').click(function(){
		var len = $(this).parents(".task-add").find('input:text').val().length;
		if(len>0 && len<=100) {
			
		} else {
			event.preventDefault();
			if(len<=0) {
		  		showError("Task cant be blank!");
	  		} else {
	  			showError("Maximum task length is 100!");
	  		}
		}
	});

	$('.task_done').change(function(){
		var val = $(this).parents('td').find('.checkbox_value');
		if($(this).is(":checked")) {
			val.val('true');
		} else {
			val.val('false');
		}
		$(this).parents('td').find(':submit').submit();
	});


	$('.deadline_close').click(function(){
		$(this).parents('.front-window').fadeOut(300);
	});
	$('.deadline_sub').click(function(){
		var id = $(this).siblings('.hidden').text();
		x= $('#task'+id.toString()).find('.icon_date');
		x.removeClass('icon-date');
		x.addClass('icon-date-active');
		var y = $('#task'+id.toString()).find('.icon_date').find('.ion-calendar');	
		y.hide();
		$(this).parents('.front-window').fadeOut(300, function(){
			y.removeAttr('style');
		});
	});
	
	$('.icon_date').click(function(){
		var id = $(this).find('.hidden').text();
		$('#front_window_'+id.toString()).css({'display':'flex'}).hide().fadeIn(300);
	});

	// $('.task_add_submit').click(function(){
	// 	var input = $(this).parents('.task-add').find('input:text');
	// 	setTimeout(function(){
	// 		input.val('');
	// 	}, 300);
	// });
	var showError = function(text) {
		clearTimeout(errTime);
		var not = $('#notify')
		var not_title = $('.notify-text');
		not.css({'right':'-310px'});
		not_title.text(text);
		not.animate({'right':'0px'},200);
		errTime = setTimeout(function(){
			not.animate({'right':'-310px'},100);
		},3000);
	};

});