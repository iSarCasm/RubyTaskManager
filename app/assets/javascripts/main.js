$(document).ready(function() {
	var errTime = 0; // TimeOut variable for error notification
	var errorField;  // Field which is highlighted because of error

	// LOGOUT
	$('.logout').click(function(){
		$(this).fadeOut(1000);
		$('.projects').fadeOut(1000, function(){
			$('.projects').remove();
			$('.omniauth').find('div').fadeIn(300); // login
		})
	});

	// SHOW new project input text field
	$('#new_project_button').click(function(event){
    var field = $('#project_name');
    if (field.css('display') == 'none')
    {
    	event.preventDefault();
    	// SHOW
			hideError();
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
		  		showError("Project title cant be blank!",field);
	  		} else {
	  			showError("Maximum project title length is 100!",field);
	  		}
		  }
	  }
	});

	$('#projects').on('click','.project_title_save',function(event){
		var field = $(this).parents(".project_title_edit").find('input:text'),
				len = field.val().length;
		if(len>0 && len<=100) {
			hideError();
			$(this).parents("tr").find('.project_title').css({'display':'inline'});
			$(this).parents(".project_title_edit").css({'display':'none'});
			// pre-change content (change before AJAX)
			$(this).parents('td').find('.project_title').find('span').text(field.val());
		} else {
				event.preventDefault();
	  		if(len<=0) {
		  		showError("Project title cant be blank!",field);
	  		} else {
	  			showError("Maximum project title length is 100!",field);
	  		}
		  }
	});

	$('#projects').on('click','.project_edit_button',function(){
		//project edit
		var pr_edit = $(this).parents("tr").find('.project_title_edit');
		pr_edit.css({'display':'block'});
		$(this).parents("tr").find('.project_title').css({'display':'none'});
		pr_edit.find('input:text').focus();
		var strLength = pr_edit.find('input:text').val().length * 2;
		pr_edit.find('input:text')[0].setSelectionRange(strLength, strLength);

	});

	$('#projects').on('click','.task_edit_button',function(){
		var ts_edit = $(this).parents("tr").find('.task_title_edit');
	ts_edit.css({'display':'block'});
		$(this).parents("tr").find('.task_title').css({'display':'none'});
	ts_edit.find('input:text').focus()
		var strLength = $(this).parents("tr").find('.task_title_edit').find('input:text').val().length * 2;
	ts_edit.find('input:text')[0].setSelectionRange(strLength, strLength);
	});

	$('#projects').on('click','.task_title_save',function(event){
		var field = $(this).parents(".task_title_edit").find('input:text'),
				len = field.val().length;
		if(len>0 && len<=100) {
			hideError();
			$(this).parents("tr").find('.task_title').css({'display':'inline'});
			$(this).parents(".task_title_edit").css({'display':'none'});
			// pre-change content
			$(this).parents('td').find('.task_title').find('span').text(field.val());
		} else {
			event.preventDefault();
			if(len<=0) {
		  		showError("Task cant be blank!",field);
	  		} else {
	  			showError("Maximum task length is 100!",field);
	  		}
		}
	});

	$('#projects').on('click','.task_add_submit',function(event){
		var field = $(this).parents(".task-add").find('input:text'),
				len = field.val().length;
		if(len>0 && len<=100) {
			hideError();
		} else {
			event.preventDefault();
			if(len<=0) {
		  		showError("Task cant be blank!",field);
	  		} else {
	  			showError("Maximum task length is 100!",field);
	  		}
		}
	});

	$('#projects').on('change','.task_done',function(){
		var val = $(this).parents('td').find('.checkbox_value');
		if($(this).is(":checked")) {
			val.val('true');
			$(this).parents("tr").addClass("done-task");
		} else {
			val.val('false');
			$(this).parents("tr").removeClass("done-task");
		}
		$(this).parents('td').find(':submit').submit();
	});


	$('body').on('click','.deadline_close',function(){
		$(this).parents('.front-window').fadeOut(300);
	});
	$('body').on('click','.deadline_sub',function(){
		var id = $(this).parent().parent().find('.hidden').text();
		x= $('#task'+id.toString()).find('.icon_date');
		x.removeClass('icon-date');
		x.addClass('icon-date-active');
		var y = $('#task'+id.toString()).find('.icon_date').find('.ion-calendar');
		y.hide();
		$(this).parents('.front-window').fadeOut(300, function(){
			y.removeAttr('style');
		});
	});

	$('body').on('click','.icon_date',function(){
		var id = $(this).find('.hidden').text();
		$('#front_window_'+id.toString()).css({'display':'flex'}).hide().fadeIn(300);
	});

	// $('.task_add_submit').click(function(){
	// 	var input = $(this).parents('.task-add').find('input:text');
	// 	setTimeout(function(){
	// 		input.val('');
	// 	}, 300);
	// });
	var showError = function(text, f) {
		if(errorField)
			errorField.removeClass("error-field");
		errorField = f;
		errorField.addClass("error-field");
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
	var hideError = function() {
		errorField = null;
	}

});
