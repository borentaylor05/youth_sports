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