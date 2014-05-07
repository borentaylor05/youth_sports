function newParentValidate(){
	$("#new_parent").validate({
		rules: {
			"parent[firstName]": {
				required: true
			},
			"parent[lastName]": {
				required: true
			},
			"parent[email]": {
				required: true,
				email: true
			},
			"parent[phone]": {
				required: true
			},
			"parent[password]": {
				required: true,
				minlength: 6
			},
			"parent[password_confirmation]": {
				required: true,
				equalTo: "#parent_password"
			}
		},
		errorPlacement: function(error, element) {
            error.insertBefore(element);
        }
	});
}

function newSessionValidate(){
	$("#new_session").validate({
		rules: {
			"session[email]": {
				required: true
			},
			"session[password]": {
				required: true
			}
		},
		submitHandler: function(data){
			$.ajax({
				url: '/sessions',
				method: 'POST',
				data: $("#new_session").serialize(),
				success: function(data){
					console.log(data);
				},
				error: function(e){
					alert("Error Signing In!");
				}
			});
		},
		errorPlacement: function(error, element) {
            error.insertBefore(element);
        }
	});
}