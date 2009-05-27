// application js file
window.addEvent('domready', function() {
	
	if ($("flight_co2_calculation_from_airport")){
		var complete = new Autocompleter.Ajax.Json($('flight_co2_calculation_from_airport'), '/airports/search.json', {
			postcode: true,
			minLength: 3,
		  postVar: 'airport',
		  postData: {}, //additional key/value sets to send with the request
		    ajaxOptions: {method: "get", 
					onRequest: function(){
						// Ajax indicator basically
				}, onFailure: function(){
						// tell user failure hmm
				},
					onComplete: function(){
						// hide the ajax
					}},
			overflow: true,
			injectChoice: function(token) { 
				if (token.error_code) {
					// could not find the one we were looking for
				} else{
					var choice = new Element('li', { html: this.markQueryValue(token.address) }); 
					choice.value = token.id; 
					choice.inputValue = token.address; 
					this.addChoiceEvents(choice).inject(this.choices);
				}
				},

			onSelection: function(el, sel) { 
				$("flight_co2_calculation_from_airport_id").set('value', sel.value); 
					// set the correct airport id then so we can get the iata code
				}
			}).observer.addEvent('onFired', function(val) { 
					if(!val) $("flight_co2_calculation_from_airport_id").set('value', ''); 
				});
	}
	
	
	if ($("flight_co2_calculation_to_airport")){
		var complete = new Autocompleter.Ajax.Json($('flight_co2_calculation_to_airport'), '/airports/search.json', {
			postcode: true,
			minLength: 3,
		  postVar: 'airport',
		  postData: {}, //additional key/value sets to send with the request
		    ajaxOptions: {method: "get", 
					onRequest: function(){
						// Ajax indicator basically
				}, onFailure: function(){
						// tell user failure hmm
				},
					onComplete: function(){
						// hide the ajax
					}},
			overflow: true,
			injectChoice: function(token) { 
				if (token.error_code) {
					// could not find the one we were looking for
				} else{
					var choice = new Element('li', { html: this.markQueryValue(token.address) }); 
					choice.value = token.id; 
					choice.inputValue = token.address; 
					this.addChoiceEvents(choice).inject(this.choices);
				}
				},

			onSelection: function(el, sel) { 
				$("flight_co2_calculation_to_airport_id").set('value', sel.value); 
				}
			}).observer.addEvent('onFired', function(val) { 
					// reset to empty if there is no val
					if(!val) $("flight_co2_calculation_to_airport_id").set('value', ''); 
				});
	}
});
